#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Library              Collections
Library              OperatingSystem
#Importando tudo o que está na pasta suporte para dentro do arquivo base:
Resource             ./common/common.robot
Resource             ./fixtures/dynamics.robot
Resource             ./variables/serverest_variables.robot

Resource             ../keywords/usuarios_keywords.robot
Resource             ../keywords/login_keywords.robot
Resource             ../keywords/carrinho_keywords.robot
Resource             ../keywords/produtos_keywords.robot
Resource             ../consumir_library_python.robot

*** Keywords ***
Criar Sessao              
    Create Session        serverest    ${BASE_URI}  




