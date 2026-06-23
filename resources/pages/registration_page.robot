*** Settings ***
Resource  ../keywords/common_keywords.robot
Resource  ../../variables/registeration_page_locators.robot
Resource    ./login_page.robot

*** Keywords ***
Open Registration Page
    Log    Registration Page Opened!
    Click Element    ${resgistration_link}

Register New User To Apllication
    [Arguments]  ${first_name}  ${last_name}  ${address}  ${city}  ${state}  ${zipcode}  ${phone_number}  ${ssn}  ${user}  ${pass}  ${confirm}

    Log    Registeration for username: ${user}

    Wait Until Element Is Visible    ${first_name_field}
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

    Log    Registration submitted.
