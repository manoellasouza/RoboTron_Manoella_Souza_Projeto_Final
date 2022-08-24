*** Settings ***
Documentation        Keywords e Variaveis para Ações Gerais
Library              OperatingSystem  


*** Keywords ***

Validar Status Code "${statuscode}"
    Should Be True        ${response.status_code} == ${statuscode} 
    Log To Console        Status Code Retornado: ${response.status_code}

Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/support/fixtures/static/${nome_arquivo} 
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

Validar Se Response Contem "${palavra}"
    Should Contain          ${response.json()["message"]}    ${palavra}