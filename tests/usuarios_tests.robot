*** Settings ***
Documentation        Arquivo de testes para endpoint /usuarios
Resource             ../support/base.robot
Suite Setup          Criar Sessao 

*** Test Cases ***

Cenario 01: GET Listar Todos os Usuarios 200
    [Tags]    GETALLUSERS    
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar Quantidade Total "${3}"
    Validar Quantidade Usuários Administradores
    Validar Se Dado Cadastro Existe "zequinha@qa.com.br"
    
Cenario 02: POST Criar Usuario Massa Estatica 201
    [Tags]    POSTUSERESTATICO 
    Selecionar Usuario Estatico "user_valido"
    POST Endpoint /usuarios
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    DELETE Endpoint /usuarios/id

Cenario 03: POST Criar Usuario de Massa Dinamica 201
    [Tags]    POSTUSERDINAMICO
    Criar Dados Usuario Dinamico Valido
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Ter Criado o Usuario
    Validar Se Dado Cadastro Existe "${nome}"
    DELETE Endpoint /usuarios/id

Cenario 04: POST Criar Usuario E-mail Já Cadastrado 400
    [Tags]    POSTUSEREMAIL
    Selecionar Usuario Estatico "user_email_cadastrado"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Mensagem "Este email já está sendo usado"

Cenario 05: POST Criar Usuario E-mail Inválido 400
    [Tags]    POSTUSEREMAILINVALIDO
    Selecionar Usuario Estatico "user_email_invalido"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "email" 

Cenario 06: POST Criar Usuario Sem E-mail 400
    [Tags]    POSTUSEREMAILINVALIDO
    Selecionar Usuario Estatico "user_sem_email"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "email"  
    
Cenario 07: POST Criar Usuario Sem Senha 400
    [Tags]    POSTUSERSEMSENHA
    Selecionar Usuario Estatico "user_sem_senha"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "password"  

Cenario 08: POST Criar Usuario Sem Nome 400
    [Tags]    POSTUSERSEMNOME
    Selecionar Usuario Estatico "user_sem_nome"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "nome"  

Cenario 09: POST Criar Usuario Sem Adm 400
    [Tags]    POSTUSERSEMADM
    Selecionar Usuario Estatico "user_sem_admin"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "administrador"
    
Cenario 10: GET Buscar Usuario 200
    [Tags]    GETUSER
    Criar Um Usuario Dinamico e Armazenar ID
    GET Endpoint /usuarios "${id_user}"
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id
    Validar Se Dado Cadastro Existe "${id_user}"

Cenario 11: GET Buscar Usuario Não Encontrado 400
    [Tags]    GETUSERINVALIDO
    GET Endpoint /usuarios "1586282"
    Validar Status Code "400"
    Validar Mensagem "Usuário não encontrado"

Cenario 12: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER
    Criar Dados Usuario Dinamico Valido
    POST Endpoint /usuarios
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"
    Validar Se Dado Cadastro Existe "${id_user}"

Cenario 13: DELETE Deletar Usuario Inexistente 200
    [Tags]    DELETEUSERINEXISTENTE
    Selecionar ID User "1586282"
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"
    Validar Se Dado Cadastro Existe "${id_user}"
    Validar Mensagem "Nenhum registro excluído"
    
Cenario 14: DELETE Deletar Usuario Carrinho Cadastrado 400   
    [Tags]    DELETEUSERCARRINHO
    Selecionar ID User "oUb7aGkMtSEPf6BZ"
    DELETE Endpoint /usuarios/id
    Validar Status Code "400"
    Validar Mensagem "Não é permitido excluir usuário com carrinho cadastrado"

Cenario 15: PUT Editar Usuario 200
    [Tags]    PUTUSER   
    Selecionar Usuario Estatico "user_valido"
    POST Endpoint /usuarios
    Criar Dados Usuario Dinamico Valido
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "200"
    Validar Se Dado Cadastro Existe "${nome}"
    DELETE Endpoint /usuarios/id

Cenario 16: PUT Editar Usuario e Cadastrar 201
    [Tags]    PUTUSERCADASTRO
    Criar Dados Usuario Dinamico Valido
    PUT Endpoint /usuarios "125893"
    Validar Status Code "201"
    Validar Ter Criado o Usuario
    Validar Se Dado Cadastro Existe "${nome}"
    DELETE Endpoint /usuarios/id

Cenario 17: PUT Editar Usuario E-mail Já Cadastrado 400
    [Tags]    PUTUSEREMAILCAD
    Selecionar Usuario Estatico "user_email_cadastrado"
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "400"
    Validar Mensagem "Este email já está sendo usado"

Cenario 18: PUT Editar Usuario Sem E-mail 400
    [Tags]    PUTUSERSEMEMAIL
    Selecionar Usuario Estatico "user_sem_email"
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "400"
    Validar Erro "email"

Cenario 19: PUT Editar Usuario Sem Senha 400
    [Tags]    PUTUSERSEMSENHA
    Selecionar Usuario Estatico "user_sem_senha"
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "400"
    Validar Erro "password"

Cenario 20: PUT Editar Usuario Sem Nome 400
    [Tags]    PUTUSERSEMNOME
    Selecionar Usuario Estatico "user_sem_nome"
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "400"
    Validar Erro "nome"

Cenario 21: PUT Editar Usuario Sem Adm 400
    [Tags]    PUTUSERSEMADM
    Selecionar Usuario Estatico "user_sem_admin"
    PUT Endpoint /usuarios "${id_user}"
    Validar Status Code "400"
    Validar Erro "administrador"
