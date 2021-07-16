### Description ###

* Robot framework for testing web/API
* Newman to run test collection from postman with command line mode

### Installation ###
####Python 3
####NewMan
### Other tools
Go to `scripts` then type:
```
pip3 -r requirements.txt
```
### Run ###
Robotframework (item #6, #7)

```
robot  -d results -v env:env testcases
```

Newman (items #1-3)

```
newman run DemoNewmanWithCollection.postman_collection.json
```

Stop Newman when any assertion fails (item #4)

```
newman run DemoNewmanWithCollection.postman_collection.json --bail
```
