*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ../support/base.robot

*** Variables ***


*** Keywords ***
Selecionar Usuario Estatico "${user}"
    ${json}                               Importar JSON Estatico            json_usuario_ex.json  
    ${payload}                            Set variable                      ${json["${user}"]}
    Set Global Variable                   ${payload}

Selecionar ID User Invalido 
    ${id_user}                            Set Variable                       "125365"
    Set Global Variable                   ${id_user}

Selecionar ID User Carrinho
    ${id_user}                            Set Variable                        nM3T94jas8oCkRPw
    Set Global Variable                   ${id_user}

Armazenar ID Usuario
    ${id_user}                            Set Variable        ${response.json()["_id"]}   
    Log To Console                        ID Usuário: ${id_user}
    Set Global Variable                   ${id_user}

Criar Um Usuario e Armazenar ID
    Selecionar Usuario Estatico "user_valido"
    POST Endpoint /usuarios
    Armazenar ID Usuario

GET Endpoint /usuarios 
    ${response}               GET On Session        serverest        /usuarios
    # ${response}               GET On Session        serverest        /usuarios    params=administrador=true
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /usuarios/id
    ${response}               GET On Session                    serverest        /usuarios/${id_user}    expected_status=any 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

POST Endpoint /usuarios
    ${response}               POST On Session        serverest        /usuarios/    json=&{payload}        expected_status=any
    Log To Console            Response: ${response.content}
    # Log To Console            Response: ${payload}
    # ${id_user}                Set Variable        ${response.json()["_id"]} 
    # Set Global Variable       ${id_user} 
    Set Global Variable       ${response}        

DELETE Endpoint /usuarios/id
    ${response}               DELETE On Session               serverest        /usuarios/${id_user}      expected_status=any   
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    Set Global Variable       ${id_user}

PUT Endpoint /usuarios
    Armazenar ID Usuario
    Criar Dados Usuario Valido
    ${id_user}                Set Variable        ${response.json()["_id"]} 
    ${response}               PUT On Session        serverest        /usuarios/${id_user}        json=&{payload}    expected_status=200      
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    

PUT Endpoint Cadastro /usuarios
    ${response}                PUT On Session        serverest        /usuarios/1562586    json=&{payload}    expected_status=any 
    # ${id_user}                 Set Global Variable          ${response.json()["_id"]}   
    # Log To Console             ID User: ${id_user}
    # Log To Console             Dados: ${payload}
    # Set Global Variable        ${id_user} 
    Set Global Variable        ${response}
    
PUT Endpoint Cadastro Invalido /usuarios/id
    Selecionar Usuario Estatico "user_invalido"
    ${response}                            PUT On Session        serverest        /usuarios/15862    json=&{payload}    expected_status=400  
    Set Global Variable                    ${response}

Validar Erro "${nome_erro}"   
    IF         "${nome_erro}" == "nome" or "${nome_erro}" == "password"    
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} não pode ficar em branco 
    ELSE IF    "${nome_erro}" == "email" 
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um email válido 
    ELSE IF    "${nome_erro}" == "administrador"  
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser 'true' ou 'false 
    END


# Validar Se Response Contem Nome "${nome}"
#     Should Contain          ${response.json()["usuarios"][0]["nome"]}    ${nome}
#     Log To Console          Nome Cadastrado: ${response.json()["usuarios"][1]["nome"]}     

# Validar Cadastro do E-mail "${email}"
#     Should Contain          ${response.json()["email"]}    ${email}
#     Log To Console          E-mail Cadastrado: ${response.json()["email"]} 

# Validar Mensagem Usuário Não Encontrado
#     Should Be Equal            ${response.json()["message"]}    Usuário não encontrado



    
