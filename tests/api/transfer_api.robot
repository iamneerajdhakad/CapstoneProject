*** Settings ***
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment And Create Session
Suite Teardown  Delete All Sessions

*** Test Cases ***
TC-API-08 Transfer Funds via API
    [Tags]  api  regression  smoke
    ${response1}=  Create Account via API    CHECKING
    Should Be Equal As Integers    ${response1.status_code}    200
    
    ${response2}=  Create Account via API    SAVINGS
    Should Be Equal As Integers    ${response2.status_code}    200

    ${body1}  Set Variable  ${response1.json()}
    ${body2}  Set Variable  ${response2.json()}

    ${fromAccountId}=  Get From Dictionary    ${body1}    id
    ${toAccountId}=  Get From Dictionary    ${body2}    id
    ${amount}=  Set Variable  100

    ${payload}=  Create Dictionary
    ...  fromAccountId=${fromAccountId}
    ...  toAccountId=${toAccountId}
    ...  amount=${amount}

    ${response}=  Post Method    /transfer    ${payload}
    Should Be Equal As Integers    ${response.status_code}    200

    # response doesnot return a json format hence we use text
    ${body}  Set Variable  ${response.text}
    Log To Console    ${body}
