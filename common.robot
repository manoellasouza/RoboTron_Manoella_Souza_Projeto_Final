*** Settings ***
Documentation        Keywords e Variaveis para Ações Gerais
Library              OperatingSystem  


*** Keywords ***
Criar Sessao              
    Create Session        serverest    http://localhost:3000

Validar Status Code "${statuscode}"
    Should Be True        ${response.status_code} == ${statuscode} 
    Log To Console        Status Code Retornado: ${response.status_code}

Printar Conteudo Response 
    Log To Console            Response: ${response.json()} 
     #Log To Console            Nome: ${response.json()["usuarios"][1]["nome"]} 
Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}

Validar Ter Criado o Usuario
    Should Be Equal            ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty        ${response.json()["_id"]} 

Validar Mensagem Rota Exclusiva Admin
    Should Be Equal            ${response.json()["message"]}    Rota exclusiva para administradores

Validar Mensagem E-mail Invalido
    Should Be Equal            ${response.json()["message"]}    Este email já está sendo usado

Validar Mensagem Token Invalido
    Should Be Equal            ${response.json()["message"]}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

Selecionar Token Invalido
    ${token_auth}             Set Variable        12563737   
    Set Global Variable       ${token_auth}

Selecionar ID Produto Invalido
    ${id_produto}             Set Variable        12563737
    Set Global Variable       ${id_produto}
