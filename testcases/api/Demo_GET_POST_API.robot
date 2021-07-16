*** Settings ***
Library  RequestsLibrary
Library    Collections
Resource            ../../imports.robot

Suite Setup    Create Session  jsonplaceholder      ${api_url}    verify=true

*** Test Cases ***
TC_5_Demo_GET_API
    ${resp}=     GET On Session  jsonplaceholder  /users
    Should Be Equal As Integers    ${resp.status_code}     200
    ${contentType}=     Get From Dictionary  ${resp.headers}     Content-Type
    Should Be Equal As Strings      ${contentType}     application/json; charset=utf-8

TC_6_Demo_POST
    ${data}=    Create dictionary       tested=tested
    ${resp}=     POST On Session  jsonplaceholder  /posts  json=${data}
    Status Should Be                 201  ${resp}
    Dictionary Should Contain Key   ${resp.json()}  tested
    Should Be Equal As Integers      ${resp.status_code}      201
    ${contentType}=     Get From Dictionary  ${resp.headers}     Content-Type
    Should Be Equal As Strings     ${contentType}     application/json; charset=utf-8
