*** Settings ***
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/pages/registration_page.robot
Resource  ../../resources/pages/account_page.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-OA-UI-01 Open New SAVINGS Account via UI
    [Tags]  smoke  regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    Open New Account
    Page Should Contain    Account Opened!

TC-OA-UI-02 Open New CHECKING Account via UI
    [Tags]  regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    Open New Account  type=CHECKING
    Page Should Contain    Account Opened!
