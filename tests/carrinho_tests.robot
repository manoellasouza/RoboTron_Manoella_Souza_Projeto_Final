*** Settings ***
Documentation        Arquivo de testes para endpoint /carrinho
Resource             ../support/base.robot 
Suite Setup          Criar Sessao

*** Test Cases ***
Cenario 01: GET Listar Todos os Carrinhos 200
    [Tags]     GETALLCARS
    GET Endpoint /carrinhos
    Validar Status Code "200"
    Validar Se Carrinho Contém IdProduto "BeeJh5lz3k6kSIzA"
    
Cenario 02: POST Criar Carrinho 201
    [Tags]    POSTCAR
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido e Armazenar ID
    Validar Status Code "201"
    Validar Ter Criado o Carrinho
    DELETE Endpoint /carrinhos "concluir-compra"

Cenario 03: POST Criar Carrinho Errado 400
    [Tags]    POSTCARDUPLICADO
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido e Armazenar ID
    Criar Carrinho Estatico Valido e Armazenar ID
    Validar Status Code "400"
    Validar Mensagem "Não é permitido ter mais de 1 carrinho"
    DELETE Endpoint /carrinhos "concluir-compra"

Cenario 04: POST Criar Carrinho Produto Não Encontrado 400
    [Tags]    POSTCARPROD
    Fazer Login e Armazenar Token
    Selecionar Carrinho Estatico "carrinho_sem_produto"
    POST Endpoint /carrinhos
    Validar Status Code "400"
    Validar Mensagem "Produto não encontrado"

Cenario 05: POST Criar Carrinho Produto Duplicado 400
    [Tags]    POSTCARPRODDUPLICADO
    Fazer Login e Armazenar Token
    Selecionar Carrinho Estatico "carrinho_produto_duplicado"
    POST Endpoint /carrinhos
    Validar Status Code "400"
    Validar Mensagem "Não é permitido possuir produto duplicado"

Cenario 06: POST Criar Carrinho Produto Quantidade 400
    [Tags]    POSTCARQTD
    Fazer Login e Armazenar Token
    Selecionar Carrinho Estatico "carrinho_quantidade_insuficiente"
    POST Endpoint /carrinhos
    Validar Status Code "400"
    Validar Mensagem "Produto não possui quantidade suficiente"

Cenario 07: POST Criar Carrinho Token Inválido 401
     [Tags]    POSTCARTOKEN
    Selecionar Token Invalido
    Criar Carrinho Estatico Valido e Armazenar ID
    Validar Status Code "401"
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario 08: GET Buscar Carrinho 200
    [Tags]    GETCAR
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido e Armazenar ID
    GET Endpoint /carrinhos "${id_carrinho}"
    Validar Status Code "200"
    DELETE Endpoint /carrinhos "cancelar-compra"

Cenario 09: GET Buscar Carrinho Não Encontrado 400
    [Tags]    GETCARINVALIDO
    Fazer Login e Armazenar Token
    GET Endpoint /carrinhos "152586"
    Validar Status Code "400"
    Validar Mensagem "Carrinho não encontrado"

Cenario 10: DELETE Carrinho Concluir Compra 200
    [Tags]    CONCLUIRCAR 
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido e Armazenar ID
    DELETE Endpoint /carrinhos "concluir-compra"
    Validar Status Code "200"
    Validar Mensagem "Registro excluído com sucesso"
    Validar Se Carrinho Foi Excluido 

Cenario 11: DELETE Carrinho Concluir Compra 200
    [Tags]    CONCLUIRCARINVALIDO
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos "concluir-compra"
    Validar Status Code "200"
    Validar Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario 12: DELETE Carrinho Concluir Compra Token Inválido 401
     [Tags]    CONCLUIRCARTOKEN
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos "concluir-compra"
    Validar Status Code "401"
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario 13: DELETE Carrinho Cancelar Compra 200
    [Tags]    CANCELARCAR
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido e Armazenar ID
    DELETE Endpoint /carrinhos "cancelar-compra"
    Validar Status Code "200"
    # Na documentação aparece somente "Registro excluído com sucesso":
    Validar Mensagem "Registro excluído com sucesso. Estoque dos produtos reabastecido"
    Validar Se Carrinho Foi Excluido 

Cenario 14: DELETE Carrinho Cancelar Compra 200
    [Tags]    CANCELARCARINVALIDO
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos "cancelar-compra"
    Validar Status Code "200"
    Validar Mensagem "Não foi encontrado carrinho para esse usuário"

Cenario 15: DELETE Carrinho Cancelar Compra Token Inválido 401
     [Tags]    CANCELARTOKEN
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos "cancelar-compra"
    Validar Status Code "401"
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"


# Cenario 35: DELETE Carrinho Concluir Compra 200
#     [Tags]    CONCLUIRCAR 
#     Fazer Login e Armazenar Token
#     Conferir Estoque Produtos
#     # Criar Carrinho Estatico Valido e Armazenar ID
#     # DELETE Endpoint /carrinhos/concluir-compra
#     # Validar Status Code "200"


