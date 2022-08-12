*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Login

*** Variables ***
${email_para_login}    testesUser@qa.com.br    
${password_para_login}    contaDeTeste3221

*** Keywords ***
POST Endpoint /login
    &{payload}                Create Dictionary      email=${email_para_login}    password=${password_para_login}                     
    ${response}               POST On Session        serverest        /login    data=&{payload}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
