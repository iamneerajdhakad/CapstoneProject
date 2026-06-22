*** Settings ***
Resource  ../resources/keywords/common_keywords.robot
Resource  ../resources/pages/registration_page.resource
Resource    ../resources/keywords/api_keywords.robot

Library    DataDriver   file=${EXECDIR}/testdata/login_data.csv  dialect=excel

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Browser
Test Template  Register New User To Apllication


*** Test Cases ***
TC-DD-01 5 Concurrent API Requests  ${first_name}  ${last_name}  ${address}  ${city}  ${state}  ${zipcode}  ${phone_number}  ${ssn}  ${user}  ${pass}  ${confirm}
   [Documentation]      Data driven testing using csv
   [Tags]   datadriver

*** Keywords ***
Register New User To Apllication
    [Arguments]  ${first_name}  ${last_name}  ${address}  ${city}  ${state}  ${zipcode}  ${phone_number}  ${ssn}  ${user}  ${pass}  ${confirm}
    Clean DB
    Open Registration Page
    Input Text    ${first_name_field}    ${first_name}
    Input Text    ${last_name_field}    ${last_name}
    Input Text    ${address_field}    ${address}
    Input Text    ${city_field}    ${city}
    Input Text    ${state_field}    ${state}
    Input Text    ${zipcode_field}    ${zipcode}
    Input Text    ${phone_number_field}  ${phone_number}
    Input Text    ${ssn_field}  ${ssn}
    Wait Until Element Is Visible    ${username_register_field}
    Input Text    ${username_register_field}  ${user}
    Wait Until Element Is Visible    ${password_register_field}
    Input Text    ${password_register_field}  ${pass}
    Wait Until Element Is Visible    ${confirm_field}
    Input Text    ${confirm_field}  ${confirm}
    Click Element    ${register_button}
    Page Should Contain    Welcome





