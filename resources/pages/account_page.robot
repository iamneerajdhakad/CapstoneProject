*** Settings ***
Resource  ../../variables/account_page_locators.robot
Resource  ../keywords/common_keywords.robot

*** Keywords ***
Open New Account
    [Arguments]  ${type}=SAVINGS  ${default_account_number}=13344

    Log    Opening new account with type: ${type} from account number ${default_account_number}

    Wait Until Element Is Visible    ${open_new_account}
    Click Element    ${open_new_account}

    Wait Until Element Is Visible    ${account_type_select}
    Select From List By Label    ${account_type_select}  ${type}

    Wait Until Keyword Succeeds    10s    1s    Select From List By Value    ${account_number_select}  ${default_account_number}

    Wait Until Element Is Visible    ${open_account_button}
    Click Element    ${open_account_button}

    Log    New Account Opened!

    Wait Until Element Is Visible    ${account_number}  timeout=15s
    ${number}=  Get Text    ${account_number}

    Log    New account number: ${number}

    Log To Console    ${number}
    RETURN  ${number}