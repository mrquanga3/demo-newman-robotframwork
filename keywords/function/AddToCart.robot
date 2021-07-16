*** Settings ***
Resource            ../../imports.robot

*** Keywords ***

Choose Country Name
    [Arguments]     ${country}
    Go To       ${url}/choose-country-region/
    Choose Option For Product       xpath=//span[normalize-space()='${country}']

Choose Product
    [Arguments]     ${btnBuy}
    Choose Option For Product              ${btnBuy}

Choose Product Type
    [Arguments]     ${productType}
    Choose Option For Product       ${productType}

Choose Product Color
    [Arguments]     ${fieldColor}
    JS Click Element        ${fieldColor}

Choose Product Capacity
    [Arguments]     ${fieldCapacity}
    Js Scroll Up
    Choose Option For Product       ${fieldCapacity}

Choose Product Carrier
    [Arguments]     ${fieldChooseCarrier}
    Js Scroll Up
    Js Click Element       ${fieldChooseCarrier}

Choose Product Trade
    [Arguments]     ${fieldTradeNo}
    Js Scroll Up
    JS Click Element       ${fieldTradeNo}

Choose Product Payment Type
    [Arguments]     ${lblPaymentType}
    Js Scroll Up
    JS Click Element       ${lblPaymentType}

Add Product To Bag
    Choose Option For Product       ${btnAddToBag}

Verify Payment Bag
    [Arguments]     ${lblProductInBag}
    Wait Until Page Contains Element     ${lblProductInBag}     ${min_time_out}
    Element Should Be Visible       ${lblProductInBag}          ${min_time_out}
