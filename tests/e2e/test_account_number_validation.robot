*** Settings ***
Resource  ../../resources/pages/login_page.resource
Resource  ../../resources/pages/registration_page.resource
Resource  ../../resources/pages/account_page.resource
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
TC-E2E-01 Create CHECKING Account via UI → Validate Exists via API
    [Tags]  e2e  smoke
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${new_number}=  Open New Account  type=CHECKING
    ${response}=  Get Method    /accounts/${new_number}
    ${body}=  Set Variable  ${response.text}
    Log To Console    ${body}
    ${numer_api}=  Get From Dictionary    ${body}    id
    Should Be Equal As Integers    ${new_number}    ${numer_api}
    