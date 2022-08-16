*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ./common.robot
Resource             ./login_keywords.robot

*** Variables ***

*** Keywords ***

GET Endpoint /carrinhos
    ${response}               GET On Session        serverest        /carrinhos
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

