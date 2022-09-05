*** Settings ***
Documentation        Arquivo de testes para Library Python
Library              library_test.py

*** Keywords ***
Validar Quantidade Usuários Administradores
    ${users}                        Get Endpoint Usuarios Administradores
    ${qnt}=                         Get length                                    ${users}
    Should Be Equal As Numbers      ${qnt}                                            2
    Log To Console                  Quantidade de usuários adm: ${qnt}

Validar Se Dado Cadastro Existe "${dado}"
    ${users}                        Get Endpoint Dado Usuarios                    ${dado}      
    Log To Console                  ${users}
    
Validar Nome Ou Descrição Produto "${dado}"
    ${produtos}                     Get Endpoint Dado Produtos                    ${dado} 
    Log To Console                  ${produtos}  

Validar Estoque de Produtos "${payload}"
    ${produtos}                     Get Endpoint Estoque Produtos                 ${payload} 
    Log To Console                  Estoque:                                                  
    Log To Console                  ${produtos}  

