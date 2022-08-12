#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary


#Seção para setagem de variáveis para utilização
*** Variables ***
${id}    0uxuPY0cbmQhpEz1  
${idnovo}    U8304Klh3YApcK1R

#Seção para criação dos cenários de teste
*** Test Cases ***

#Cenario: POST Fazer Login 200
#   Criar Sessao
#   POST Endpoint /login

Cenario: GET Todos os Usuarios 200
    [Tags]    GET
    Criar Sessao
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar quantidade "${17}"
    Printar Conteudo Response

Cenario: POST Cadastrar Usuario 201
    [Tags]    POST    
   Criar Sessao
   POST Endpoint /usuarios
   Validar Status Code "201"
   Validar Se Mensagem Contem "sucesso" 

Cenario: GET Usuario Específico 200
    [Tags]    GET
    Criar Sessao
    GET Endpoint /usuarios/id
    Validar Status Code "200"

Cenario: PUT Editar Usuario 200
    [Tags]    PUT
    Criar Sessao
    PUT Endpoint /usuarios/id
    Validar Status Code "200"

Cenario: DELETE Deletar Usuario 200
    [Tags]    DELETE
    Criar Sessao
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"

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
    #Log To Console            Response: ${response.content}

POST Endpoint /usuarios
#variável precisa ser do tipo dict. no robot a variável que vai ser setada
#como dicionario precisa ter um &
    &{payload}                Create Dictionary      nome=Nellie Nelson   email=nellien@gmail.com    password=12345    administrador=true                   
    ${response}               POST On Session        serverest        /usuarios/    data=&{payload}
    #Com a keyword abaixo vai aparecer a mensagem de retorno, nesse caso com o id do usuário no terminal
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /usuarios/id
    ${response}               GET On Session        serverest        /usuarios/${idnovo} 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}


DELETE Endpoint /usuarios/id
    ${response}               DELETE On Session        serverest        /usuarios/${id}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

PUT Endpoint /usuarios/id
    &{payload}                Create Dictionary      nome=Janice de Sousa    email=janicedesousa@gmail.com    password=123    administrador=true                   
    ${response}               PUT On Session         serverest        /usuarios/${idnovo}    data=&{payload}      
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode} 

Validar Quantidade "${quantidade}"
    Should Be Equal    ${response.json()["quantidade"]}    ${quantidade}
                                    #first                   second

Validar Se Mensagem Contem "${palavra}"
    Should Contain    ${response.json()["message"]}    ${palavra}
                                    #container           item

Printar Conteudo Response    #pegar somente o nome do índice 0 (primeiro cadastro) que está na lista de usuários
    Log To Console            Nome: ${response.json()["usuarios"][1]["nome"]}
                             #mostrar todos           
    Log To Console            Response: ${response.json()}