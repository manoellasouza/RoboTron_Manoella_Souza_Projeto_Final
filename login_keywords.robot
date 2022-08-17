*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Login
Library              RequestsLibrary
Resource             ./common.robot

*** Variables ***
${email_para_login}    fulano@qa.com    
${password_para_login}    teste

*** Keywords ***
Criar Login Estatico Valido
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_valido"]}
    ${response}            POST On Session        serverest        /login    json=&{payload} 
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}
    
Validar Ter Logado
    Should Be Equal            ${response.json()["message"]}    Login realizado com sucesso
    Should Not Be Empty        ${response.json()["authorization"]} 

Fazer Login e Armazenar Token
    Criar Login Estatico Valido
    Validar Ter Logado
    ${token_auth}        Set Variable        ${response.json()["authorization"]}   
    Log To Console       Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}

#E-mail ou Senha inválidos:
Criar Login Estatico E-mail Invalido
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_invalido"]}
    ${response}            POST On Session        serverest        /login    json=&{payload}    expected_status=400 
    Log To Console         Response: ${response.content}
    Set Global Variable    ${response}

Validar Mensagem Email/Senha Invalidos
    Should Be Equal            ${response.json()["message"]}    Email e/ou senha inválidos

Criar Login Estatico Admin False
    ${json}                Importar JSON Estatico        json_login_ex.json  
    ${payload}             Set variable                  ${json["user_sem_admin"]}
    ${response}            POST On Session        serverest        /login    json=&{payload}    
    ${token_auth}          Set Variable        ${response.json()["authorization"]}   
    Log To Console         Token Salvo: ${token_auth}
    Set Global Variable    ${token_auth}

