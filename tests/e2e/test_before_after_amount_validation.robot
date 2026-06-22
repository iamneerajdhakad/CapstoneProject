*** Settings ***
Resource  ../../resources/pages/login_page.resource
Resource  ../../resources/pages/registration_page.resource
Resource  ../../resources/pages/account_page.resource
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/transfer_page.resource

Suite Setup  Initialize E2E Suite
Suite Teardown  Delete All Sessions
Test Setup  Open Application
Test Teardown  Close Application

*** Keywords ***
Initialize E2E Suite
    Load Environment
    Load Api Environment And Create Session

*** Test Cases ***
TC-E2E-03 UI Fund Transfer → Validate Balance Delta via API
    [Tags]  e2e  smoke
    Login To Application    ${USERNAME}    ${PASSWORD}

    ${number1}=  Open New Account  type=CHECKING
    ${number2}=  Open New Account  type=CHECKING

    ${response1}=  Get Method    /accounts/${number1}
    ${response2}=  Get Method    /accounts/${number2}

    ${body1}=  Set Variable  ${response1.json()}
    ${body2}=  Set Variable  ${response2.json()}

    ${amount_1}=  Get From Dictionary    ${body1}    balance
    ${amount_2}=  Get From Dictionary    ${body2}    balance
    ${amount}=  Set Variable  100

    Transfer Funds  ${number2}  ${number1}  ${amount}
    Page Should Contain    Transfer Complete!
    Validate Transfer Details    ${number2}    ${number1}    ${amount}

    ${response1}=  Get Method    /accounts/${number1}
    ${body}=  Set Variable  ${response1.json()}
    ${after_amount1}=  Get From Dictionary    ${body}    balance
    ${before_amount1}  Evaluate    ${amount_1}+${amount}
    Log To Console    ${before_amount1}
    Log To Console    ${after_amount1}
    Should Be Equal As Integers    ${after_amount1}    ${before_amount1}

    ${response2}=  Get Method    /accounts/${number2}
    ${body}=  Set Variable  ${response2.json()}
    ${after_amount2}=  Get From Dictionary    ${body}    balance
    ${before_amount2}  Evaluate    ${amount_2}-${amount}
    Should Be Equal As Integers    ${after_amount2}    ${before_amount2}
