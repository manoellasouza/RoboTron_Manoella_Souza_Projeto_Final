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

PUT Endpoint Cadastro /produtos/id
    ${json}                Importar JSON Estatico        json_produtos_ex.json  
    ${payload}             Set variable                  ${json["produto_valido"]} 
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=201  
    ${id_produto}          Set Variable                  ${response.json()["_id"]}   
    Log To Console         ID Produto: ${id_produto}
    Set Global Variable    ${id_produto} 
    Set Global Variable    ${response}


#Cenários Negativos:

Criar Produto Invalido
    ${json}                   Importar JSON Estatico        json_produtos_ex.json  
    ${payload}                Set variable                  ${json["produto_invalido"]}   
    Set Global Variable       ${payload} 
    &{header}                 Create Dictionary      Authorization=${token_auth}                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=400 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Mensagem Produto Invalido
    Should Be Equal            ${response.json()["message"]}    Já existe produto com esse nome

Criar Produto Token Invalido
    ${json}                   Importar JSON Estatico        json_produtos_ex.json  
    ${payload}                Set variable                  ${json["produto_valido"]}   
    &{header}                 Create Dictionary      Authorization="12563737"                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=401 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Criar Produto Admin False
    ${json}                   Importar JSON Estatico        json_produtos_ex.json  
    ${payload}                Set variable                  ${json["produto_valido"]}   
    &{header}                 Create Dictionary      Authorization=${token_auth}                         
    ${response}               POST On Session        serverest        /produtos    json=&{payload}    headers=&{header}    expected_status=403 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint Produto ID Invalido
    ${response}               GET On Session        serverest        /produtos/12548    expected_status=400
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Mensagem Produto Não Encontrado
    Should Be Equal            ${response.json()["message"]}    Produto não encontrado

DELETE Produto Token Invalido
    &{header}                 Create Dictionary      Authorization=1258325  
    ${response}               DELETE On Session        serverest        /produtos/${id_produto}    headers=&{header}    expected_status=401 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    Validar Status Code "401"
    Validar Mensagem Token Invalido

DELETE Produto Admin False
    Criar Login Estatico Admin False
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    ${response}               DELETE On Session        serverest        /produtos/${id_produto}    headers=&{header}    expected_status=403 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    Validar Status Code "403"    
    Validar Mensagem Rota Exclusiva Admin

PUT Endpoint Cadastro Produto Inválido
    ${json}                Importar JSON Estatico        json_produtos_ex.json  
    ${payload}             Set variable                  ${json["produto_invalido"]} 
    &{header}              Create Dictionary             Authorization=${token_auth}
    ${response}            PUT On Session                serverest                        /produtos/1562586    json=&{payload}    headers=&{header}    expected_status=400 
    Set Global Variable    ${response}

PUT Produto Token Invalido
    &{header}                 Create Dictionary      Authorization=1258325       
    &{payload}                Create Dictionary      nome=Monitor Logitech    preco=650    descricao=Monitor    quantidade=250                  
    ${response}               PUT On Session        serverest        /produtos/${id_produto}     data=&{payload}    headers=&{header}    expected_status=401 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    Validar Status Code "401"
    Validar Mensagem Token Invalido

PUT Produto Admin False
    Criar Login Estatico Admin False
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    &{payload}                Create Dictionary      nome=Monitor Logitech    preco=650    descricao=Monitor    quantidade=250                  
    ${response}               PUT On Session        serverest        /produtos/${id_produto}     data=&{payload}    headers=&{header}    expected_status=403 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    Validar Status Code "403"
    Validar Mensagem Rota Exclusiva Admin
