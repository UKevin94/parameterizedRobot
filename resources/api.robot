*** Settings ***
Library             REST
Documentation       This file contains all operations used with the API

*** Variables ***
${MAIN_ENDPOINT}        http://192.168.1.34:8080/api



*** Keywords ***
Get API Authentification Token
    Post                ${MAIN_ENDPOINT}/authenticate       {"username":"admin","password":"admin","rememberMe":"false"}
    ${ID_TOKEN}=        Output                              $.id_token
    Set Test Variable   ${TOKEN}        ${ID_TOKEN}

Check That The Injected Contact Is Present
    [Arguments]     ${firstname}        ${lastname}
    Get             ${MAIN_ENDPOINT}/contacts/1         headers={"Authorization": "Bearer ${TOKEN}"}
    String          $.firstName         ${firstname}
    String          $.lastName          ${lastname}