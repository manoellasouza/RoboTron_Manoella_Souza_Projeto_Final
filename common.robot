*** Settings ***
Documentation        Keywords e Variaveis para Ações Gerais
Library              OperatingSystem  

*** Variables ***
${email_para_login}    charlie.s@gmail.com    
${password_para_login}    12345

*** Keywords ***

Validar Status Code "${statuscode}"
    Should Be True    ${response.status_code} == ${statuscode} 

Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}