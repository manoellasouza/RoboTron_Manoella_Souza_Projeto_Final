import requests as req
import json

def Get_Endpoint_Usuarios_Tantas_Vezes(vezes):
    lista=[]
    for vez in range (0,vezes):
        #requisição vai receber a função GET da library requests, no endpoint /usuarios 
        r =  req.get("http://localhost:3000/usuarios")
        #transformar cada requisição em um json
        para_json = r.json()
        #adicionar o json na lista
        lista.append(para_json)
    return lista


def Pegar_Quantidade_Usuarios_Cadastrados():
    r =  req.get("http://localhost:3000/usuarios")
    para_json = r.json()
    return para_json["quantidade"]


def Validar_Quantidade_Produtos_Cadastrados(dado):
    r =  req.get("http://localhost:3000/produtos")
    para_json = r.json()
    return para_json["quantidade"]


def Get_Endpoint_Dado_Usuarios(dado):
    r =  req.get("http://localhost:3000/usuarios")
    mensagem = ""
    para_json = r.json()
    users = para_json['usuarios']
    for i in users:
        if (i.get('nome') == dado):
            mensagem = ("O nome " + dado + " está cadastrado no ID " + (i['_id'])) 
        if (i.get('email') == dado):
            mensagem = ("O email " + dado + " está cadastrado no ID " + (i['_id'])) 
        if (i.get('_id') == dado):
            mensagem = ("O ID " + (i['_id']) + " está cadastrado na base de dados") 
    if mensagem == "":
        mensagem = ("O dado " + dado + " não consta na lista de cadastros")
    return mensagem


def Get_Endpoint_Dado_Produtos(dado):
    r =  req.get("http://localhost:3000/produtos")
    lista = []
    para_json = r.json()
    products = para_json['produtos']
    for i in products:
        if (i.get('nome') == dado):
            lista.append(i)
        if (i.get('descricao') == dado):
            lista.append(i) 
    return lista


# def Get_Endpoint_Estoque(dado):
#     r =  req.get("http://localhost:3000/produtos")


#     r =  req.get("http://localhost:3000/produtos")
#     para_json = r.json()
#     users = para_json['usuarios']





# def Get_Endpoint_Dado_Carrinho(dado):
#     r =  req.get("http://localhost:3000/carrinhos")
#     lista = []
#     para_json = r.json()
#     cars = para_json['carrinhos']
#     listaproducts = (cars[1])
#     products = (listaproducts['produtos'])
#     id_carrinho = (listaproducts['_id'])
#     for i in products:
#         if (i.get('idProduto') == dado):
#                 mensagem = (i['carrinhos'][1]['_id']) 
#                 lista.append(mensagem)
                # for x in :
                #     # id = (x['_id'])
                #     lista.append(x)
    
        #         lista.append("O produto " + dado + " está cadastrado no carrinho com ID " ) 
                # if (i.get('precoUnitario') == dado):
                #     lista.append(("O valor unitário " + dado + " está cadastrado no carrinho com ID " + (i['_id'])) ) 
    # return lista
    # return lista



def Get_Endpoint_Usuarios_Administradores():
    r =  req.get("http://localhost:3000/usuarios?administrador=true")   #Envia parâmetro via query
    para_json = r.json()
    return para_json


def Selecionar_Usuario_Login(user):
    with open ("support/fixtures/static/json_login_ex.json", encoding="utf-8") as json_normal:
        json_manipulavel = json.load(json_normal)
        usuario=json_manipulavel[user]
        return usuario








# def Get_Endpoint_Qtd_Produto_Especifico(produto):
#     lista=[]
#     r =  req.get("http://localhost:3000/produtos")
#     para_json = r.json()
#     users = para_json['produtos']
#     for i in users:
#         if i.get('descricao') == produto:
#             lista.append(i)
#     return lista

# def Get_Endpoint_Usuarios_Administradores():
#     lista=[]
#     r =  req.get("http://localhost:3000/usuarios")
#     para_json = r.json()
#     users = para_json['usuarios']
#     for i in users:
#         if i.get('administrador') == "true":
#             lista.append(i)
#     return lista

#https://stackoverflow.com/questions/46139277/use-if-statement-to-search-json-file?newreg=b4d04b32c4d14ccaa2025d4c94259a36