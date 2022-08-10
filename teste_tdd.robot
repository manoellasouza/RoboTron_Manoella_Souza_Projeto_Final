*** Test Cases ***
Cenário: GET Todos os Usuarios 200
    GET Endpoint /usuarios
    Validar Todos os Usuarios na Response
    Validar Status Code "200"

Cenário: GET Usuarios Especificos 200
    GET Endpoint /usuarios com id "/0uxuPY0cbmQhpEz1"
    Validar o Usuario com id "/0uxuPY0cbmQhpEz1"
    Validar Status Code "200"
    Validar Mensagem "Nome = Fulano da Silva"

Cenário: POST Criar Novo Usuario 201
    Criar Usuario Dinâmico
    POST Usuario Dinâmico no Endpoint /usuarios
    Validar Status Code "201"
    Validar Mensagem "Cadastro realizado com sucesso"

Cenário: PUT Editar Usuário Existente 200
    PUT Editar Usuário com id "/0uxuPY0cbmQhpEz1" usando os Dados Dinâmicos
    Validar Status Code "200"
    Validar Mensagem "Registro alterado com sucesso"

Cenário: DELETE Usuário Existente 200
     DELETE Usuario Específico com id "/0uxuPY0cbmQhpEz1"
     Validar Status Code "200"
     Validar Mensagem "Registro excluído com sucesso | Nenhum registro excluído"

