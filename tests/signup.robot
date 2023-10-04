*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Library              Browser

Resource             ../resources/base.resource

Test Setup           Start Session
Test Teardown        Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Tags]         new_user

    ${user}        Create Dictionary
    ...    name=Fernanda Abbud    
    ...    email=fabbud@gmail.com    
    ...    password=pwd123

    Remove user from database        ${user}[email]
    
    Go to signup page
    Submit signup form      ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir o cadastro com email duplicado
    [Tags]    dup

        ${user}        Create Dictionary
    ...    name=Fernanda Abbud    
    ...    email=fabbud@gmail.com    
    ...    password=pwd123

    Remove user from database      ${user}[email]
    Insert user to database        ${user}

    Go to signup page
    Submit signup form             ${user}
    Notice should be               Oops! Já existe uma conta com o e-mail informado.


Campos obrigatórios
    [Tags]    required

    ${user}        Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY} 
    ...    password=${EMPTY}

    Go to signup page
    Submit signup form        ${user}

    Alert should be           Informe seu nome completo
    Alert should be           Informe seu e-email
    Alert should be           Informe uma senha com pelo menos 6 digitos


Não deve cadastrar com email incorreto

    [Tags]    inv_email
    
    ${user}        Create Dictionary        
    ...    name=Charles Xavier        
    ...    email=xavier.com.br        
    ...    password=pwd123

    Go to signup page
    Submit signup form        ${user}
    Alert should be           Digite um e-mail válido

Não deve cadastrar com senhas muito curtas
    [Tags]        temp

    @{password_list}        Create List        1    12    123    1234    12345

    FOR  ${password}  IN  @{password_list}

        ${user}        Create Dictionary
        ...    name=Fernanda Abbud
        ...    email=fabbud@msn.com
        ...    password=${password}

    Go to signup page
    Submit signup form        ${user}

    Alert should be           Informe uma senha com pelo menos 6 digitos
    END
