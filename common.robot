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