*** Settings ***
Resource  ../../variables/login_page_locators.robot
Resource  ../keywords/common_keywords.robot

*** Keywords ***
Login To Application
    [Arguments]  ${user}  ${pass}

    Wait Until Element Is Visible    ${username_login_field}  timeout=10s
    Input Text    ${username_login_field}    ${user}
    
    Wait Until Element Is Visible    ${password_login_field}  timeout=10s
    Input Text    ${password_login_field}    ${pass}

    Wait Until Element Is Visible    ${login_button}  timeout=10s
    Click Button    ${login_button}

    
Logout From Application
    Wait Until Element Is Visible    ${logout_link}
    Click Element    ${logout_link}

