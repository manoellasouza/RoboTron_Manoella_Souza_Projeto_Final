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

# LOGIN

Cenario 01: POST Login Massa Estatica 200
   [Tags]    POSTLOGIN
   Criar Sessao
   Criar Login Estatico Valido
   Validar Status Code "200"

#O teste abaixo está gerando o erro 401 ao invés do 400
#Ao testar no Postman, também é retornado 401. Só retorna 400 se um dos campos estiver em branco.
Cenario 02: POST Login Massa Estatica E-mail Invalido 400
   [Tags]    POSTLOGIN400
   Criar Sessao
   Criar Login Estatico E-mail Invalido
   Validar Status Code "400"
   Validar Mensagem Email/Senha Invalidos

# USUÁRIOS

Cenario 03: GET Todos os Usuarios 200
    [Tags]    GETALLUSERS
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar quantidade "${2}"

Cenario 04: POST Criar Usuario de Massa Estatica 201
    [Tags]    POSTUSER201
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    Validar Status Code "201"
    DELETE Endpoint /usuarios/id

Cenario 05: POST Criar Usuario de Massa Estatica 400
    [Tags]    POSTUSER400
    Criar Sessao
    Criar Usuario E-mail Ja Cadastrado
    Validar Status Code "400"
    Validar Mensagem E-mail Invalido

Cenario 06: GET Usuario Específico 200
    [Tags]    GETUSER
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    GET Endpoint /usuarios/id
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id

Cenario 07: GET Usuario Específico 400
    [Tags]    GETUSERINVALIDO
    Criar Sessao
    GET ID User Inválida 
    Validar Status Code "400"
    Validar Mensagem ID User Invalida

Cenario 08: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Usuario e Armazenar ID
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"

#Cenario 09: DELETE Deletar Usuario 400       Carrinho Cadastrado

Cenario 10: PUT Editar Usuario 200
    [Tags]    PUTUSER
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    PUT Endpoint /usuarios/id
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id

Cenario 11: PUT Editar Usuario 201
    [Tags]    PUTUSER201
    Criar Sessao
    PUT Endpoint Cadastro /usuarios/id
    Validar Status Code "201"
    Validar Ter Criado o Usuario
    DELETE Endpoint /usuarios/id

Cenario 12: PUT Editar Usuario 400
    [Tags]    PUTUSER400
    Criar Sessao
    PUT Endpoint Cadastro Invalido /usuarios/id
    Validar Status Code "400"
    Validar Mensagem E-mail Invalido

# PRODUTOS 

Cenario 13: GET Todos os Produtos 200
    [Tags]    GETALLPROD
    Criar Sessao
    GET Endpoint /produtos
    Validar Status Code "200"
    Validar quantidade "${4}"
    #Printar Conteudo Response

Cenario 14: POST Criar Produto de Massa Estatica 201
    [Tags]    POSTPROD201
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    Validar Status Code "201"
    DELETE Endpoint /produtos

Cenario 15: POST Criar Produto de Massa Estatica 400
   [Tags]    POSTPROD400
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Produto Invalido
    Validar Status Code "400"
    Validar Mensagem Produto Invalido

Cenario 16: POST Criar Produto de Massa Estatica 401
   [Tags]    POSTPROD401
    Criar Sessao
    Criar Produto Token Invalido
    Validar Status Code "401"
    Validar Mensagem Token Invalido

Cenario 17: POST Criar Produto de Massa Estatica 403
   [Tags]    POSTPROD403
    Criar Sessao
    Criar Login Estatico Admin False
    Criar Produto Admin False
    Validar Status Code "403"
    Validar Mensagem Rota Exclusiva Admin

Cenario 18: GET Produto Específico 200
    [Tags]     GETPROD
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    GET Endpoint /produtos/id
    Validar Status Code "200"
    DELETE Endpoint /produtos

Cenario 19: GET Produto Específico 400
    [Tags]     GETPROD400
    Criar Sessao
    GET Endpoint Produto ID Invalido
    Validar Status Code "400"
    Validar Mensagem Produto Não Encontrado

Cenario 20: DELETE Excluir Produto 200
    [Tags]    DELETEPROD200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"

#Cenario 21: DELETE Excluir Produto 400 
#"Não é permitido excluir produto que faz parte de carrinho"

Cenario 22: DELETE Excluir Produto 401
    [Tags]    DELETEPROD401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Produto Token Invalido
    DELETE Endpoint /produtos

Cenario 23: DELETE Excluir Produto 403
    [Tags]    DELETEPROD403
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Produto Admin False
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 24: PUT Editar Produto 200
    [Tags]     PUTPROD200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Endpoint /produtos/id
    Validar Status Code "200"
    DELETE Endpoint /produtos

Cenario 25: PUT Editar Produto 201
    [Tags]     PUTPROD201
    Criar Sessao
    Fazer Login e Armazenar Token
    PUT Endpoint Cadastro /produtos/id
    Validar Status Code "201"
    Validar Ter Criado o Produto
    DELETE Endpoint /produtos

Cenario 26: PUT Editar Produto 400
   [Tags]     PUTPROD400
    Criar Sessao
    Fazer Login e Armazenar Token
    PUT Endpoint Cadastro Produto Inválido
    Validar Status Code "400"
    Validar Mensagem Produto Invalido

Cenario 27: PUT Editar Produto 401
    [Tags]     PUTPROD401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Token Invalido
    DELETE Endpoint /produtos

Cenario 28: PUT Editar Produto 403
    [Tags]     PUTPROD403
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Admin False
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

# CARRINHOS

Cenario 29: GET Todos os Carrinhos 200
    [Tags]     GETALLCAR
    Criar Sessao
    GET Endpoint /carrinhos
    Validar Status Code "200"
    
Cenario 30: POST Criar Carrinho 201
    [Tags]    POSTCARRINHO
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Validar Status Code "201"
    DELETE Endpoint /carrinhos

# Cenario 31: POST Criar Carrinho 400
# Cenario 32: POST Criar Carrinho 401
# Cenario 33: GET Carrinho ID 200
# Cenario 34: GET Carrinho ID 400
# Cenario 35: DELETE Carrinho Concluir Compra 200
# Cenario 36: DELETE Carrinho Concluir Compra 401
# Cenario 37: DELETE Carrinho Cancelar Compra 200
# Cenario 38: DELETE Carrinho Cancelar Compra 401

#Seção para criação de Keywords Personalizadas
*** Keywords ***
Criar Sessao              #nome (alias)       #url
    Create Session        serverest    http://localhost:3000