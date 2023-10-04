*** Settings ***
Documentation        Online

Library              Browser

Resource             ../resources/base.resource

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Webapp deve estar online
    Get Title        equal        Mark85 by QAx
