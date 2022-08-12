*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Usuarios

*** Variables ***
${nome_do_usuario}         Charles Spring 
${email_do_usuario}        charlie.s@gmail.com       
${senha_do_usuario}        12345
${id}        0uxuPY0cbmQhpEz1  
${idnovo}        fAwnXdthZAJrrU5I

*** Keywords ***
GET Endpoint /usuarios        #guardando a keyword GET on Session dentro da variável 
                                                #esse alias vai puxar a url e complementar com /usuarios           
    ${response}               GET On Session        serverest        /usuarios/
    #Se não setar a variável como global ela só vai valer para esse escopo:
    Set Global Variable       ${response}
    #Log To Console            Response: ${response.content}

POST Endpoint /usuarios
#variável precisa ser do tipo dict. no robot a variável que vai ser setada
#como dicionario precisa ter um &
    &{payload}                Create Dictionary      nome=${nome_do_usuario}   email=${email_do_usuario}    password=${senha_do_usuario}    administrador=true                   
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
    &{payload}                Create Dictionary      nome=Janice Sousa    email=janicedesousaa@gmail.com    password=123    administrador=true                   
    ${response}               PUT On Session         serverest        /usuarios/${idnovo}    data=&{payload}      
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
