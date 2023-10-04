*** Settings ***
Documentation        Cenários de cadastro de tarefas

Resource             ../../resources/base.resource

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]        new_task
    
    ${data}        Get fixture        tasks        create

    Reset user from database        ${data}[user]

    Login                           ${data}[user]

    Go to task form
    Submit task form                ${data}[task]
    Task should be registered       ${data}[task][name]


Não deve cadastrar tarefa com nome duplicado
    [Tags]        dup_task

    ${data}        Get fixture        tasks        duplicate

    # Dado que eu tenho um novo usuário
    Reset user from database        ${data}[user]

    # E que este usuário já cadastrou uma nova tarefa
    Create a new task in API        ${data}

    # E que estou logado na aplicação web
    Login                           ${data}[user]

    # Quando tento cadastrar a mesma tarefa que já foi cadastrada
    Go to task form
    Submit task form                ${data}[task]

    # Devo ver uma notificação de duplicidade
    Notice should be                Oops! Tarefa duplicada.
    
Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
    [Tags]        tags_limit

    ${data}        Get fixture        tasks        tags_limit

    # Dado que eu tenho um novo usuário
    Reset user from database        ${data}[user]

    # E que este usuário já cadastrou uma nova tarefa
    Create a new task in API        ${data}

    # E que estou logado na aplicação web
    Login                           ${data}[user]

    # Quando tento cadastrar a mesma tarefa que já foi cadastrada
    Go to task form
    Submit task form                ${data}[task]

    # Devo ver uma notificação de duplicidade
    Notice should be                Oops! Limite de tags atingido.
