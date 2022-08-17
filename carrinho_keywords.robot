*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ./common.robot
Resource             ./login_keywords.robot
Library               json


*** Variables ***


*** Keywords ***

GET Endpoint /carrinhos
    ${response}               GET On Session        serverest        /carrinhos
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

GET Endpoint /carrinhos/id
    ${response}               GET On Session        serverest        /carrinhos/${id_carrinho}    expected_status=any
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

POST Endpoint /carrinhos 
    &{header}                 Create Dictionary                      Authorization=${token_auth}                         
    ${response}               POST On Session                        serverest        /carrinhos    json=&{payload}    headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Criar Carrinho Estatico Valido
    ${json}                    Importar JSON Estatico        json_carrinho_ex.json  
    ${payload}                 Set Variable                  ${json} 
    Set Global Variable        ${payload} 
    Log To Console             Response: ${payload}
    POST Endpoint /carrinhos

DELETE Endpoint /carrinhos/concluir-compra
    &{header}                 Create Dictionary                  Authorization=${token_auth}  
    ${response}               DELETE On Session                        serverest        /carrinhos/concluir-compra/    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

DELETE Endpoint /carrinhos/cancelar-compra
    &{header}                 Create Dictionary                  Authorization=${token_auth}  
    ${response}               DELETE On Session                        serverest        /carrinhos/cancelar-compra/    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Criar Um Carrinho e Armazenar ID
    Criar Carrinho Estatico Valido
    Validar Ter Criado o Carrinho
    ${id_carrinho}        Set Variable        ${response.json()["_id"]}   
    Log To Console       ID Carrinho: ${id_carrinho}
    Set Global Variable    ${id_carrinho}

Validar Ter Criado o Carrinho
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 



GET Endpoint Carrinho Não Encontrado
    ${response}               GET On Session        serverest        /carrinhos/12586    expected_status=400
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}
