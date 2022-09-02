import requests as req

def Get_Endpoint_Dado_Usuarios(dado):
    r =  req.get("http://localhost:3000/usuarios")
    mensagem = " "
    lista1, lista2, lista3 = [], [], []
    para_json = r.json()
    users = para_json['usuarios']
    for i in users:
        if (i.get('nome') == dado):
            lista1.append(i['_id'])
        elif (i.get('email') == dado):
            lista2.append(i['_id'])
        elif (i.get('_id') == dado):
            lista3.append(i['_id'])
    if len(lista1) != 0:
        mensagem = (f"O nome {dado} aparece {len(lista1)} vez(es) na lista de usuários e está cadastrado no(s) seguinte(s) IDs: {lista1}")
    elif len(lista2) != 0:
        mensagem = (f"O email {dado} aparece {len(lista2)} vez(es) na lista de usuários e está cadastrada no(s) seguinte(s) IDs: {lista2}")
    elif len(lista3) != 0:
        mensagem = (f"O ID {dado} aparece {len(lista3)} vez(es) na lista de usuários.")
    else: 
        mensagem = (f"{dado} não consta na lista de cadastro dos usuários")
    return mensagem


def Get_Endpoint_Dado_Produtos(dado):
    r =  req.get("http://localhost:3000/produtos")
    lista1, lista2 = [], []
    mensagem = " "
    para_json = r.json()
    products = para_json['produtos']
    for i in products:
        if (i.get('nome') == dado):
            lista1.append(i['_id'])
        if (i.get('descricao') == dado):
            lista2.append(i['_id']) 
    if len(lista1) != 0:
        mensagem = (f"O nome {dado} aparece {len(lista1)} vez(es) na lista de produtos e está cadastrado no(s) seguinte(s) IDs: {lista1}")
    if len(lista2) != 0:
        mensagem = (f"A categoria {dado} aparece {len(lista2)} vez(es) na lista de produtos e está cadastrada no(s) seguinte(s) IDs: {lista2}")
    if len(lista1) == 0 and len(lista2) == 0:
        mensagem = (f"{dado} não consta na lista de cadastro dos produtos")
    return mensagem


def Get_Endpoint_Estoque_Produtos(payload):
    r =  req.get("http://localhost:3000/produtos")   
    lista = []
    para_json = r.json()
    estoque = para_json['produtos']
    carrinho = payload['produtos']
    for x in estoque:
        for i in carrinho:
            if (x['_id'] == i['idProduto']): 
                lista.append(f"{x['nome']} ({x['_id']}): {x['quantidade']}")
    return lista
    
    
def Get_Endpoint_Usuarios_Administradores():
    r =  req.get("http://localhost:3000/usuarios?administrador=true")   
    para_json = r.json()
    return para_json
    