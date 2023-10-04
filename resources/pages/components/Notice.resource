*** Settings ***
Documentation        Ações e componentes do componente de notificação

Library              Browser

*** Keywords ***
Notice should be
    [Arguments]        ${expected_text}

    ${element}         Set Variable        css=.notice p

    Wait For Elements State     ${element}       visible      5
    Get Text                    ${element}       equal        ${expected_text}   