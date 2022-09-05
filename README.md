[![Badge ServeRest](https://img.shields.io/badge/API-ServeRest-green)](https://github.com/ServeRest/ServeRest/) [![Issues][issues-shield]][issues-url]

<img align="right" alt="logo-compass" height="45" style="border-radius:50px;" src="https://i.ibb.co/88f4VpL/cones.png"> 

# Projeto Final - Testando a API ServeRest com Robot 

Projeto para automação de testes da API ServeRest utilizando o Robot Framework, realizado durante as Sprints 5 e 6 do Programa de Bolsas RoboTron da Compass UOL.

## Tópicos
   * [Instalando o projeto](#instalando-o-projeto)
      * [Pré-requisitos](#pré-requisitos)
      * [Preparando o ambiente e clonando o repositório](#preparando-o-ambiente-e-clonando-o-repositório)
   * [Executando os testes](#executando-os-testes)
      * [Resultados](#resultados)
   * [Sobre o projeto](#sobre-o-projeto)
      * [Diretório](#diretório)
      * [Bugs e sugestões de melhoria](#bugs-e-sugestões-de-melhoria)
      * [Libraries utilizadas](#libraries-utilizadas)
      * [Extensões VS Code utilizadas](#extensões-vs-code-utilizadas)
   * [Referências](#referências)
   * [Autora](#autora)

## Instalando o projeto 
### Pré-requisitos 
- <a href="https://www.python.org/downloads/">Python 3</a>: é a linguagem base do Robot Framework
- <a href="https://robotframework.org/">Robot Framework</a>: para fazer a automação de testes através das libraries
- <a href="https://git-scm.com/downloads">Git</a>: para clonar o projeto para a sua máquina
- <a href="https://nodejs.org/en/">Node.js</a>: para rodar os testes localmente
- <a href="https://code.visualstudio.com/">Visual Studio Code</a>: para rodar o projeto na sua máquina

### Preparando o ambiente e clonando o repositório

1. Instale o Robot Framework via terminal: `pip install robotframework`
2. Instale a RequestsLibrary: `pip install robotframework-requests`
3. Instale a Robot Framework Faker: `pip install robotframework-faker`
4. Clone este repositório no local que você deseja: 
`git clone https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final.git`

## Executando os testes
1. Rode a ServeRest localmente pelo terminal:  ```npx serverest ```
> Não feche este terminal enquanto estiver realizando os testes!

2. Abra o projeto através do VS Code. Os arquivos com os cenários de teste estarão na pasta tests.

3. Abra um terminal dentro da pasta do projeto e execute os testes localmente de acordo com as opções abaixo:
- Todos os endpoints: ```robot -d ./reports ./tests```
- Endpoint /login: ``` robot -d ./reports ./tests/login_tests.robot ```
- Endpoint /usuarios: ``` robot -d ./reports ./tests/usuarios_tests.robot ```
- Endpoint /produtos: ``` robot -d ./reports ./tests/produtos_tests.robot ```
- Endpoint /carrinhos: ``` robot -d ./reports ./tests/carrinho_tests.robot ```
- Utilizando a TAG de cada cenário, por exemplo: ``` robot -d ./reports -i GETALLUSERS ./tests/usuarios_tests.robot ```

### Resultados

Ao executar os testes, o resultado é apresentado no terminal e os arquivos report.html e log.html são gerados:

![image](https://user-images.githubusercontent.com/100487940/188459886-25f55d58-31c8-4ddc-924d-05c58b0b03b6.png)

O <a href="https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final/blob/main/imagens/report.png">report.html</a> é um resumo que mostra o status da execução, horário de início e de término, tempo total da execução e a quantidade de testes que passou e que falhou. Já o <a href="https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final/blob/main/imagens/log.png">log.html</a> detalha os testes, mostrando cada keyword utilizada, a library da keyword, logs solicitados e resultado da execução.


## Sobre o projeto 

### Diretório
- :file_folder: [keywords/](keywords): Dir com as keywords utilizadas nos testes 
- :file_folder: [reports/](reports): Dir com os relatórios de resultados dos testes realizados, incluindo o report.html e o log.html
- :file_folder: [support/](support): Dir com os arquivos base, massas de dados e variáveis
  - :file_folder: [commom/](commom): Dir com o arquivo commom.robot, a library em Python e o arquivo .robot que consome essa library
  - :file_folder: [fixtures/](fixtures): Dir com todas as massas de dados
    - :file_folder: [static/](static): Dir com as massas de dados estáticas
  - :file_folder: [variables/](variables): Dir com o arquivo .robot que contém as variáveis utilizadas
- :file_folder: [tests/](tests): Dir com os arquivos de teste .robot para cada endpoint da API
- :page_with_curl: [funcoes-python-explicadas](funcoes-python-explicadas): Arquivo explicando o código e os objetivos das funções utilizadas na library criada com Python 
- :page_with_curl: [mapa-mental/](mapa-mental): Arquivo com o mapa mental de todas as rotas da API

### Mapa mental
Clique <a href="https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final/blob/main/mapa-mental-serverest.xmind">AQUI</a> para acessar o arquivo .xmind.

![Mapa Mental - ServeRest](https://user-images.githubusercontent.com/100487940/188462292-8a30d620-85dd-4334-bedc-ef9b0d08a69b.png)



### Bugs e sugestões de melhoria
  Os bugs da ServeRest são, em sua maioria, documentais. Já as melhorias sugeridas têm como objetivo aperfeiçoar a experiência do usuário e aproximar mais as regras da aplicação a um cenário de venda real. Acesse as <a href="https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final/issues">Issues</a> para conferir os bugs e as sugestões de melhorias em detalhes.

### Libraries utilizadas
- <a href="https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#library-documentation-top">BuiltIn</a>: library padrão do Robot que possui as palavras-chave mais utilizadas
- <a href="https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#library-documentation-top">RequestsLibrary</a>: utilizada para fazer as requisições HTTP REST
- <a href="https://pypi.org/project/robotframework-faker/">Robot Framework Faker</a>: para fazer um fake das massas de dados dentro dos testes
- <a href="https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html">Operating System</a>: para ler os arquivos JSON

### Extensões VS Code utilizadas
- <a href="https://marketplace.visualstudio.com/items?itemName=ms-python.python">Python</a>
- <a href="https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode">Robot Code</a>
- <a href="https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode">Tabnine AI Autocomplete</a>

## Referências
- <a href="https://serverest.dev/#/">Documentação da API ServeRest</a>
- <a href="https://robotizandotestes.blogspot.com/2017/09/season-running-ep-01-log-e-report-de.html">Mayara Fernandes - Conteúdo sobre Log e Report de execução</a>
- <a href="https://github.com/PauloGoncalvesBH/sample-supertest">Repositório Supertest - Inspiração de ReadMe</a>
- Vídeos da trilha de aprendizado da Compass UOL

Um agradecimento especial aos evangelistas da Compass UOL e aos meus colegas de equipe pelo suporte: <a href="https://github.com/lauraghrk">Laura</a>, <a href="https://github.com/OliveiraMariC">Mari</a>, <a href="https://github.com/phconte">Paulo</a> e <a href="https://github.com/PFrek">Pedro</a> &#129505;


## Autora
<a href="https://www.linkedin.com/in/manoellasouza/">Manoella Souza</a>

## Bastidores 

<img align="left" alt="cat-pc" height="150" style="border-radius:70px;" src="https://thumbs.gfycat.com/RegularScentedKoala-max-1mb.gif">  


<!-- MARKDOWN LINKS & IMAGES -->
[issues-shield]: https://img.shields.io/github/issues/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final?style=flat
[issues-url]: https://github.com/manoellasouza/RoboTron_Manoella_Souza_Projeto_Final/issues








