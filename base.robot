#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Resource             ./usuarios_keywords.robot
Resource             ./login_keywords.robot
Resource             ./produtos_keywords.robot
Resource             ./carrinho_keywords.robot
Resource             ./common.robot

#Seção para criação dos cenários de teste. Escrita baseada em ações
*** Test Cases ***

Cenario: POST Login Massa Estatica 200
   [Tags]    POSTLOGIN
   Criar Sessao
   Criar Login Estatico Valido
   Validar Status Code "200"

Cenario: GET Todos os Usuarios 200
    [Tags]    GETALLUSERS
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar quantidade "${1}"

Cenario: POST Criar Usuario de Massa Estatica 201
    [Tags]    POSTUSERESTATICO
    Criar Sessao
    Criar Usuario Estatico Valido
    Validar Status Code "201"

Cenario: GET Usuario Específico 200
    [Tags]    GETUSER
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    GET Endpoint /usuarios/id
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id

Cenario: PUT Editar Usuario 200
    [Tags]    PUTUSER
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    PUT Endpoint /usuarios/id
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id

#Cenario: PUT Editar Usuario 201
#   Criar Sessao
#   PUT Endpoint /usuarios/"${id}"

Cenario: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Usuario e Armazenar ID
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"

Cenario: GET Todos os Produtos 200
    [Tags]    GETALLPROD
    Criar Sessao
    GET Endpoint /produtos
    Validar Status Code "200"
    Validar quantidade "${3}"
    #Printar Conteudo Response

Cenario: POST Criar Produto de Massa Estatica 201
    [Tags]    POSTPRODESTATICO
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Produto Estatico Valido
    Validar Status Code "201"

Cenario: GET Produto Específico 200
    [Tags]     GETPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    GET Endpoint /produtos/id
    Validar Status Code "200"
    DELETE Endpoint /produtos

Cenario: PUT Editar Produto 200
    [Tags]     PUTPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Endpoint /produtos/id
    Validar Status Code "200"
    DELETE Endpoint /produtos


# Cenario: PUT Editar Produto 201

Cenario: DELETE Excluir Produto 200
    [Tags]    DELETEPRO
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

Cenario: GET Todos os Carrinhos 200
    [Tags]     GETALLCAR
    Criar Sessao
    GET Endpoint /carrinhos
    Validar Status Code "200"
    
Cenario: POST Criar Carrinho 201
    [Tags]    POSTCARRINHO
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Validar Status Code "201"
    DELETE Endpoint /carrinhos



#Seção para criação de Keywords Personalizadas
*** Keywords ***
Criar Sessao              #nome (alias)       #url
    Create Session        serverest    http://localhost:3000