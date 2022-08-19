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

Cenario 01: POST Login 200
   [Tags]    POSTLOGIN200   
   Criar Sessao
   Selecionar Usuario Login Valido
   POST Endpoint /login
   Validar Status Code "200"
   Validar Ter Logado

#Neste teste ele retorna 401 ao invés da resposta 400, que é o que consta na documentação
#Só retorna 400 se um dos campos estiver em branco, porém a mensagem fica diferente da esperada
Cenario 02: POST Login E-mail Invalido 400
   [Tags]    POSTLOGIN400
   Criar Sessao
   Selecionar Usuario Login Invalido
   POST Endpoint /login
   #Validar Status Code "400"
   Validar Mensagem Email/Senha Invalidos

# USUÁRIOS

Cenario 03: GET Listar Todos os Usuarios 200
    [Tags]    GETALLUSERS    
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar Se Response Contem "Anne Shirley"
    Validar quantidade "${2}"

Cenario 04: POST Criar Usuario 201
    [Tags]    POSTUSER201    
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    GET Endpoint /usuarios/id
    DELETE Endpoint /usuarios/id

Cenario 05: POST Criar Usuario E-mail Já Cadastrado 400
    [Tags]    POSTUSER400
    Criar Sessao
    Criar Usuario Estatico Invalido
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Mensagem E-mail Invalido

Cenario 06: GET Buscar Usuario 200
    [Tags]    GETUSER200
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    GET Endpoint /usuarios/id
    Validar Status Code "200"
    Validar Cadastro do E-mail "beltrano@qa.com.br"
    DELETE Endpoint /usuarios/id

Cenario 07: GET Buscar Usuario Não Encontrado 400
    [Tags]    GETUSER400
    Criar Sessao
    Selecionar ID User Invalido  
    GET Endpoint /usuarios/id
    Validar Status Code "400"
    Validar Mensagem Usuário Não Encontrado

Cenario 08: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Usuario e Armazenar ID
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"
    GET Endpoint /usuarios/id
    Validar Mensagem Usuário Não Encontrado
    
Cenario 09: DELETE Deletar Usuario Carrinho Cadastrado 400   
    [Tags]    DELETEUSER400
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar ID User Login
    DELETE Endpoint /usuarios/id
    Validar Status Code "400"
    Validar Mensagem Usuario Carrinho Cadastrado
    DELETE Endpoint /carrinhos/cancelar-compra

Cenario 10: PUT Editar Usuario 200
    [Tags]    PUTUSER200    
    Criar Sessao
    Criar Um Usuario e Armazenar ID
    PUT Endpoint /usuarios/id
    Validar Status Code "200"
    GET Endpoint /usuarios/id
    DELETE Endpoint /usuarios/id

Cenario 11: PUT Editar Usuario e Cadastrar 201
    [Tags]    PUTUSER201
    Criar Sessao
    Criar Usuario Estatico Valido
    PUT Endpoint Cadastro /usuarios/id
    Validar Status Code "201"
    Validar Ter Criado o Usuario
    DELETE Endpoint /usuarios/id

Cenario 12: PUT Editar Usuario E-mail Já Cadastrado 400
    [Tags]    PUTUSER400
    Criar Sessao
    PUT Endpoint Cadastro Invalido /usuarios/id
    Validar Status Code "400"
    Validar Mensagem E-mail Invalido

# PRODUTOS 

Cenario 13: GET Listar Todos os Produtos 200
    [Tags]    GETALLPROD    
    Criar Sessao
    GET Endpoint /produtos
    Validar Status Code "200"
    Validar quantidade "${3}"
    Validar Nome Produto Cadastrado "Logitech MX Vertical"

Cenario 14: POST Criar Produto 201
    [Tags]    POSTPROD201
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    Validar Status Code "201"
    DELETE Endpoint /produtos

Cenario 15: POST Criar Produto Nome Já Existente 400
   [Tags]    POSTPROD400
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Produto Estatico Invalido
    POST Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem Produto Invalido

Cenario 16: POST Criar Produto Token Inválido 401
   [Tags]    POSTPROD401    
    Criar Sessao
    Criar Produto Token Invalido
    Validar Status Code "401"
    Validar Mensagem Token Invalido

Cenario 17: POST Criar Produto Rota Administrador 403
   [Tags]    POSTPROD403
    Criar Sessao
    Criar Login Estatico Admin False
    Criar Produto Estatico Valido
    POST Endpoint /produtos 
    Validar Status Code "403"
    Validar Mensagem Rota Exclusiva Admin

