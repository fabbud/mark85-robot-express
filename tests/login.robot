*** Settings ***
Documentation        Cenários de autenticação do usuário

Resource             ../resources/base.resource
Library              Collections

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    
    ${user}        Create Dictionary
    ...    name=Fernanda Abbud    
    ...    email=fabbud@gmail.com    
    ...    password=pwd123

    Remove user from database       ${user}[email]
    Insert user to database         ${user}

    Submit login form               ${user}
    User should be logged in        ${user}[name]

Não deve logar com senha inválida

    ${user}        Create Dictionary
    ...    name=Steve Woz    
    ...    email=woz@apple.com    
    ...    password=pwd123

    Remove user from database       ${user}[email]
    Insert user to database         ${user}

    Set To Dictionary               ${user}        password=123456

    Submit login form               ${user}
    Notice should be                Ocorreu um erro ao fazer login, verifique suas credenciais.