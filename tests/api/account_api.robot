*** Settings ***
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment And Create Session
Suite Teardown  Delete All Sessions

*** Test Cases ***
TC-API-02 Get Customer Accounts Validate Status Code
    [Tags]  api  regression

    ${response}  Get Method    /customers/${customerId}/accounts
    Validate Status Code    ${response}    200

    ${body}  Set Variable  ${response.json()}
    Log To Console    ${body}

TC-API-03 GET Account Details by ID
    [Tags]  api  regression

    ${account_Id}=  Get Account ID
    ${response}=  Get Method    /accounts/${account_Id}
    Validate Status Code    ${response}    200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}

TC-API-04 GET Transactions for Account ID
    [Tags]  api

    ${response}=  Get Method    /accounts/${accountId}/transactions
    Validate Status Code    ${response}    200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}

TC-API-05 Create CHECKING Account via API
    [Tags]  api  regression

    ${response}=  Create Account via API    CHECKING
    Validate Status Code    ${response}    200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}

TC-API-06 Create SAVINGS Account via API
    [Tags]  api  regression
    ${response}=  Create Account via API    SAVINGS
    Validate Status Code    ${response}    200

    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}

TC-API-07 Create LOAN Account via API
    [Tags]  api
    ${response}=  Create Account via API    LOAN
    Validate Status Code    ${response}    200
    Log To Console    ${response.json()}

TC-API-09 Verify Account Fields and Data Types
    [Tags]  api  regression

    ${response}=  Get method  /customers/${customer_id}/accounts
    Validate Status Code    ${response}    200
    ${body}=  Set Variable  ${response.json()}

    FOR  ${account}  IN  @{body}
        ${id}=  Get From Dictionary    ${account}    id
        ${customer_id}=  Get From Dictionary    ${account}    customerId
        ${type}=  Get From Dictionary    ${account}    type
        ${balance}=  Get From Dictionary    ${account}    balance

       Should Be True    ${id}>0
       Should Be True    ${customer_id}>0
       Should Contain    ['CHECKING','SAVINGS','LOAN']    ${type}
       Should Be True    isinstance(${balance},(int,float))
    END

