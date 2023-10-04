*** Settings ***
Documentation        Elementos e ações da página de cadastro de tarefas

Library              Browser

*** Keywords ***
Submit task form
    [Arguments]        ${task}

    Fill Text        css=input[placeholder$=tarefa]        ${task}[name]

    ${element_tags}        Set Variable        css=input[name=tags]

    FOR  ${tag}  IN  @{task}[tags]
         Fill Text        ${element_tags}             ${tag}
         # Thinking time
         Sleep            1
         Press Keys       ${element_tags}             Enter
    END
    
    Click            css=button >> text=Cadastrar
    