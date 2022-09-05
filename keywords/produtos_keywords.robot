*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ../support/base.robot

*** Keywords ***
GET Endpoint /produtos
    ${response}                           GET On Session                     serverest            /produtos
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    Validar Content-type

GET Endpoint /produtos "${id_produto}"
    ${response}                           GET On Session                     serverest            /produtos/${id_produto}        expected_status=any 
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    Validar Content-type

POST Endpoint /produtos 
    &{header}                             Create Dictionary                  Authorization=${token_auth}                         
    ${response}                           POST On Session                    serverest                    /produtos        json=&{payload}        headers=&{header}        expected_status=any 
    Log To Console                        ${payload}
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    Validar Content-type
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
    Validar Content-type
    
PUT Endpoint /produtos "${id_produto}"
    &{header}                             Create Dictionary                    Authorization=${token_auth}
    ${response}                           PUT On Session                       serverest                   /produtos/${id_produto}        json=&{payload}     headers=&{header}      expected_status=any      
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    Validar Content-type
    IF    "${response.status_code}" == "201"   
        ${id_produto}                     Set Variable                         ${response.json()["_id"]} 
        Set Global Variable               ${id_produto} 
    END

Selecionar Produto Estatico "${produto}"
    ${json}                               Importar JSON Estatico               json_produtos_ex.json  
    ${payload}                            Set variable                         ${json["${produto}"]}
    Set Global Variable                   ${payload}

Selecionar ID Produto "${id_produto}"
    ${id_produto}                          Set Variable                         ${id_produto}                                   
    Set Global Variable                    ${id_produto}

Validar Mensagem Preço
    Should Be Equal                        ${response.json()["preco"]}        preco deve ser um inteiro

Criar Um Produto Estatico Valido e Armazenar ID
    Selecionar Produto Estatico "produto_valido"
    POST Endpoint /produtos 

Criar Um Produto Dinamico e Armazenar ID
    Criar Dados Produto Dinamico Valido 
    POST Endpoint /produtos 

Validar Ter Criado o Produto
    Should Be Equal                        ${response.json()["message"]}         Cadastro realizado com sucesso
    Should Not Be Empty                    ${response.json()["_id"]} 



