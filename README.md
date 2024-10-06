# LINUXtips-Giropops-Senhas

### **DESAFIO PICK 2024.2**

Este desafio consiste em:

1. Criar uma conta no Docker Hub, caso ainda não possua.
2. Criar uma conta no Github, caso ainda não possua.
3. Criar um Dockerfile para criar uma imagem de container para nossa App.
	- O nome da imagem deve ser: SEU_USUARIO_NO_DOCKER_HUB/linuxtips-giropops-senhas:1.0.
4. Fazer o push da imagem para o Docker Hub, essa imagem deve ser pública.
5. Criar um repo no Github chamado Linuxtips-Giropops-Senhas, esse repo deve ser público.
6. Fazer push do código da App e o Dockerfile.
7. Criar um container utilizando a imagem criada.
	 -  O nome do container deve ser giropops-senhas.
	 - Você precisa deixar o container rodando.
8. O Redis precisa ser um container.

Dica: Preste atenção no uso da variável de ambiente, precisamos ter a variável **REDIS_HOST** no container. 

**Use sua criatividade!**

## Resolução

1. Criando uma conta no [Docker Hub](https://hub.docker.com/signup);
 
2. Criando uma conta no [Github](https://github.com/signup?ref_cta=Sign%20up&ref_loc=header%20logged%20out&ref_page=/&source=header-home);

3. Criando um Dockerfile:
	 - Dê um `git clone https://github.com/badtuxx/giropops-senhas`, para baixar a App para seu workspace;
	 - Tenha um editor de texto no seu terminal, no meu caso utilizei o [LunarVim](https://www.lunarvim.org/), mas fica a seu critério qual utilizar;
	 - Crie um arquivo com o nome Dockerfile;
	 - Insira as seguintes instruções: 
		 > FROM python:3-slim
		 >
         > WORKDIR /app 
		 > 
		 > COPY ./giropops-senhas /app
		 > 
		 >RUN pip install --no-cache-dir -r requirements.txt
		 >
		 >EXPOSE 5000
		 >
		 >CMD ["flask", "run", "--host=0.0.0.0"]
		 
		###### Caso queira saber o que cada comando faz. Recomendo o artigo: [Docker: Desvendando o DockerFile](https://www.alura.com.br/artigos/desvendando-o-dockerfile)

	- Crie a imagem a partir do Dockerfile:
	```
    docker build -t SEU_USUARIO_NO_DOCKER_HUB/linuxtips-giropops-senhas:1.0 .
    ```
	
4. Faça o push da imagem para o Docker Hub:
    ```
    docker push SEU_USUARIO_NO_DOCKER_HUB/linuxtips-giropops-senhas:1.0
    ```
    ###### Obs: É necessário logar na sua conta do Docker Hub para fazer o push.		

5. Crie um repositório no [Github](https://docs.github.com/pt/repositories/creating-and-managing-repositories/creating-a-new-repository) com o nome LINUXtips-Giropops-Senhas;

6. Faça um push do Dockerfile e App para o Github:
	- No Workspace onde encontra-se o Dockerfile e o diretório da App dê os seguintes comandos:
	```
    git init

    git remote add origin git@github.com:SEU_USUARIO_GITHUB/LINUXtips-Giropops-Senhas.git

	git add . 

    git commit -m "Dockerfile e App"
    
    git push -u origin main
    ```
	###### Obs: É necessário logar no github utilizando uma chave SSH.
7. Crie um container utilizando a imagem criada && Utilize o Redis como container.
	- Crie uma network para a comunicação entre o container da App e o container do Redis
	```
    docker network create -d bridge net-giropops-senhas
    ```
	- Crie um container utilizando a network que acabamos de criar e utilize a imagem do Redis
	```
    docker container run -d -p 6379:6379 --network netgiropops --name redis redis
    ```
	- Crie um container utilizando a imagem SEU_USUARIO_NO_DOCKER_HUB/linuxtips-giropops-senhas:1.0
    ```
    docker container run -d -p 5000:5000 --network netgiropops --env REDIS_HOST=redis --name giropops-senhasSEU_USUARIO_NO_DOCKER_HUB/linuxtips-giropops-senhas:1.0
    ```
	- Por fim acesse o seu navegador utilizando a url: **localhost:5000**

