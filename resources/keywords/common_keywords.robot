*** Settings ***
Library  SeleniumLibrary
Library  ../../config/environment.py

*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    Load Env    ${ENV}
    ${ui_url}  Get Env    ui_url
    ${username}  Get Env    username
    ${password}  Get Env    password

    Set Global Variable    ${UI_URL}  ${ui_url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

Open Application
    [Documentation]  opens the browser
    Open Browser  ${UI_URL}  ${BROWSER}
    Maximize Browser Window

Close Application
    [Documentation]  closes all the browser
    Close All Browsers