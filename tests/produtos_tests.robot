*** Settings ***
Documentation        Arquivo de testes para endpoint /produtos
Resource             ../keywords/produtos_keywords.robot
Resource             ../keywords/login_keywords.robot
Resource             ../consumir_library_python.robot

Suite Setup          Criar Sessao    

*** Test Cases ***
Cenario 13: GET Listar Todos os Produtos 200
    [Tags]    GETALLPROD    
    GET Endpoint /produtos
    Validar Status Code "200"
    Validar Quantidade Total "${3}"
    Validar Nome Produto Cadastrado "Logitech MX Vertical"
    # Validar Quantidade de Produtos "Mouse"

Cenario: POST Criar Produto de Massa Dinamica 201
    [Tags]    POSTPRODDIN201
    Fazer Login e Armazenar Token
    Cadastrar Produto Dinamico Valido 
    Validar Status Code "201"

Cenario 14: POST Criar Produto 201
    [Tags]    POSTPROD201
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    Validar Status Code "201"
    DELETE Endpoint /produtos

Cenario 15: POST Criar Produto Nome Já Existente 400
   [Tags]    POSTPROD400
    Fazer Login e Armazenar Token
    Criar Produto Estatico Invalido
    POST Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem "Já existe produto com esse nome"

Cenario 16: POST Criar Produto Token Inválido 401
   [Tags]    POSTPROD401    
    Criar Produto Token Invalido
    Validar Status Code "401"
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario 17: POST Criar Produto Rota Administrador 403
   [Tags]    POSTPROD403
    Criar Login Estatico Admin False
    Criar Produto Estatico Valido
    POST Endpoint /produtos 
    Validar Status Code "403"
    Validar Mensagem "Rota exclusiva para administradores"

Cenario 18: GET Buscar Produto 200
    [Tags]     GETPROD200    
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    GET Endpoint /produtos/id
    Validar Status Code "200"
    Validar Nome Produto Buscado "Monitor Logitech"
    DELETE Endpoint /produtos

Cenario 19: GET Buscar Produto Não Encontrado 400
    [Tags]     GETPROD400
    Selecionar ID Produto Invalido
    GET Endpoint /produtos/id
    Validar Status Code "400"
    Validar Mensagem "Produto não encontrado"

Cenario 20: DELETE Excluir Produto 200
    [Tags]    DELETEPROD200
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
    GET Endpoint /produtos/id
    Validar Mensagem "Produto não encontrado"

Cenario 21: DELETE Excluir Produto Carrinho 400 
    [Tags]    DELETEPROD400
    Fazer Login e Armazenar Token
    Selecionar ID Produto Carrinho
    DELETE Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem "Não é permitido excluir produto que faz parte de carrinho"

Cenario 22: DELETE Excluir Produto Token Inválido 401
    [Tags]    DELETEPROD401
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Produto Token Invalido
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 23: DELETE Excluir Produto Rota Administrador 403
    [Tags]    DELETEPROD403
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Produto Admin False
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 24: PUT Editar Produto 200
    [Tags]     PUTPROD200
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Endpoint /produtos/id
    Validar Status Code "200"
    GET Endpoint /produtos/id
    DELETE Endpoint /produtos

Cenario 25: PUT Editar Produto Cadastro 201
    [Tags]     PUTPROD201
    Fazer Login e Armazenar Token
    Criar Produto Estatico Valido
    PUT Endpoint Cadastro /produtos/id
    Validar Status Code "201"
    Validar Ter Criado o Produto
    GET Endpoint /produtos/id
    DELETE Endpoint /produtos

Cenario 26: PUT Editar Produto Nome Já Existente 400
   [Tags]     PUTPROD400
    Fazer Login e Armazenar Token
    PUT Endpoint Cadastro Produto Inválido
    Validar Status Code "400"
    Validar Mensagem Produto Invalido

Cenario 27: PUT Editar Produto Token Inválido 401
    [Tags]     PUTPROD401
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Token Invalido
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 28: PUT Editar Produto Rota Administrador 403
    [Tags]     PUTPROD403
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Admin False
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos
