*** Settings ***
Resource            ../../imports.robot

*** Keywords ***
Open website
        Open Browser        ${url}           ${webdriver}
        Set Window Size     1200             1000
        Maximize Browser Window

Choose Option For Product
    [Arguments]    ${element}
    Wait Until Page Contains Element    ${element}          ${min_time_out}
    Click Element       ${element}

JS Click Element
    [Arguments]    ${element}
    Wait Until Page Contains Element    ${element}      ${min_time_out}
    ${ele}    Get WebElement    ${element}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}

Js Scroll Up
    Execute Javascript    window.scrollTo(0, window.scrollY+1000)