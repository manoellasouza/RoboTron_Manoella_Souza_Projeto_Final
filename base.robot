#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Resource             ./usuarios_keywords.robot
Resource             ./login_keywords.robot
Resource             ./produtos_keywords.robot
Resource             ./common.robot

#Seção para criação dos cenários de teste. Escrita baseada em ações
*** Test Cases ***

Cenario: POST Fazer Login 200
   [Tags]    POSTLOGIN
   Criar Sessao
   POST Endpoint /login
   Validar Status Code "200"

Cenario: GET Todos os Usuarios 200
    [Tags]    GET
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    #Validar quantidade "${21}"
    Printar Conteudo Response

Cenario: POST Cadastrar Usuario 201
    [Tags]    POST    
    Criar Sessao
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Se Mensagem Contem "sucesso" 

Cenario: POST Criar Usuario de Massa Estatica 201
    [Tags]    POSTUSERESTATICO
    Criar Sessao
    Criar Usuario Estatico Valido
    Validar Status Code "201"

Cenario: GET Usuario Específico 200
    [Tags]    GET
    Criar Sessao
    GET Endpoint /usuarios/id
    Validar Status Code "200"

Cenario: PUT Editar Usuario 200
    [Tags]    PUT
    Criar Sessao
    PUT Endpoint /usuarios/id
    Validar Status Code "200"

#Cenario: PUT Editar Usuario 201
#   Criar Sessao
#   PUT Endpoint /usuarios/"${id}"

Cenario: DELETE Deletar Usuario 200
    [Tags]    DELETE
    Criar Sessao
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"

Cenario: GET Todos os Produtos 200
    [Tags]    GETPRODUTOS
    Criar Sessao
    GET Endpoint /produtos
    Validar Status Code "200"
    #Validar quantidade "${4}"
    Printar Conteudo Response

Cenario: POST Criar Produto 201
    [Tags]    POSTPRODUTOS
    Criar Sessao
    Fazer Login e Armazenar Token
    POST Endpoint /produtos    
    Validar Status Code "201"

# Cenario: GET Produto Específico 200

# Cenario: PUT Editar Produto 200

# Cenario: PUT Editar Produto 201

Cenario: DELETE Excluir produto 200
    [Tags]    DELETEPRODUTO
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

#Seção para criação de Keywords Personalizadas
*** Keywords ***
Criar Sessao              #nome (alias)       #url
    Create Session        serverest    https://serverest.dev/