*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos

*** Keywords ***
GET Endpoint /produtos
    ${response}               GET On Session        serverest        /produtos
    Set Global Variable       ${response}

POST Endpoint /produtos 
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    &{payload}                Create Dictionary      nome=ImpressoraA EpsonO    preco=1200    descricao=Impressora    quantidade=150                        
    ${response}               POST On Session        serverest        /produtos    data=&{payload}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

DELETE Endpoint /produtos
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    ${response}               POST On Session        serverest        /produtos/${id_produto}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Ter Criado o Produto
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Criar Um Produto e Armazenar ID
    POST Endpoint /produtos
    Validar Ter Criado o Produto
    ${id_produto}        Set Variable        ${response.json()["_id"]}   
    Log To Console       ID Produto: ${id_produto}
    Set Global Variable    ${id_produto}