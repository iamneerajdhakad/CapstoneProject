*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  ../../config/environment.py

*** Variables ***
${API_SESSION}  parabank
${ENV}  qa
${customerId}  12212
${accountId}  13344

*** Keywords ***
Clean DB
    # used static URL because in UI registration test case we need to clean the DB first and hence it should work without API Environment
    Create Session    ${API_SESSION}    https://parabank.parasoft.com/parabank/services/bank/  verify=false
    POST On Session  ${API_SESSION}  /cleanDB

Load Api Environment And Create Session
    Load Env    ${ENV}
    ${api_url}  Get Env    api_url
    ${username}  Get Env    username
    ${password}  Get Env    password

    Set Global Variable    ${API_URL}  ${api_url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

    Create API Session

Create API Session
    [Documentation]  opens the browser
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    Create Session    ${API_SESSION}    ${API_URL}  headers=${headers}  verify=false


Get Method
    [Arguments]  ${endpoints}
    ${response}=  GET On Session  ${API_SESSION}  ${endpoints}  expected_status=any
    RETURN  ${response}

Post Method
    [Arguments]  ${endpoints}  ${payload}
    ${response}=  POST On Session  ${API_SESSION}  ${endpoints}  params=${payload}
    RETURN  ${response}

Create Account via API
    [Arguments]  ${type}
    IF    '${type}' == 'CHECKING'
        ${number}=    Set Variable    0
    ELSE IF    '${type}' == 'SAVINGS'
        ${number}=    Set Variable    1
    ELSE IF    '${type}' == 'LOAN'
        ${number}=    Set Variable    2
    ELSE
        Fail
    END
    ${payload}=  Create Dictionary
    ...  customerId=${customerId}
    ...  newAccountType=${number}
    ...  fromAccountId=${accountId}

    ${response}=  Post Method    /createAccount    ${payload}

    RETURN  ${response}

Get Account ID
    ${response}  Get Method    /customers/${customerId}/accounts
    ${body}  Set Variable  ${response.json()}
    Validate Status Code    ${response}    200
    ${account_Id}=  Get From Dictionary  ${body}[0]  id
    RETURN  ${account_Id}
    
Validate Response Time
    [Arguments]    ${response}    ${max_ms}=2000

    ${response_time}=    Evaluate
    ...    int($response.elapsed.total_seconds() * 1000)

    Log To Console
    ...    Response Time: ${response_time} ms

    ${valid}=   Run Keyword And Return Status  Should Be True  ${response_time} < ${max_ms}
    
    IF    ${valid}
        Log    ${response_time}
    ELSE
        Fail
    END
    
Validate Status Code
    [Arguments]  ${response}  ${expected}
    Should Be Equal As Integers    ${response.status_code}    ${expected}
