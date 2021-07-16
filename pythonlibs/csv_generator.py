import re
import random
import json
from collections import OrderedDict
from decimal import Decimal, ROUND_HALF_UP

PATTERN_EVAL = r'eval\((.*)\)'

"""
Generate CSV base on a template and value from args dictionary

1. Basic 
    Here is an example template:
    |   {                                                           |
    |       "name": "",                                             |   
    |       "id": "random_int(0, 10)",                              |
    |       "amount": "random_decimal(10.5, 20.5, 1)"               |
    |   }                                                           |
    
    Value of each field can be empty or an <python_expression>
    <python_expression> will be evaluated to generate field if there isn't any provided value from args dict.
    Some available expressions:
        - random_string(size, chars)
        - random_int(min, max)
        - random_bool()
        - random_decimal(min, max, decimal_digits)
        - random_enum(*args)
    
    To provide value for a field, you can use key with format:
        - <field name>[<row index>] (ex: name[0], id[1]) : Provide value for a field at exactly row.
        - <field name> : Provide value for a field at all rows. Will be ignored if more specific key available.
        
    The provided value can be a python evaluation expression.
    Order of fields in CSV file will be same as template.
    
    Here is some csv result generated by above template with different arguments: (the row_num=2)
    
    |       args                            |              result               |
    =============================================================================
    |                                       |   name,id,amount                  |
    |                                       |   ,3,16.7                         |
    |                                       |   ,5,10.8                         |
    =============================================================================
    | "name[0]":"user_1"                    |   name,id,amount                  |
    | "id":"3"                              |   user_1,3,16.7                   |
    |                                       |   ,3,10.8                         |
    =============================================================================
    | "name": eval(random_string(3, 'abc')) |   name,id,amount                  |
    | "$.sof":None                          |   aab,4,16.7                      |
    |                                       |   cab,6,20.0                      |
    
2. Option
- row_num: Number of generated row. Default is 1
"""


def generate_csv(template, args=None, row_num=1):
    schema = json.loads(template, object_pairs_hook=OrderedDict)
    args = args if args is not None else {}
    cols = len(schema)
    result = []
    row_num = int(row_num)

    for col, (key, value) in enumerate(schema.iteritems()):
        result.append(key)
        if col < cols - 1:
            result.append(',')

    for row in range(0, row_num):
        result.append('\n')
        for col, (key, value) in enumerate(schema.iteritems()):
            result.append(str(_get_value(value, args, key, row)))
            if col < cols - 1:
                result.append(',')

    return ''.join(result)


def random_string(size, chars):
    return ''.join(random.choice(chars) for _ in range(size))


def random_int(min, max):
    return random.randint(min, max)


def random_bool():
    return random_int(0, 1) == 1


def random_decimal(min, max, decimal_digits):
    return _round_decimal(random.uniform(min, max), decimal_digits)


def random_enum(*args):
    index = random_int(0, len(args) - 1)
    return args[index]


def _round_decimal(value, decimal_digits):
    result = Decimal(value)
    exponent = Decimal("%s" % pow(10, -Decimal(decimal_digits)))
    return result.quantize(Decimal(exponent), ROUND_HALF_UP)


def _get_key(args, key, row):
    sub_key = key + "[" + str(row) + "]"
    if sub_key in args:
        return sub_key
    if key in args:
        return key
    return None


def _get_value_from_args(args, key, row):
    key = _get_key(args, key, row)
    if key is not None:
        value = str(args[key])
        matcher = re.match(PATTERN_EVAL, value)
        if matcher:
            value = eval(matcher.group(1))
        return True, value
    return False, None


def _get_value(expression, args, key, row):
    has_value, value = _get_value_from_args(args, key, row)
    if not has_value:
        if expression != "":
            value = eval(expression)
        else:
            value = ""
    return value
