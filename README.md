[![Badge ServeRest](https://img.shields.io/badge/API-ServeRest-green)](https://github.com/ServeRest/ServeRest/)

<img align="right" alt="logo-compass" height="65" style="border-radius:50px;" src="https://i.ibb.co/88f4VpL/cones.png"> 


# Projeto Final - Testando a API ServeRest com Robot 

### Tópicos
   * [Sobre o projeto](#sobre-o-projeto)
   * [Pré-requisitos](#pré-requisitos)
   * [Libraries utilizadas](#libraries-utilizadas)
   * [Extensões VS Code recomendadas](#extensões-vs-code-recomendadas)
   * [Preparando o ambiente e clonando o repositório](#preparando-o-ambiente-e-clonando-o-repositório)
   * [Rodando o projeto](#rodando-o-projeto)
   * [Referências](#referências)
   * [Autora](#autora)
   * [Licença](#licença)
   * [Bastidores](#bastidores)


## Sobre o projeto 
Projeto para automação de testes da API ServeRest utilizando o Robot Framework, realizado durante as Sprints 5 e 6 do Programa de Bolsas RoboTron da Compass UOL.

Além do conteúdo estudado nas sprints passadas, este projeto também tem como objetivo reforçar os seguintes conhecimentos:
- Padrão Service-Objects
- Escrita de cenários de teste em TDD
- Utilização e criação de libraries 
- Lidar com requests e responses
- Autenticação de APIs
- Manipular dados estáticos e dinâmicos
- Reutilização de código

## Pré-requisitos 
- <a href="https://www.python.org/downloads/">Python 3</a>: é a linguagem base do Robot Framework
- <a href="https://robotframework.org/">Robot Framework</a>: para fazer a automação de testes através das libraries
- <a href="https://git-scm.com/downloads">Git</a>: para clonar o projeto para a sua máquina
- <a href="https://nodejs.org/en/">Node.js</a>: para rodar os testes localmente
- <a href="https://code.visualstudio.com/">Visual Studio Code</a>: para rodar o projeto na sua máquina

## Libraries utilizadas
- <a href="https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#library-documentation-top">BuiltIn</a>: library padrão do Robot que possui as palavras-chave mais utilizadas
- <a href="https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#library-documentation-top">RequestsLibrary</a>: utilizada para fazer as requisições HTTP REST
- <a href="https://pypi.org/project/robotframework-faker/">Robot Framework Faker</a>: para fazer um fake das massas de dados dentro dos testes
- <a href="https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html">Operating System</a>: para ler os arquivos JSON

## Extensões VS Code recomendadas
- <a href="https://marketplace.visualstudio.com/items?itemName=ms-python.python">Python</a>
- <a href="https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode">Robot Code</a>
- <a href="https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode">Tabnine AI Autocomplete</a>

 ## Preparando o ambiente e clonando o repositório

**1** - Instale o Robot Framework na sua máquina através do terminal
```sh 
pip install robotframework 
```

**2** - Verifique se a instalação foi bem sucedida
```sh 
robot --version
```

**3** - Instale a RequestsLibrary e a Robot Framework Faker
```sh 
pip install robotframework-requests
pip install robotframework-faker
```

**4** - Crie uma pasta na sua máquina, abra o Git Bash dentro dela e clone este repositório
```sh 
git clone https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final.git . 
```

## Rodando o projeto
Rode a ServeRest localmente pelo terminal
> Não feche este terminal enquanto estiver realizando os testes!
```sh 
npx serverest
```

Abra um terminal dentro da pasta do projeto e execute os testes localmente de acordo com as opções abaixo:
- Todos os testes
```sh 
robot -d ./reports ./tests
```

- Apenas os testes do endpoint /login
```sh 
robot -d ./reports ./tests/login_tests.robot
```

- Apenas os testes do endpoint /usuarios
```sh 
robot -d ./reports ./tests/usuarios_tests.robot
```

- Apenas os testes do endpoint /produtos
```sh 
robot -d ./reports ./tests/produtos_tests.robot
```

- Apenas os testes do endpoint /carrinhos
```sh 
robot -d ./reports ./tests/carrinho_tests.robot
```

## Referências
- <a href="https://serverest.dev/#/">Documentação da API ServeRest</a>
- Vídeos da trilha de aprendizado da Compass UOL
- Um agradecidmento especial aos evangelistas da Compass UOL e aos meus colegas de equipe pelo suporte: <a href="https://github.com/OliveiraMariC">Mari</a>, <a href="https://github.com/lauraghrk">Laura</a>, <a href="https://github.com/phconte">Paulo</a> e <a href="https://github.com/PFrek">Pedro</a> &#129505;

## Autora
<a href="https://www.linkedin.com/in/manoellasouza/">Manoella Souza</a>

## Bastidores 

<img align="left" alt="cat-pc" height="150" style="border-radius:70px;" src="https://s4.gifyu.com/images/video-3.gif">  











