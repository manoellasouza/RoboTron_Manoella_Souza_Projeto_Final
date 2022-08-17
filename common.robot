*** Settings ***
Documentation        Keywords e Variaveis para Ações Gerais
Library              OperatingSystem  


*** Keywords ***

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode} 

Printar Conteudo Response 
    Log To Console            Response: ${response.json()} 

Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}

Validar Mensagem Rota Exclusiva Admin
    Should Be Equal            ${response.json()["message"]}    Rota exclusiva para administradores

Validar Mensagem E-mail Invalido
    Should Be Equal            ${response.json()["message"]}    Este email já está sendo usado

Validar Mensagem Token Invalido
    Should Be Equal            ${response.json()["message"]}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais
