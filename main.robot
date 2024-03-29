*** Settings ***
Library         squash_tf.TFParamService
Resource        resources/selenium.robot
Resource        resources/database.robot
Resource        resources/api.robot
Test Template   Check Contact API And Delete From Browser
Documentation   This file tests the Contact API and check that the GUI
...             allows us to delete them
Suite Setup     Load And Initiate Database Connection
Suite Teardown  Close Database Connection
Test Setup      Load Browser Parameter
Test Teardown   Close Opened Browser

*** Test Cases ***          First Name          Last Name
Standard Case               John                Smith
  [Tags]  tf:linked-TC=a1d93f71-6489-47c2-99b4-a4b7459dc269
Special Char                $$$$                $$$$
No Last Name                Johnn               ${EMPTY}
  [Tags]  tf:linked-TC= d7951232-3faf-4d45-9ce0-2821ab2e2041
No First Name               ${EMPTY}            Smith

*** Keywords ***

Check Contact API And Delete From Browser
    [Arguments]     ${firstname}    ${lastname}
    Inject Data In Database    ${firstname}    ${lastname}
    Get API Authentification Token
    Check That The Injected Contact Is Present      ${firstname}    ${lastname}
    Open The Main Page
    Login
    Check That The User Is The Correct One
    Go To The Contact Page
    Delete The Injected Contact     ${firstname}    ${lastname}
    Sleep    2 seconds
    Check Contact Table Row Count

Inject Data In Database
    [Arguments]     ${firstname}    ${lastname}
#    Initiate Database Connection
    Insert New Contact In Database  ${firstname}    ${lastname}
#    Close Database Connection

Load Browser Parameter
    ${BROWSER}=    Get Param    DS_Browser
    Set Test Variable    ${BROWSER}

#Tear'em all
#    Close Opened Browser
#    Close Database Connection