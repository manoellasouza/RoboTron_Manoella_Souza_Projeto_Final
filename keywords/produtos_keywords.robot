*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ../support/base.robot

*** Keywords ***
GET Endpoint /produtos
    ${response}                           GET On Session                     serverest            /produtos
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

GET Endpoint /produtos "${id_produto}"
    ${response}                           GET On Session                     serverest            /produtos/${id_produto}        expected_status=any 
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

POST Endpoint /produtos 
    &{header}                             Create Dictionary                  Authorization=${token_auth}                         
    ${response}                           POST On Session                    serverest                    /produtos        json=&{payload}        headers=&{header}        expected_status=any 
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
        IF    "${response.status_code}" == "201"   
        ${id_produto}                     Set Variable                        ${response.json()["_id"]} 
        Set Global Variable               ${id_produto} 
        Validar Ter Criado o Produto
    END

DELETE Endpoint /produtos
    &{header}                             Create Dictionary                   Authorization=${token_auth}  
    ${response}                           DELETE On Session                   serverest                    /produtos/${id_produto}        headers=&{header}        expected_status=any
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}

PUT Endpoint /produtos "${id_produto}"
    &{header}                             Create Dictionary                     Authorization=${token_auth}
    ${response}                           PUT On Session                        serverest        /usuarios/${id_produto}        json=&{payload}    expected_status=any      
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    IF    "${response.status_code}" == "201"   
        ${id_produto}                        Set Variable                           ${response.json()["_id"]} 
        Set Global Variable               ${id_user} 
    END









Selecionar Produto Estatico "${produto}"
    ${json}                               Importar JSON Estatico            json_produtos_ex.json  
    ${payload}                            Set variable                      ${json["${produto}"]}
    Set Global Variable                   ${payload}
    

# Criar Um Produto e Armazenar ID
#     Selecionar Produto Estatico "produto_valido"
#     POST Endpoint /produtos 
#     Validar Ter Criado o Produto
#     ${id_produto}                                  Set Variable                        ${response.json()["_id"]}   
#     Log To Console                                 ID Produto: ${id_produto}
#     Set Global Variable                            ${id_produto}



Criar Produto Token Invalido
    Selecionar Produto Estatico "produto_invalido" 
    &{header}                 Create Dictionary      Authorization="12563737"                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=401 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}



PUT Endpoint Cadastro /produtos/id
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=any  
    ${id_produto}          Set Variable                  ${response.json()["_id"]}   
    Log To Console         ID Produto: ${id_produto}
    Set Global Variable    ${id_produto} 
    Set Global Variable    ${response}

DELETE Produto Token Invalido
    Selecionar Token Invalido
    DELETE Endpoint /produtos
    Validar Status Code "401"
    Validar Mensagem Token Invalido

DELETE Produto Admin False
    Criar Login Estatico Admin False
    DELETE Endpoint /produtos
    Validar Status Code "403"    
    Validar Mensagem Rota Exclusiva Admin

PUT Endpoint /produtos/id
    &{header}                 Create Dictionary      Authorization=${token_auth}       
    &{payload}                Create Dictionary      nome=Monitor Logitech    preco=650    descricao=Monitor    quantidade=250                  
    ${response}               PUT On Session        serverest        /produtos/${id_produto}     data=&{payload}    headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint Cadastro Produto Inválido
    Selecionar Produto Estatico "produto_invalido"
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=400 
    Set Global Variable    ${response}
PUT Produto Token Invalido
    Selecionar Token Invalido
    PUT Endpoint /produtos/id
    Validar Status Code "401"
    Validar Mensagem Token Invalido

PUT Produto Admin False
    Criar Login Estatico Admin False
    PUT Endpoint /produtos/id
    Validar Status Code "403"
    Validar Mensagem Rota Exclusiva Admin

Validar Ter Criado o Produto
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Validar Nome Produto Cadastrado "${produto}"
    Should Contain          ${response.json()["produtos"][2]["nome"]}    ${produto}
    Log To Console          Produto Cadastrado: ${response.json()["produtos"][2]["nome"]}

Validar Nome Produto Buscado "${produto}"
    Should Contain          ${response.json()["nome"]}    ${produto}
    Log To Console          Produto Buscado: ${response.json()["nome"]}

# Criar Produto Dinamico Valido    
#     ${payload}                         Criar Dados Produto Valido        
#     Set Global Variable                ${payload}

Validar Erro Produto "${nome_erro}"   
    IF         "${nome_erro}" == "nome" or "${nome_erro}" == "descricao"    
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} não pode ficar em branco 
    ELSE IF    "${nome_erro}" == "preco" or "${nome_erro}" == "quantidade"   
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um número 
    END

Criar Um Produto Dinamico e Armazenar ID
    Criar Dados Produto Valido
    POST Endpoint /produtos 


Selecionar ID Produto "${id_produto}"
    ${id_produto}                            Set Variable                            ${id_produto}                                   
    Set Global Variable                       ${id_produto}

