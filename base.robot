#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary


#Seção para setagem de variáveis para utilização
*** Variables ***
${id}    0uxuPY0cbmQhpEz1  

#Seção para criação dos cenários de teste
*** Test Cases ***

#Cenario: POST Fazer Login 200
#   Criar Sessao
#   POST Endpoint /login

Cenario: GET Todos os Usuarios 200
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"

#Cenario: POST Cadastrar Usuario 200
#   Criar Sessao
#   POST Endpoint /usuarios

Cenario: GET Usuario Específico 200
    Criar Sessao
    GET Endpoint /usuarios/"${id}"
    Validar Status Code "200"

Cenario: DELETE Usuario 200
    Criar Sessao
    DELETE Endpoint /usuarios/"${id}"
    Validar Status Code "200"

#Cenario: PUT Editar Usuario 200
#   Criar Sessao
#   PUT Endpoint /usuarios/"${id}"

#Cenario: PUT Editar Usuario 201
#   Criar Sessao
#   PUT Endpoint /usuarios/"${id}"



#Seção para criação de Keywords Personalizadas
*** Keywords ***
Criar Sessao              #nome (alias)       #url
    Create Session        serverest    https://serverest.dev/

GET Endpoint /usuarios        #guardando a keyword GET on Session dentro da variável 
                                                #esse alias vai puxar a url e complementar com /usuarios           
    ${response}               GET On Session        serverest        /usuarios/
    #Se não setar a variável como global ela só vai valer para esse escopo:
    Set Global Variable       ${response}

GET Endpoint /usuarios/"${id}"
        ${response}               GET On Session        serverest        /usuarios/${id}

DELETE Endpoint /usuarios/"${id}"
        ${response}               DELETE On Session        serverest        /usuarios/${id}

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode} 


