*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos
Resource             ../support/base.robot

*** Keywords ***
GET Endpoint /carrinhos
    ${response}               GET On Session                     serverest            /carrinhos
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

GET Endpoint /carrinhos "${id_carrinho}"
    ${response}               GET On Session                      serverest            /carrinhos/${id_carrinho}          expected_status=any
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

POST Endpoint /carrinhos 
    &{header}                 Create Dictionary                   Authorization=${token_auth}                         
    ${response}               POST On Session                     serverest             /carrinhos           json=&{payload}     headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
    IF    "${response.status_code}" == "201"   
        ${id_carrinho}                   Set Variable        ${response.json()["_id"]} 
        Set Global Variable              ${id_carrinho} 
    END

DELETE Endpoint /carrinhos "${deletar_carrinho}"
    &{header}                 Create Dictionary                  Authorization=${token_auth}  
    ${response}               DELETE On Session                    serverest                   /carrinhos/${deletar_carrinho}    headers=&{header}    expected_status=any
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Selecionar Carrinho Estatico "${carrinho}"
    ${json}                    Importar JSON Estatico        json_carrinho_ex.json  
    ${payload}                 Set Variable                  ${json["${carrinho}"]} 
    Set Global Variable        ${payload} 
    Log To Console             Produtos Selecionados: ${payload}
    IF    "${carrinho}" == "carrinho_valido"   
        Validar Estoque de Produtos "${payload}"
    END

Criar Carrinho Estatico Valido e Armazenar ID
    Selecionar Carrinho Estatico "carrinho_valido"
    POST Endpoint /carrinhos

Validar Ter Criado o Carrinho
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Validar Se Carrinho Contém IdProduto "${idProduto}"
    Should Contain             ${response.json()["carrinhos"][0]["produtos"][0]["idProduto"]}    ${idProduto}
    Log To Console             Carrinho contém IdProduto: ${response.json()["carrinhos"][0]["produtos"][0]["idProduto"]}

Validar Se Carrinho Foi Excluido 
    GET Endpoint /carrinhos "${id_carrinho}"
    Should Be Equal            ${response.json()["message"]}     Carrinho não encontrado


