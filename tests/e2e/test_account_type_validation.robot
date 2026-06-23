*** Settings ***
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/pages/registration_page.robot
Resource  ../../resources/pages/account_page.robot
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup  Initialize E2E Suite
Suite Teardown  Delete All Sessions
Test Setup  Open Application
Test Teardown  Close Application

*** Keywords ***
Initialize E2E Suite
    Load Environment
    Load Api Environment And Create Session

*** Test Cases ***
TC-E2E-02 Create Account via UI → Validate Account Type via API
    [Tags]  e2e  regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${new_number}=  Open New Account  type=CHECKING
    ${response}=  Get Method    /accounts/${new_number}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=  Set Variable  ${response.json()}
    ${type}=  Get From Dictionary    ${body}    type
    Should Be Equal As Strings    CHECKING    ${type}
