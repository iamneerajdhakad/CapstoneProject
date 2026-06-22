*** Settings ***
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment And Create Session
Suite Teardown  Delete All Sessions

*** Test Cases ***
TC-API-01 Test Login via API
    [Tags]  api  smoke
    ${response}=  Get Method  /login/${USERNAME}/${PASSWORD}
    Validate Status Code    ${response}    200
    ${body}=  Set Variable  ${response.json()}
    Log To Console    ${body}
