*** Settings ***
Documentation        Arquivo de testes para Library Python
Library              library_test.py

*** Test Cases ***
Teste Library 1
#Chamar a função da library com espaços e o parâmetro desejado, que nesse caso precisa ser um número inteiro:
    ${json}            Get Endpoint Usuarios Tantas Vezes    ${5} 
    Log To Console     ${json}       

Teste Library 2
    ${users}            Pegar Quantidade Usuarios Cadastrados
    Log To Console      ${users}