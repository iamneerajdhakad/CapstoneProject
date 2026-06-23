*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  ../../config/environment.py
Library    SeleniumLibrary

*** Variables ***
${API_SESSION}  parabank
${ENV}  qa
${customerId}  12212
${accountId}  13344

*** Keywords ***
Clean DB
    # used static URL because in UI registration test case we need to clean the DB first and hence it should work without API Environment
    Log    Starts cleanings the database
    Create Session    ${API_SESSION}    https://parabank.parasoft.com/parabank/services/bank/  verify=false
    POST On Session  ${API_SESSION}  /cleanDB
    Log    Database Cleaned!

Load Api Environment And Create Session
    Load Env    ${ENV}
    ${api_url}  Get Env    api_url
    ${username}  Get Env    username
    ${password}  Get Env    password

    Set Global Variable    ${API_URL}  ${api_url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

    Log    Loads API Environment

    Log    API session creation starts
    Create API Session
    Log    API session created

Create API Session
    [Documentation]  opens the browser
    Log    API session creation starts
    ${headers}=    Create Dictionary
    ...    Accept=application/json
    Create Session    ${API_SESSION}    ${API_URL}  headers=${headers}  verify=false
    Log    API session created

Get Method
    [Arguments]  ${endpoints}

    Log    Get Request for: ${endpoints}

    ${response}=  GET On Session  ${API_SESSION}  ${endpoints}  expected_status=any
    Log    Status Code: ${response.status_code}
    
    RETURN  ${response}
Post Method
    [Arguments]  ${endpoints}  ${payload}

    Log    Post Request for: ${endpoints}
    Log    Post Request payload : ${payload}

    ${response}=  POST On Session  ${API_SESSION}  ${endpoints}  params=${payload}
    Log    Status Code: ${response.status_code}

    RETURN  ${response}

Create Account via API
    [Arguments]  ${type}

    Log    Account Creation starts of type: ${type}

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
    Log    Status Code: ${response.status_code}

    Log    Account created of type: ${type} payload: ${payload}
    RETURN  ${response}

Get Account ID
    Log    Searching Accounts
    ${response}  Get Method    /customers/${customerId}/accounts
    Log    Status Code: ${response.status_code}
    Validate Status Code    ${response}    200

    ${body}  Set Variable  ${response.json()}
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

Record Page Load Time
    ${load_time}=    Execute Javascript
    ...    return window.performance.timing.loadEventEnd - window.performance.timing.navigationStart

    Log To Console    ${load_time} ms
    Log    Page Load Time: ${load_time} ms

Validate Status Code
    [Arguments]  ${response}  ${expected}
    Should Be Equal As Integers    ${response.status_code}    ${expected}
