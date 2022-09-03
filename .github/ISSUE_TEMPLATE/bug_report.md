---
name: Cadastro de usuários é realizado com nome e password em branco
about: Create a report to help us improve
title: "[BUG]"
labels: bug
assignees: ''

---

**Descrição**

Em POST /usuarios, ao preencher os campos nome e password com uma string vazia, o cadastro é realizado normalmente. Este bug ocorre online ou de forma local. 

**Como reproduzir**

Via browser:
1. Acesse a API ServeRest online (https://serverest.dev/) ou localmente (http://localhost:3000/);
2. Em POST /usuários clique em Try it out;
3. Deixe apenas um espaço em branco como valor em “nome” e em “password”;
4. Altere o e-mail para que não retorne uma mensagem dizendo que o e-mail do exemplo já está sendo usado;
5. Clique em Execute e o cadastro será realizado com sucesso.

Via VS Code e CMD:
1. Após seguir todos os passos do ReadMe para rodar este projeto, abra o VS Code;
2. Na pasta tests, abra o arquivo usuários_tests.robot;
3. No Cenário 02, substitua “user_valido” por “user_nome_espaco” e salve;
4. Abra o CMD na pasta do projeto e digite robot -d ./reports -i POSTUSERESTATICO ./tests/usuarios_tests.robot;
5. O cadastro será realizado com sucesso.

O usuário “user_nome_espaco” pertence ao arquivo json_usuario_ex.json que se encontra em support > fixtures > static.

**Expected behavior**

A clear and concise description of what you expected to happen.

**Screenshots**

Via browser:

![image](https://user-images.githubusercontent.com/100487940/188249976-1b99ac7d-916f-48ae-9ccc-c10df61804d4.png)
![image](https://user-images.githubusercontent.com/100487940/188249992-92aeafbd-e2c3-4711-b647-2ac3a4ab9bdf.png)


Via CMD:

![image](https://user-images.githubusercontent.com/100487940/188249937-91a271c1-60d5-4adb-b9b5-0b2eaadd20e6.png)



**Desktop (please complete the following information):**
 - OS: [e.g. iOS]
 - Browser [e.g. chrome, safari]
 - Version [e.g. 22]

**Smartphone (please complete the following information):**
 - Device: [e.g. iPhone6]
 - OS: [e.g. iOS8.1]
 - Browser [e.g. stock browser, safari]
 - Version [e.g. 22]

**Additional context**
Add any other context about the problem here.

