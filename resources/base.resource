*** Settings ***
Library        libs/database.py
Library        Browser
Library        JSONLibrary

Resource       env.resource
Resource       services.resource
Resource       pages/SignupPage.resource
Resource       pages/LoginPage.resource
Resource       pages/components/Notice.resource
Resource       pages/components/Alert.resource
Resource       pages/components/Header.resource
Resource       pages/TaskCreatePage.resource
Resource       pages/TasksPage.resource

*** Keywords ***
Start Session
    New Browser         ${BROWSER}         False
    New Page            ${BASE_URL}

#Helpers
Get fixture
    [Arguments]        ${file_name}        ${scenario}

    ${data}        Load Json From File        
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    [Return]        ${data}[${scenario}]

Reset user from database
    [Arguments]        ${user}

    Clean user from database        ${user}[email]
    Insert user to database         ${user}

Create a new task in API
    [Arguments]                ${data}

    POST user session          ${data}[user]
    POST a new task            ${data}[task]

Login
    [Arguments]                ${user}

    Submit login form               ${user}
    User should be logged in        ${user}[name]
