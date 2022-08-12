*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Produtos

*** Variables ***
${token_auth}        Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3Rlc1VzZXJAcWEuY29tLmJyIiwicGFzc3dvcmQiOiJjb250YURlVGVzdGUzMjIxIiwiaWF0IjoxNjYwMzI3NjA0LCJleHAiOjE2NjAzMjgyMDR9.uNIV4Bv_pcc7oYlA2cWx4JaeWbnD2KL0XinN30Ti6-k

*** Keywords ***
GET Endpoint /produtos
    ${response}               GET On Session        serverest        /produtos
    Set Global Variable       ${response}

POST Endpoint /produtos 
    &{header}                 Create Dictionary      Authorization=${token_auth}  
    &{payload}                Create Dictionary      nome=Cadeira Gamer do Paraguai    preco=5200    descricao=Cadeira    quantidade=285                        
    ${response}               POST On Session        serverest        /produtos    data=&{payload}    headers=&{header}
    Log To Console            Response: ${response.content}
    Set Global Variable       ${response}
