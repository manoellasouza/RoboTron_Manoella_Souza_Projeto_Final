*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ../support/base.robot

*** Keywords ***
GET Endpoint /usuarios 
    ${response}                           GET On Session                       serverest        /usuarios
    # ${response}                         GET On Session                       serverest        /usuarios    params=administrador=true
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

GET Endpoint /usuarios "${id_user}"
    ${response}                           GET On Session                        serverest        /usuarios/${id_user}        expected_status=any 
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

POST Endpoint /usuarios
    ${response}                           POST On Session                       serverest        /usuarios/                   json=&{payload}        expected_status=any
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}  
    IF    "${response.status_code}" == "201"   
        ${id_user}                        Set Variable        ${response.json()["_id"]} 
        Set Global Variable               ${id_user} 
    END

DELETE Endpoint /usuarios/id
    ${response}                           DELETE On Session                      serverest        /usuarios/${id_user}      expected_status=any   
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

PUT Endpoint /usuarios "${id_user}"
    ${response}                           PUT On Session                         serverest        /usuarios/${id_user}        json=&{payload}    expected_status=any      
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    IF    "${response.status_code}" == "201"   
        ${id_user}                        Set Variable                           ${response.json()["_id"]} 
        Set Global Variable               ${id_user} 
    END

Selecionar Usuario Estatico "${user}"
    ${json}                               Importar JSON Estatico                 json_usuario_ex.json  
    ${payload}                            Set variable                           ${json["${user}"]}
    Set Global Variable                   ${payload}

Selecionar ID User "${id_user}"
    ${id_user}                            Set Variable                            ${id_user}                                   
    Set Global Variable                   ${id_user}

Criar Um Usuario Dinamico e Armazenar ID
    Criar Dados Usuario Valido
    POST Endpoint /usuarios

Validar Erro "${nome_erro}"   
    IF         "${nome_erro}" == "nome" or "${nome_erro}" == "password"    
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} não pode ficar em branco 
    ELSE IF    "${nome_erro}" == "email" 
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um email válido 
    ELSE IF    "${nome_erro}" == "administrador"  
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser 'true' ou 'false' 
    END





    
