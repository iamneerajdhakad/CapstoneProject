*** Settings ***
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment And Create Session
Test Setup  Clean DB

*** Test Cases ***
TC-PERF-01 API Response Time Under 2 Seconds
    [Tags]  performance
    ${response}  Get Method    /customers/${customerId}/accounts
    ${body}  Set Variable  ${response.text}
    Log To Console    ${body}
    Validate Status Code    ${response}    200
    Validate Response Time    ${response}
