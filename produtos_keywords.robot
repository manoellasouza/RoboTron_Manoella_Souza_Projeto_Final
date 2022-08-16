*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ./common.robot
Resource             ./login_keywords.robot

*** Keywords ***
GET Endpoint /produtos
    ${response}               GET On Session        serverest        /produtos
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /produtos/id
    ${response}               GET On Session        serverest        /produtos/${id_produto}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

POST Endpoint /produtos 
    &{header}                 Create Dictionary      Authorization=${token_auth}                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint /produtos/id
    &{header}                 Create Dictionary      Authorization=${token_auth}       
    &{payload}                Create Dictionary      nome=Monitor Logitech    preco=650    descricao=Monitor    quantidade=250                  
    ${response}               PUT On Session        serverest        /produtos/${id_produto}     data=&{payload}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

DELETE Endpoint /produtos
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    ${response}               DELETE On Session        serverest        /produtos/${id_produto}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Ter Criado o Produto
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Criar Um Produto e Armazenar ID
    Criar Produto Estatico Valido
    Validar Ter Criado o Produto
    ${id_produto}        Set Variable        ${response.json()["_id"]}   
    Log To Console       ID Produto: ${id_produto}
    Set Global Variable    ${id_produto}

Criar Produto Estatico Valido
    ${json}                Importar JSON Estatico        json_produtos_ex.json  
    ${payload}             Set variable                  ${json["produto_valido"]} 
    Set Global Variable    ${payload} 
    POST Endpoint /produtos