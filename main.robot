*** Settings ***
Library         squash_tf_robotframework_runner_parameter.squashTfRobotframeworkRunnerParameter.TFParamService
Resource        resources/selenium.robot
Resource        resources/database.robot
Resource        resources/api.robot
Test Template   Check Contact API And Delete From Browser
Documentation   This file tests the Contact API and check that the GUI
...             allows us to delete them
Suite Setup     Initiate Database Connection
Suite Teardown  Close Database Connection
Test Setup      Load Parameters
Test Teardown   Close Opened Browser

*** Test Cases ***          First Name          Last Name
Standard Case               John                Smith
Special Char                $$$$                $$$$
No Last Name                Johnn               ${EMPTY}
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
    Check Contact Table Row Count

Inject Data In Database
    [Arguments]     ${firstname}    ${lastname}
#    Initiate Database Connection
    Insert New Contact In Database  ${firstname}    ${lastname}
#    Close Database Connection

Load Parameters
    ${BROWSER}    Get Param    DS_Browser    Firefox

#Tear'em all
#    Close Opened Browser
#    Close Database Connection