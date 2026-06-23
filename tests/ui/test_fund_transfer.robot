*** Settings ***
Resource  ../../resources/pages/transfer_page.robot
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/pages/account_page.robot
Resource  ../../resources/keywords/common_keywords.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-TF-01 Transfer Funds Between Two Accounts via UI
    [Tags]  smoke  regression
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${from_account_number}=  Open New Account
    Page Should Contain    Account Opened!

    ${to_account_number}=  Open New Account
    ${amount}=  Set Variable  100
    Page Should Contain    Account Opened!

    Transfer Funds    ${from_account_number}  ${to_account_number}  ${amount}
    Page Should Contain    Transfer Complete!
    Validate Transfer Details    ${from_account_number}    ${to_account_number}    ${amount}

TC-NEG-TF-02 Transfer Amount Greater Than The Balance – Should Be Rejected
    [Tags]  defect
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${from_account_number}=  Open New Account
    ${to_account_number}=  Open New Account
    Transfer Funds    ${from_account_number}  ${to_account_number}  1000
    Page Should Not Contain  Transfer Complete!

TC-NEG-TF-03 Transfer to Same Account – Should Be Rejected

    [Tags]  defect
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${from_account_number}=  Open New Account
    Transfer Funds    ${from_account_number}  ${from_account_number}
    Page Should Not Contain    Transfer Complete!

TC-NEG-TF-04 Transfer to Negative Account – Should Be Rejected
    [Tags]  defect
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${from_account_number}=  Open New Account
    ${to_account_number}=  Open New Account
    Transfer Funds    ${from_account_number}  ${to_account_number}  amount=-100
    Page Should Not Contain    Transfer Complete!

TC-NEG-TF-05 Transfer to Zero Account – Should Be Rejected
    [Tags]  defect
    Login To Application    ${USERNAME}    ${PASSWORD}
    ${from_account_number}=  Open New Account
    ${to_account_number}=  Open New Account
    Transfer Funds    ${from_account_number}  ${to_account_number}  amount=0
    Page Should Not Contain    Transfer Complete!

