*** Settings ***
Resource  ../../resources/pages/login_page.resource

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-LGN-01 Authenticate with Valid Credentials
    [Tags]  smoke  regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    Page Should Contain    Welcome
    Location Should Contain    overview

TC-NEG-LGN-02 Authenticate with Invalid Credentials
    [Tags]  smoke  regression  negative
    Login To Application    abc    lkj
    Page Should Contain    Error!

TC-NEG-LGN-03 Authenticate with Empty Credentials
    [Tags]  negative
    Login To Application    ${EMPTY}    ${EMPTY}
    Page Should Contain    Error!

TC-LGN-04 Logout From Application
    [Tags]  regression
    Login To Application  ${USERNAME}  ${PASSWORD}
    Logout From Application
    Page Should Contain    Customer Login
