*** Settings ***
Documentation        Arquivo de testes para endpoint /usuarios
Resource             ../keywords/usuarios_keywords.robot

Suite Setup          Criar Sessao
Suite Teardown        

*** Test Cases ***
Cenario: POST Criar Usuario de Massa Dinamica 201
    [Tags]    POSTUSERDIN201
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    Validar Status Code "201"
    DELETE Endpoint /usuarios/id

Cenario 03: GET Listar Todos os Usuarios 200
    [Tags]    GETALLUSERS    
    GET Endpoint /usuarios
    Validar Status Code "200"
    # Validar Se Response Contem "Anne Shirley"
    # Validar quantidade "${2}"

Cenario 04: POST Criar Usuario Massa Estatica 201
    [Tags]    POSTUSER201    
    Criar Usuario Estatico Valido
    POST Endpoint /usuarios
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    GET Endpoint /usuarios/id
    DELETE Endpoint /usuarios/id

# Cenario 05: POST Criar Usuario E-mail Já Cadastrado 400
#     [Tags]    POSTUSER400
#     Criar Usuario Estatico Invalido
#     POST Endpoint /usuarios
#     Validar Status Code "400"
#     Validar Mensagem E-mail Invalido

# Cenario 06: GET Buscar Usuario 200
#     [Tags]    GETUSER200
#     Criar Um Usuario e Armazenar ID
#     GET Endpoint /usuarios/id
#     Validar Status Code "200"
#     Validar Cadastro do E-mail "beltrano@qa.com.br"
#     DELETE Endpoint /usuarios/id

# Cenario 07: GET Buscar Usuario Não Encontrado 400
#     [Tags]    GETUSER400
#     Selecionar ID User Invalido  
#     GET Endpoint /usuarios/id
#     Validar Status Code "400"
#     Validar Mensagem Usuário Não Encontrado

Cenario 08: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER200
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"
    # GET Endpoint /usuarios/id
    # Validar Mensagem Usuário Não Encontrado
    
# Cenario 09: DELETE Deletar Usuario Carrinho Cadastrado 400   
#     [Tags]    DELETEUSER400
#     Fazer Login e Armazenar Token
#     Criar Carrinho Estatico Valido
#     Selecionar ID User Login
#     DELETE Endpoint /usuarios/id
#     Validar Status Code "400"
#     Validar Mensagem Usuario Carrinho Cadastrado
#     DELETE Endpoint /carrinhos/cancelar-compra

Cenario 10: PUT Editar Usuario 200
    [Tags]    PUTUSER200    
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    PUT Endpoint /usuarios
    Validar Status Code "200"
    # GET Endpoint /usuarios/id
    DELETE Endpoint /usuarios/id

# Cenario 11: PUT Editar Usuario e Cadastrar 201
#     [Tags]    PUTUSER201
#     Criar Usuario Estatico Valido
#     PUT Endpoint Cadastro /usuarios/id
#     Validar Status Code "201"
#     Validar Ter Criado o Usuario
#     DELETE Endpoint /usuarios/id

# Cenario 12: PUT Editar Usuario E-mail Já Cadastrado 400
#     [Tags]    PUTUSER400
#     PUT Endpoint Cadastro Invalido /usuarios/id
#     Validar Status Code "400"
#     Validar Mensagem E-mail Invalido