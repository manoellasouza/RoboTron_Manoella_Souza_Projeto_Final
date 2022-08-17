*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Login
Library              RequestsLibrary
Resource             ./common.robot

*** Variables ***
${email_para_login}    fulano@qa.com    
${password_para_login}    teste

*** Keywords ***

Selecionar Usuario Login Valido
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_valido"]}
    Set Global Variable    ${payload}

Selecionar Usuario Login Invalido
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_invalido"]}
    Set Global Variable    ${payload}

POST Endpoint /login
    ${response}            POST On Session        serverest        /login    json=&{payload}    expected_status=any 
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}
    
Fazer Login e Armazenar Token
    Selecionar Usuario Login Valido
    POST Endpoint /login
    Validar Ter Logado
    ${token_auth}        Set Variable        ${response.json()["authorization"]}   
    Log To Console       Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}

Criar Login Estatico Admin False
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_sem_admin"]}
    ${response}            POST On Session        serverest        /login    json=&{payload}    
    ${token_auth}          Set Variable        ${response.json()["authorization"]}   
    Log To Console         Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}

Validar Mensagem Email/Senha Invalidos
    Should Be Equal            ${response.json()["message"]}    Email e/ou senha inválidos

Validar Ter Logado
    Should Be Equal            ${response.json()["message"]}    Login realizado com sucesso
    Should Not Be Empty        ${response.json()["authorization"]} 

