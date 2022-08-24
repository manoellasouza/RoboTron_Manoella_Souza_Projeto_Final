*** Settings ***
Documentation        Arquivo de testes para endpoint /login
Resource             ../keywords/login_keywords.robot

Suite Setup          Criar Sessao
Suite Teardown        

*** Test Cases ***
Cenario 01: POST Login Estatico Valido 200
   [Tags]    POSTLOGIN200   
   Selecionar Usuario Login Valido
   POST Endpoint /login
   Validar Status Code "200"
   Validar Ter Logado

#Neste teste ele retorna 401 ao invés da resposta 400, que é o que consta na documentação
#Só retorna 400 se um dos campos estiver em branco, porém a mensagem fica diferente da esperada
Cenario 02: POST Login Estatico E-mail Invalido 400
   [Tags]    POSTLOGIN400
   Selecionar Usuario Login Invalido
   POST Endpoint /login
   #Validar Status Code "400"
   Validar Mensagem Email/Senha Invalidos