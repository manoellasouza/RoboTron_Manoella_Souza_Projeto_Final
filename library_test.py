import requests as req

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