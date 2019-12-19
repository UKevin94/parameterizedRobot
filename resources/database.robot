*** Settings ***
Library              DatabaseLibrary
Documentation        This file contains all operations used on the SUTs database


*** Variables ***
${DATABASE_API_MODULE_NAME}     psycopg2
${DATABASE_NAME}                jacksonviews
#  ${DATABASE_HOST}                192.168.1.34
${DATABASE_PORT}                5432
${DATABASE_USER}                jacksonviews
${DATABASE_PASS}

*** Keywords ***
Initiate Database Connection
    Connect To Database     ${DATABASE_API_MODULE_NAME}      ${DATABASE_NAME}      ${DATABASE_USER}     ${DATABASE_PASS}    ${SUT_HOST}    ${DATABASE_PORT}

Insert New Contact In Database
    [Arguments]            ${contact_firstname}    ${contact_lastname}
    Check Contact Table Row Count
    Execute Sql String     INSERT INTO jac_contact VALUES (1, '${contact_firstname}', '${contact_lastname}', 'random@mail', 39)

Check Contact Table Row Count
    Row Count Is 0         SELECT * FROM jac_contact

Close Database Connection
    Disconnect From Database