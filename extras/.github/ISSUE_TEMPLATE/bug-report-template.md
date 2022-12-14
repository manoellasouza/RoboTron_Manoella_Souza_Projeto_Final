---
name: Bug report template
about: Create a report to help us improve
title: ''
labels: bug
assignees: ''

---

**Descrição**

Ao fazer um POST no endpoint /usuarios com os campos "nome" e "password" contendo apenas um espaço dentro da string (" "), o cadastro é realizado normalmente. Este bug ocorre online ou de forma local. 

**Como reproduzir**

Via browser:
1. Acesse a API ServeRest online (https://serverest.dev/) ou localmente (http://localhost:3000/);
2. Em POST /usuários clique em Try it out;
3. Deixe apenas um espaço em branco como valor em “nome” e em “password”;
4. Altere o e-mail para que a requisição não retorne uma mensagem afirmando que o e-mail do exemplo já está sendo usado;
5. Clique em Execute e o cadastro será realizado com sucesso.

Via VS Code e CMD:
1. Após seguir todos os passos do ReadMe para rodar este projeto, abra o VS Code;
2. Na pasta tests, abra o arquivo usuários_tests.robot;
3. No Cenário 02, substitua “user_valido” por “user_nome_espaco” e salve;
4. Abra o CMD na pasta do projeto e digite robot -d ./reports -i POSTUSERESTATICO ./tests/usuarios_tests.robot;
5. O cadastro será realizado com sucesso.

O usuário “user_nome_espaco” pertence ao arquivo json_usuario_ex.json que se encontra em support > fixtures > static.

**Resultado esperado**

Este cenário não está na documentação da API, mas espera-se que retorne o erro 400 e uma mensagem informando que estes dados não podem ficar em branco. Isto já ocorre quando nome ou password são enviados com um valor vazio ("").


**Screenshots**

Via browser:

![image](https://user-images.githubusercontent.com/100487940/188249976-1b99ac7d-916f-48ae-9ccc-c10df61804d4.png)
![image](https://user-images.githubusercontent.com/100487940/188249992-92aeafbd-e2c3-4711-b647-2ac3a4ab9bdf.png)


Via CMD:

![image](https://user-images.githubusercontent.com/100487940/188249937-91a271c1-60d5-4adb-b9b5-0b2eaadd20e6.png)

**Informações adicionais**

Foram utilizados os navegadores Microsoft Edge (versão 104.0.1293.70) e Google Chrome (versão 105.0.5195.52) para fazer o teste via browser, além do VS Code na versão 1.7.1.0.
