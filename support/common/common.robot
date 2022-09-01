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

Validar Mensagem "${message}"
    Should Be Equal            ${response.json()["message"]}    ${message}

Validar Quantidade Total "${quantidade}"
    Should Be Equal        ${response.json()["quantidade"]}    ${quantidade}
    Log To Console         Quantidade Total: ${response.json()["quantidade"]}

Selecionar Token Invalido
    ${token_auth}             Set Variable        12563737   
    Set Global Variable       ${token_auth}

Validar Se Response Contem "${palavra}"
    Should Contain          ${response.json()["message"]}    ${palavra}

Validar Erro "${nome_erro}"   
    IF         "${nome_erro}" == "nome" or "${nome_erro}" == "password" or "${nome_erro}" == "descricao"    
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} não pode ficar em branco 
    ELSE IF    "${nome_erro}" == "email" 
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um email válido 
    ELSE IF    "${nome_erro}" == "administrador"  
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser 'true' ou 'false' 
    ELSE IF    "${nome_erro}" == "preco" or "${nome_erro}" == "quantidade"   
        Should Be Equal                    ${response.json()["${nome_erro}"]}    ${nome_erro} deve ser um número 
    END
