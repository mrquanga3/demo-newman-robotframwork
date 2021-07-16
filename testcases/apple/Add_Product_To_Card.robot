*** Settings ***
Resource            ../../imports.robot
Library              DataDriver     ../../testdata/Products/iphones.xlsx   sheet_name=Sheet1
Test Setup          Open website

Test Teardown       Close Browser
Test Template       7. Add Apple Product

*** Keywords ***
7. Add Apple Product
    [Arguments]     ${btnBuyIphone}      ${fieldIphone}    ${fieldColor}   ${fieldCapacity}    ${fieldCarrier}   ${fieldTradeNo}   ${lblPayment}   ${country}        ${lblIphoneInBag}
    Maximize Browser Window
    Choose Country Name      ${country}
    Choose Product        ${btnBuyIphone}
    Choose Product Type      ${fieldIphone}
    Choose Product Color    ${fieldColor} 
    Choose Product Capacity        ${fieldCapacity} 
    Choose Product Carrier            ${fieldCarrier} 
    Choose Product Trade            ${fieldTradeNo} 
    Choose Product Payment Type     ${lblPayment}
    Add Product To Bag
    Verify Payment Bag               ${lblIphoneInBag}

*** Test Cases ***
TC - ${tcname}