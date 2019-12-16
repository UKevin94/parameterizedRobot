*** Settings ***
Library              SeleniumLibrary
Documentation        This file contains all Selenium operations that'll be used
...                  the main test.

*** Variables ***
#  ${BROWSER}           Firefox
${SUT_URL}           http://192.168.0.178:8080
${USERNAME}          admin
${PASSWORD}          admin

*** Keywords ***

Open The Main Page
#    [Arguments]     ${browser}      ${application_url}
    Open Browser        ${SUT_URL}      ${BROWSER}

Login
    Click Link                          xpath: //a[@id='account-menu']
    Click Link                          xpath: //a[@id='login']
    Input Text                          xpath: //input[@id='username']      ${USERNAME}
    Input Text                          xpath: //input[@id='password']      ${PASSWORD}
    Click Button                        xpath: //button[@jhitranslate='login.form.button']

Check That The User Is The Correct One
    Wait Until Page Contains Element    xpath: //span[parent::span[@id='home-logged-message']]  30
    Element Should Contain              xpath: //span[parent::span[@id='home-logged-message']]      ${USERNAME}

Go To The Contact Page
    Click Link                          xpath: //a[@id='entity-menu']
    Click Link                          xpath: //a[@href='#/contact']

Delete The Injected Contact
    [Arguments]                         ${firstname}    ${lastname}
    Click Button                        xpath: //button[contains(@class, 'btn-danger')][ancestor::td[preceding-sibling::td[contains(text(),'${firstname}')]][preceding-sibling::td[contains(text(),'${lastname}')]]]
    Click Button                        xpath: //button[@id='jac-confirm-delete-contact']

Close Opened Browser
    Close Browser