*** Settings ***
Documentation        Arquivo de testes para endpoint /produtos
Resource             ../support/base.robot
Suite Setup          Criar Sessao    

*** Test Cases ***
Cenario 01: GET Listar Todos os Produtos 200
    [Tags]    GETALLPROD    
    GET Endpoint /produtos
    Validar Status Code "200"
    Validar Quantidade Total "${7}"
    Validar Se Dado Produto Existe "Mouse"      #nome ou descrição

Cenario 02: POST Criar Produto de Massa Estatica 201
    [Tags]    POSTPRODESTATICO
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_valido"
    POST Endpoint /produtos 
    Validar Status Code "201"
    Validar Ter Criado o Produto
    DELETE Endpoint /produtos

Cenario 03: POST Criar Produto de Massa Dinamica 201
    [Tags]    POSTPRODDINAMICO
    Fazer Login e Armazenar Token
    Criar Dados Produto Valido 
    POST Endpoint /produtos  
    Validar Status Code "201"
    Validar Se Dado Produto Existe "${random_produto}"
    DELETE Endpoint /produtos

Cenario 04: POST Criar Produto Nome Já Existente 400
   [Tags]    POSTPRODNOME
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_invalido"
    POST Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem "Já existe produto com esse nome"

Cenario 05: POST Criar Produto Sem Nome 400
   [Tags]    POSTPRODSEMNOME
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_sem_nome"
    POST Endpoint /produtos 
    Validar Status Code "400"
    Validar Erro Produto "nome" 

Cenario 06: POST Criar Produto Sem Preço 400
   [Tags]    POSTPRODSEMPRECO
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_sem_preco"
    POST Endpoint /produtos 
    Validar Status Code "400"
    Validar Erro Produto "preco" 

Cenario 07: POST Criar Produto Sem Descrição 400
   [Tags]    POSTPRODSEMDESCRICAO
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_sem_descricao"
    POST Endpoint /produtos 
    Validar Status Code "400"
    Validar Erro Produto "descricao" 

Cenario 08: POST Criar Produto Sem Quantidade 400
   [Tags]    POSTPRODSEMQUANTIDADE
    Fazer Login e Armazenar Token
    Selecionar Produto Estatico "produto_sem_quantidade"
    POST Endpoint /produtos 
    Validar Status Code "400"
    Validar Erro Produto "quantidade" 

Cenario 09: POST Criar Produto Token Inválido 401
   [Tags]    POSTPRODTOKEN  
    Selecionar Token Invalido
    Selecionar Produto Estatico "produto_valido"
    POST Endpoint /produtos
    Validar Status Code "401"
    Validar Mensagem "Token de acesso ausente, inválido, expirado ou usuário do token não existe mais"

Cenario 10: POST Criar Produto Rota Administrador 403
   [Tags]    POSTPRODADM
    Criar Login Estatico Admin False
    Selecionar Produto Estatico "produto_valido"
    POST Endpoint /produtos 
    Validar Status Code "403"
    Validar Mensagem "Rota exclusiva para administradores"

Cenario 11: GET Buscar Produto 200
    [Tags]     GETPROD    
    Fazer Login e Armazenar Token
    Criar Um Produto Dinamico e Armazenar ID
    GET Endpoint /produtos "${id_produto}"
    Validar Status Code "200"
    DELETE Endpoint /produtos
    Validar Se Dado Produto Existe "${random_produto}"

Cenario 12: GET Buscar Produto Não Encontrado 400
    [Tags]     GETPRODINVALIDO
    GET Endpoint /produtos "15892"
    Validar Status Code "400"
    Validar Mensagem "Produto não encontrado"

Cenario 13: DELETE Excluir Produto 200
    [Tags]    DELETEPROD
    Fazer Login e Armazenar Token
    Criar Um Produto Dinamico e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
    Validar Se Dado Produto Existe "${random_produto}"

Cenario 14: DELETE Excluir Produto Carrinho 400 
    [Tags]    DELETEPRODCARRINHO
    Fazer Login e Armazenar Token
    Selecionar ID Produto "BeeJh5lz3k6kSIzA"
    DELETE Endpoint /produtos
    Validar Status Code "400"
    Validar Mensagem "Não é permitido excluir produto que faz parte de carrinho"

Cenario 15: DELETE Excluir Produto Inexistente 200 
    [Tags]    DELETEPRODINVALIDO
    Fazer Login e Armazenar Token
    Selecionar ID Produto "158625"
    DELETE Endpoint /produtos
    Validar Status Code "200"
    Validar Mensagem "Nenhum registro excluído"






# Cenario 22: DELETE Excluir Produto Token Inválido 401
#     [Tags]    DELETEPROD401
#     Fazer Login e Armazenar Token
#     Criar um Produto e Armazenar ID
#     DELETE Produto Token Invalido
#     Fazer Login e Armazenar Token
#     DELETE Endpoint /produtos

# Cenario 23: DELETE Excluir Produto Rota Administrador 403
#     [Tags]    DELETEPROD403
#     Fazer Login e Armazenar Token
#     Criar um Produto e Armazenar ID
#     DELETE Produto Admin False
#     Fazer Login e Armazenar Token
#     DELETE Endpoint /produtos

# Cenario 24: PUT Editar Produto 200
#     [Tags]     PUTPROD200
#     Fazer Login e Armazenar Token
#     Criar Um Produto e Armazenar ID
#     PUT Endpoint /produtos/id
#     Validar Status Code "200"
#     GET Endpoint /produtos "${id_produto}"
#     DELETE Endpoint /produtos

# Cenario 25: PUT Editar Produto Cadastro 201
#     [Tags]     PUTPROD201
#     Fazer Login e Armazenar Token
#     Criar Produto Estatico Valido
#     PUT Endpoint Cadastro /produtos/id
#     Validar Status Code "201"
#     Validar Ter Criado o Produto
#     GET Endpoint /produtos "${id_produto}"
#     DELETE Endpoint /produtos

# Cenario 26: PUT Editar Produto Nome Já Existente 400
#    [Tags]     PUTPROD400
#     Fazer Login e Armazenar Token
#     PUT Endpoint Cadastro Produto Inválido
#     Validar Status Code "400"
#     Validar Mensagem Produto Invalido

# Cenario 27: PUT Editar Produto Token Inválido 401
#     [Tags]     PUTPROD401
#     Fazer Login e Armazenar Token
#     Criar Um Produto e Armazenar ID
#     PUT Produto Token Invalido
#     Fazer Login e Armazenar Token
#     DELETE Endpoint /produtos

# Cenario 28: PUT Editar Produto Rota Administrador 403
#     [Tags]     PUTPROD403
#     Fazer Login e Armazenar Token
#     Criar Um Produto e Armazenar ID
#     PUT Produto Admin False
#     Fazer Login e Armazenar Token
#     DELETE Endpoint /produtos
