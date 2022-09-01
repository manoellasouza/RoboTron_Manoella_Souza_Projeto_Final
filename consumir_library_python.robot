*** Settings ***
Documentation        Arquivo de testes para Library Python
Resource             ./support/base.robot
Library              library_test.py

# *** Test Cases ***
# Teste Library 1
# # Chamar a função da library com espaços e o parâmetro desejado, que nesse caso precisa ser um número inteiro:
#     ${json}            Get Endpoint Usuarios Tantas Vezes    ${1} 
#     Log To Console     ${json}       

# Teste Library 2
#     ${users}            Pegar Quantidade Usuarios Cadastrados
#     Log To Console      ${users}


*** Keywords ***

Validar Quantidade Usuários Administradores
    ${users}                        Get Endpoint Usuarios Administradores
    ${qnt}=                         Get length                                    ${users}
    Should Be Equal As Numbers      ${qnt}                                            2
    Log To Console                  Quantidade de usuários adm: ${qnt}

Validar Se Dado Cadastro Existe "${dado}"
    ${users}                        Get Endpoint Dado Usuarios                     ${dado}      
    Log To Console                  ${users}

Validar Nome Ou Descrição Produto "${dado}"
    ${produtos}                     Get Endpoint Dado Produtos                      ${dado} 
    ${qnt}=                         Get length                                    ${produtos}     
    # Log To Console                  ${produtos}
     IF    "${qnt}" == "0"   
        Log To Console              ${dado} não consta na lista de cadastros
    ELSE 
        Log To Console              ${dado} está cadastrado e aparece ${qnt} vez(es) na lista
    END
    

# Validar Quantidade de Produtos "${dado}"
#     ${produtos}                               Validar Quantidade Produtos Cadastrados        ${dado}      
#     Log To Console                         ${produtos}


# Validar Quantidade de Produtos "${produto}"
#     ${users}                               Get Endpoint Qtd Produto Especifico    ${produto}    
#     Log To Console                         ${users}
#     ${qnt}=                                Get length                @{users}
#     Should Be Equal As Numbers             ${qnt}                        2
#     Log To Console                         Quantidade de ${produto}: ${qnt}

