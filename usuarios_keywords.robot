*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Usuarios
Library              RequestsLibrary
Resource             ./common.robot

*** Variables ***
${nome_do_usuario}         Charles Spring 
${email_do_usuario}        charlie.s@gmail.com       
${senha_do_usuario}        12345
${id}        0jhpfVnYUWRYkiMi  
${idnovo}        0jhpfVnYUWRYkiMi

*** Keywords ***
GET Endpoint /usuarios 
    ${response}               GET On Session        serverest        /usuarios
    Set Global Variable       ${response}
    Log To Console            Response: ${response.content}

POST Endpoint /usuarios
    ${response}               POST On Session        serverest        /usuarios/    json=&{payload}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

GET Endpoint /usuarios/id
    ${response}               GET On Session        serverest        /usuarios/${id_user} 
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

DELETE Endpoint /usuarios/id
    ${response}               DELETE On Session        serverest        /usuarios/${id_user}   
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

# PUT Endpoint /usuarios/id
#     &{payload}                Create Dictionary      nome=Janice Sousa    email=janicedesousaa@gmail.com    password=123    administrador=true                   
#     ${response}               PUT On Session         serverest        /usuarios/${idnovo}    data=&{payload}      
#     Log To Console            Response: ${response.content}
#     Set Global Variable       ${response}

PUT Endpoint /usuarios/id
    &{payload}                Create Dictionary      nome=Fulano de Souza    email=beltrano@qa.com.br    password=teste    administrador=true
    ${response}               PUT On Session        serverest        /usuarios/${id_user}    data=&{payload}     
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}

Validar Quantidade "${quantidade}"
    Should Be Equal    ${response.json()["quantidade"]}    ${quantidade}
                                    #first                   second

Validar Se Mensagem Contem "${palavra}"
    Should Contain    ${response.json()["message"]}    ${palavra}
                                    #container           item

Printar Conteudo Response    #pegar somente o nome do índice 0 (primeiro cadastro) que está na lista de usuários
    Log To Console            Nome: ${response.json()["usuarios"][1]["nome"]}
                                    #mostrar todos           
    #Log To Console            Response: ${response.json()}

Criar Usuario Estatico Valido
    ${json}                Importar JSON Estatico        json_usuario_ex.json  
    ${payload}             Set variable                  ${json["user_valido"]} 
    Set Global Variable    ${payload} 
    POST Endpoint /usuarios

Validar Ter Criado o Usuario
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Criar Um Usuario e Armazenar ID
    Criar Usuario Estatico Valido
    Validar Ter Criado o Usuario
    ${id_user}        Set Variable        ${response.json()["_id"]}   
    Log To Console       ID Produto: ${id_user}
    Set Global Variable    ${id_user}