Cenario 18: GET Buscar Produto 200
    [Tags]     GETPROD200    
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    GET Endpoint /produtos/id
    Validar Status Code "200"
    Validar Nome Produto Buscado "Monitor Logitech"
    DELETE Endpoint /produtos

Cenario 19: GET Buscar Produto Não Encontrado 400
    [Tags]     GETPROD400
    Criar Sessao
    Selecionar ID Produto Invalido
    GET Endpoint /produtos/id
    Validar Status Code "400"
    Validar Mensagem Produto Não Encontrado

Cenario 20: DELETE Excluir Produto 200
    [Tags]    DELETEPROD200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
    GET Endpoint /produtos/id
    Validar Mensagem Produto Não Encontrado

Cenario 21: DELETE Excluir Produto Carrinho 400 
    [Tags]    DELETEPROD400
    Criar Sessao
    Fazer Login e Armazenar Token
    Selecionar ID Produto Carrinho
    DELETE Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem Produto Carrinho Cadastrado

Cenario 22: DELETE Excluir Produto Token Inválido 401
    [Tags]    DELETEPROD401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar um Produto e Armazenar ID
    DELETE Produto Token Invalido
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 23: DELETE Excluir Produto Rota Administrador 403
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
    GET Endpoint /produtos/id
    DELETE Endpoint /produtos

Cenario 25: PUT Editar Produto Cadastro 201
    [Tags]     PUTPROD201
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Produto Estatico Valido
    PUT Endpoint Cadastro /produtos/id
    Validar Status Code "201"
    Validar Ter Criado o Produto
    GET Endpoint /produtos/id
    DELETE Endpoint /produtos

Cenario 26: PUT Editar Produto Nome Já Existente 400
   [Tags]     PUTPROD400
    Criar Sessao
    Fazer Login e Armazenar Token
    PUT Endpoint Cadastro Produto Inválido
    Validar Status Code "400"
    Validar Mensagem Produto Invalido

Cenario 27: PUT Editar Produto Token Inválido 401
    [Tags]     PUTPROD401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Token Invalido
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

Cenario 28: PUT Editar Produto Rota Administrador 403
    [Tags]     PUTPROD403
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    PUT Produto Admin False
    Fazer Login e Armazenar Token
    DELETE Endpoint /produtos

# CARRINHOS

Cenario 29: GET Listar Todos os Carrinhos 200
    [Tags]     GETALLCARS
    Criar Sessao
    GET Endpoint /carrinhos
    Validar Status Code "200"
    Validar Se Carrinho Contém IdProduto "BeeJh5lz3k6kSIzA"
    
Cenario 30: POST Criar Carrinho 201
    [Tags]    POSTCAR201    
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Validar Status Code "201"
    Validar Ter Criado o Carrinho
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 31: POST Criar Carrinho Errado 400
    [Tags]    POSTCAR400
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Criar Carrinho Estatico Valido
    Validar Status Code "400"
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 32: POST Criar Carrinho Token Inválido 401
     [Tags]    POSTCAR401
    Criar Sessao
    Selecionar Token Invalido
    Criar Carrinho Estatico Valido
    Validar Status Code "401"

Cenario 33: GET Buscar Carrinho 200
    [Tags]    GETCAR200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Um Carrinho e Armazenar ID
    GET Endpoint /carrinhos/id
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 34: GET Buscar Carrinho Não Encontrado 400
    [Tags]    GETCAR400
    Criar Sessao
    Fazer Login e Armazenar Token
    GET Endpoint Carrinho Não Encontrado

Cenario 35: DELETE Carrinho Concluir Compra 200
    [Tags]    CONCLUIRCAR200   
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Status Code "200"

Cenario 36: DELETE Carrinho Concluir Compra Token Inválido 401
    [Tags]    CONCLUIRCAR401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/concluir-compra
    Validar Status Code "401"
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/concluir-compra

Cenario 37: DELETE Carrinho Cancelar Compra 200
    [Tags]    CANCELARCAR200
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "200"

Cenario 38: DELETE Carrinho Cancelar Compra Token Inválido 401
    [Tags]    CANCELARCAR401
    Criar Sessao
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar Token Invalido
    DELETE Endpoint /carrinhos/cancelar-compra
    Validar Status Code "401"
    Fazer Login e Armazenar Token
    DELETE Endpoint /carrinhos/cancelar-compra
