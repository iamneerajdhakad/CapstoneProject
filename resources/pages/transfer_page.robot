*** Settings ***
Resource  ../../variables/transfer_page_locators.robot
Resource  ../keywords/common_keywords.robot

*** Keywords ***
Transfer Funds
    [Arguments]  ${from_account_number}  ${to_account_number}=13344  ${amount}=100

    Log     Transferring ${amount} from ${from_account_number} to ${to_account_number}

    Wait Until Element Is Visible    ${transfer_funds_link}
    Click Element    ${transfer_funds_link}

    Wait Until Element Is Visible    ${amount_field}
    Input Text    ${amount_field}    ${amount}

    Wait Until Keyword Succeeds    10s    1s    Select From List By Value  ${from_account_select}  ${from_account_number}
    Wait Until Keyword Succeeds    10s    1s    Select From List By Value  ${to_account_select}  ${to_account_number}

    Wait Until Element Is Visible    ${transfer_button}
    Click Element    ${transfer_button}

    Log    Transfer Complete!

Validate Transfer Details
    [Arguments]  ${from_account_number}  ${to_account_number}  ${amount}

    Log    Validating transfer details

    Wait Until Element Is Visible    ${amount_transfered}

    Page Should Contain    ${amount}
    Page Should Contain    ${from_account_number}
    Page Should Contain    ${to_account_number}

    Log    Transfer validation completed successfully