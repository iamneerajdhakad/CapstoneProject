*** Settings ***
Resource  ../../resources/pages/registration_page.robot
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Load Environment
Suite Teardown  Delete All Sessions
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-UI-01 Register New User With Valid Data
    [Tags]  smoke  regression
    Clean DB
    Open Registration Page
    Register New User To Apllication    abc    def    qwerty    qwerty    qwerty    12345    1234567890    12345678    jacob234    jacob234  jacob234
    Page Should Contain    Welcome

TC-UI-02 Register User with Password and Confirm Password Mismatch
    [Tags]  negative
    Open Registration Page
    Register New User To Apllication    abc    def    qwerty    qwerty    qwerty    12345    1234567890    12345678    jacob234    jacob234  jacob23
    Page Should Contain    Passwords did not match

TC-UI-03 Register User with Empty/Blank Fields
    [Tags]  negative
    Open Registration Page
    Register New User To Apllication    ${EMPTY}    ${EMPTY}    ${EMPTY}  ${EMPTY}   ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}  ${EMPTY}
    Page Should Contain    required

TC-UI-04 Register User That Is Already Exsisting
    [Tags]  negative
    Open Registration Page
    Register New User To Apllication    abc    def    qwerty    qwerty    qwerty    12345    1234567890    12345678    john    demo  demo
    Page Should Contain    This username already exists.