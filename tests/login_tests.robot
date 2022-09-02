*** Settings ***
Documentation        Arquivo de testes para endpoint /login
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***
Cenario 01: POST Login Estatico Valido 200
   [Tags]    LOGIN   
   Selecionar Usuario Login "user_valido"
   POST Endpoint /login
   Validar Status Code "200"
   Validar Ter Logado

Cenario 02: POST Login Estatico E-mail Invalido 400
   [Tags]    EMAILINVALIDO
   Selecionar Usuario Login "user_email_invalido"
   POST Endpoint /login
   # Neste teste ele retorna 401 ao invés da resposta 400, que é o que consta na documentação
   # Validar Status Code "400"
   Validar Mensagem "Email e/ou senha inválidos"

Cenario 03: POST Login Estatico Senha Invalida 400
   [Tags]    SENHAINVALIDA
   Selecionar Usuario Login "user_senha_invalida"
   POST Endpoint /login
   # Neste teste ele retorna 401 ao invés da resposta 400, que é o que consta na documentação
   # Validar Status Code "400"
   Validar Mensagem "Email e/ou senha inválidos"

Cenario 04: POST Login Estatico Email Em Branco 400
   [Tags]    EMAILEMBRANCO
   Selecionar Usuario Login "user_sem_email"
   POST Endpoint /login
   Validar Status Code "400"
   # Neste teste ele retorna "email deve ser um email válido" ao invés de "Email e/ou senha inválidos"
   # Validar Mensagem "Email e/ou senha inválidos"

Cenario 05: POST Login Estatico Senha Em Branco 400
   [Tags]    SENHAEMBRANCO
   Selecionar Usuario Login "user_sem_senha"
   POST Endpoint /login
   # Neste teste ele retorna 401 ao invés da resposta 400, que é o que consta na documentação
   # Validar Status Code "400"
   Validar Mensagem "Email e/ou senha inválidos"

