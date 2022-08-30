from operator import length_hint
from smtplib import quotedata
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