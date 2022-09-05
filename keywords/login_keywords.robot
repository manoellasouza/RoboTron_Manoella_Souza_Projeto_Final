*** Settings ***
Documentation        Keywords e Variáveis para Ações do enpoint Login
Resource             ../support/base.robot

*** Keywords ***
Selecionar Usuario Login "${user}"
    ${json}                  Importar JSON Estatico            json_login_ex.json  
    ${payload}               Set variable                      ${json["${user}"]}
    Set Global Variable      ${payload}

POST Endpoint /login
    ${response}              POST On Session                    serverest        /login    json=&{payload}    expected_status=any 
    Log To Console           Response: ${response.content}       
    Set Global Variable      ${response}
    Validar Content-type

Armazenar Token    
    ${token_auth}            Set Variable        ${response.json()["authorization"]}   
    Set Global Variable      ${token_auth}

Fazer Login e Armazenar Token
    Selecionar Usuario Login "user_valido"
    POST Endpoint /login
    Validar Ter Logado
    Armazenar Token  

Criar Login Estatico Admin False
    Selecionar Usuario Login "user_sem_admin"
    POST Endpoint /login    
    Armazenar Token  

Validar Ter Logado
    Should Be Equal            ${response.json()["message"]}            Login realizado com sucesso
    Should Not Be Empty        ${response.json()["authorization"]} 

Validar Mensagem E-mail em Branco
    Should Be Equal            ${response.json()["email"]}    email não pode ficar em branco