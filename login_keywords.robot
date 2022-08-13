*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Login

*** Variables ***
${email_para_login}    charlie.s@gmail.com    
${password_para_login}    12345

*** Keywords ***
POST Endpoint /login
    &{payload}                Create Dictionary      email=${email_para_login}    password=${password_para_login}                     
    ${response}               POST On Session        serverest        /login    data=&{payload}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Ter Logado
    Should Be Equal            ${response.json()["message"]}    Login realizado com sucesso
    Should Not Be Empty        ${response.json()["authorization"]} 

Fazer Login e Armazenar Token
    POST Endpoint /login
    Validar Ter Logado
    ${token_auth}        Set Variable        ${response.json()["authorization"]}   
    Log To Console       Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}