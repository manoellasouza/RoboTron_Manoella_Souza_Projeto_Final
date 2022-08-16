*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ./common.robot
Resource             ./login_keywords.robot

*** Variables ***

*** Keywords ***

GET Endpoint /carrinhos
    ${response}               GET On Session        serverest        /carrinhos
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

POST Endpoint /carrinhos 
    &{header}                 Create Dictionary      Authorization=${token_auth}                         
    ${response}               POST On Session        serverest        /carrinhos    json=&{payload}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

# Criar Carrinho Estatico Valido
#     ${json}                Importar JSON Estatico        json_carrinho_ex.json  
#     ${payload}             Set variable                  ${json["produtos"[0]]} 
#     Set Global Variable    ${payload} 
#     Log To Console            Response: ${payload.content}
#     POST Endpoint /carrinhos


Criar Carrinho Estatico Valido
    ${json}                Importar JSON Estatico        json_carrinho_ex.json  
    ${payload}             Set variable                  ${json["produtos"[0]]} 
    Set Global Variable    ${payload} 
    Log To Console            Response: ${payload.content}
    POST Endpoint /carrinhos





DELETE Endpoint /carrinhos
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    ${response}               DELETE On Session        serverest        /carrinhos    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
