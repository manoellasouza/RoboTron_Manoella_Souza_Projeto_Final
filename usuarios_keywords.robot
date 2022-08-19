*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Usuarios
Library              RequestsLibrary
Resource             ./common.robot

*** Keywords ***

Selecionar ID User Invalido 
    ${id_user}             Set Variable        1258623
    Set Global Variable    ${id_user}

Selecionar ID User Login
    ${id_user}             Set Variable        oUb7aGkMtSEPf6BZ
    Set Global Variable    ${id_user}

Criar Um Usuario e Armazenar ID
    Criar Usuario Estatico Valido
    POST Endpoint /usuarios
    ${id_user}                            Set Variable        ${response.json()["_id"]}   
    Log To Console                        ID Usuário: ${id_user}
    Set Global Variable                   ${id_user}

Criar Usuario Estatico Valido
    ${json}                Importar JSON Estatico        json_usuario_ex.json  
    ${payload}             Set variable                  ${json["user_valido"]} 
    Set Global Variable    ${payload} 

Criar Usuario Estatico Invalido
    ${json}                Importar JSON Estatico        json_usuario_ex.json  
    ${payload}             Set variable                  ${json["user_invalido"]} 
    Set Global Variable    ${payload} 

GET Endpoint /usuarios 
    ${response}               GET On Session        serverest        /usuarios
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /usuarios/id
    ${response}               GET On Session        serverest        /usuarios/${id_user}    expected_status=any 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

POST Endpoint /usuarios
    ${response}               POST On Session        serverest        /usuarios/    json=&{payload}    expected_status=any
    Log To Console            Response: ${response.content}
    Log To Console            Response: ${payload}
    Set Global Variable       ${response}

DELETE Endpoint /usuarios/id
    ${response}               DELETE On Session        serverest        /usuarios/${id_user}    expected_status=any   
    Log To Console            ID Deletado: ${id_user}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint /usuarios/id
    &{payload}                Create Dictionary      nome=Fulano de Souza    email=beltrano@qa.com.br    password=teste    administrador=true
    ${response}               PUT On Session        serverest        /usuarios/${id_user}    data=&{payload}    expected_status=any      
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint Cadastro /usuarios/id
    ${response}                PUT On Session        serverest        /usuarios/1562586    json=&{payload}    expected_status=any 
    ${id_user}                 Set Variable        ${response.json()["_id"]}   
    Log To Console             ID User: ${id_user}
    Log To Console             Dados: ${payload}
    Set Global Variable        ${id_user} 
    Set Global Variable        ${response}
    
PUT Endpoint Cadastro Invalido /usuarios/id
    Criar Usuario Estatico Invalido
    ${response}                            PUT On Session        serverest        /usuarios/15862    json=&{payload}    expected_status=400  
    Set Global Variable                    ${response}

Validar Quantidade "${quantidade}"
    Should Be Equal        ${response.json()["quantidade"]}    ${quantidade}
    Log To Console         Quantidade Cadastrada: ${response.json()["quantidade"]}

Validar Se Response Contem "${nome}"
    Should Contain          ${response.json()["usuarios"][0]["nome"]}    ${nome}
    Log To Console          Nome Cadastrado: ${response.json()["usuarios"][1]["nome"]}     

Validar Cadastro do E-mail "${email}"
    Should Contain          ${response.json()["email"]}    ${email}
    Log To Console          E-mail Cadastrado: ${response.json()["email"]} 

Validar Mensagem Usuário Não Encontrado
    Should Be Equal            ${response.json()["message"]}    Usuário não encontrado
