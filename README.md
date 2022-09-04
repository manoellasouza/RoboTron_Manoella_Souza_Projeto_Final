[![Badge ServeRest](https://img.shields.io/badge/API-ServeRest-green)](https://github.com/ServeRest/ServeRest/)

<img align="right" alt="logo-compass" height="30" style="border-radius:50px;" src="https://i.ibb.co/qCC4kKF/logo-compass2.png"> 


# Projeto Final - Testando a API ServeRest com Robot 

### Tópicos
   * [Sobre o projeto](#sobre-o-projeto)
   * [Pré-requisitos](#pré-requisitos)
   * [Rodando o projeto](#rodando-o-projeto)
   * [Libraries utilizadas](#libraries-utilizadas)
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

 ## Rodando o projeto

**1** - Instale o Robot Framework na sua máquina através do CMD
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


**5** - Rode a ServeRest localmente no CMD (não feche o CMD enquanto estiver realizando os testes!)
```sh 
npx serverest
```

**6** - Abra o VS Code e o CMD dentro da pasta e digite o comando no CMD para rodar todos os testes
```sh 
robot -d ./reports ./tests
```

## Referências
- <a href="https://serverest.dev/#/">Documentação da API ServeRest</a>
- Vídeos da trilha de aprendizado da Compass UOL
- Um agradecidmento especial aos evangelistas da Compass UOL e aos meus colegas de equipe pelo suporte: <a href="https://github.com/OliveiraMariC">Mari</a>, <a href="https://github.com/lauraghrk">Laura</a>, <a href="https://github.com/phconte">Paulo</a> e <a href="https://github.com/PFrek">Pedro</a> &#128155;

## Autora
<a href="https://www.linkedin.com/in/manoellasouza/">Manoella Souza</a>

## Licença
<a href="https://github.com/manoellasouza/RoboTron_-Manoella_Souza-_Compass/blob/main/LICENSE">MIT License</a>

## Bastidores 

<img align="left" alt="cat-pc" height="150" style="border-radius:70px;" src="https://s4.gifyu.com/images/video-3.gif">  











