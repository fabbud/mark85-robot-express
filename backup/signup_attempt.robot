*** Settings ***
Documentation        Cenários de tentativa de caadstro com senha muito curta

Resource             ../resources/base.resource
Test Template        Short password

Test Setup           Start Session
Test Teardown        Take Screenshot


*** Test Cases ***

Não deve logar com senha de 1 dígitos    1
Não deve logar com senha de 2 dígitos    12
Não deve logar com senha de 3 dígitos    123
Não deve logar com senha de 4 dígitos    1234
Não deve logar com senha de 5 dígitos    12345

