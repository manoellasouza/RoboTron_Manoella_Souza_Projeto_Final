*** Settings ***
Documentation        Arquivo de testes para endpoint /login
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***

Cenario 01: POST Login Estatico Valido 200
   [Tags]    LOGINVALIDO       
   Selecionar Usuario Login "user_valido"
   POST Endpoint /login
   Validar Status Code "200"
   Validar Ter Logado

Cenario 02: POST Login Estatico E-mail Invalido 401
   [Tags]    EMAILINVALIDO
   Selecionar Usuario Login "user_email_invalido"
   POST Endpoint /login
   # A documentação está incorreta e aponta que o status code deveria retornar 400 ao invés de 401
   # Validar Status Code "400"
   Validar Status Code "401"
   Validar Mensagem "Email e/ou senha inválidos"

Cenario 03: POST Login Estatico Senha Invalida 401
   [Tags]    SENHAINVALIDA
   Selecionar Usuario Login "user_senha_invalida"
   POST Endpoint /login
   # A documentação está incorreta e aponta que o status code deveria retornar 400 ao invés de 401
   # Validar Status Code "400"
   Validar Status Code "401"
   Validar Mensagem "Email e/ou senha inválidos"

Cenario 04: POST Login Estatico E-mail Incorreto 400
# Escrito de forma incorreta: (" ") ou e-mail sem @
   [Tags]    EMAILINCORRETO
   Selecionar Usuario Login "user_email_incorreto"
   POST Endpoint /login
   Validar Status Code "400"
   # A documentação está incorreta e aponta que a mensagem de erro seria "Email e/ou senha inválidos" ao invés de "email": "email deve ser um email válido"
   Validar Erro "email"  
   # Validar Mensagem "Email e/ou senha inválidos"

Cenario 05: POST Login Estatico Email Em Branco 400
   [Tags]    EMAILEMBRANCO
   Selecionar Usuario Login "user_sem_email"
   POST Endpoint /login
   Validar Status Code "400"
   # A documentação está incorreta e aponta que a mensagem de erro seria "Email e/ou senha inválidos" ao invés de "email": "email não pode ficar em branco"
   Validar Mensagem E-mail em Branco
   # Validar Mensagem "Email e/ou senha inválidos"

Cenario 06: POST Login Estatico Senha Em Branco 400
   [Tags]    SENHAEMBRANCO
   Selecionar Usuario Login "user_sem_senha"
   POST Endpoint /login
   Validar Status Code "400"
   # A documentação está incorreta e aponta que a mensagem de erro seria "Email e/ou senha inválidos" ao invés de "password": "password não pode ficar em branco"
   Validar Erro "password"
   # Validar Mensagem "Email e/ou senha inválidos"

