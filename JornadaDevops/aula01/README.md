# Dockerizando uma aplicação

**Repositório**:https://github.com/robertsilvatech/jornada-devops01.git


## Docker como técnologia
Docker é uma técnologia, não exclusivo sobre containers, a história de containers linux começa a muito tempo atrás, antes mesmo de criarem o docker.

Docker foi ganhando popularidade por conta de ser facil trabalhar com containers.


## Oque é docker ?

Técnologia para enpacotar e executar aplicações isoladamente(container).


## Oque são as imagens ?

Resposta: Aplicação que queremos executar.
Um modelo somente leitura com instruções de criação de um container.

Curiosidade: Toda imagem possui como base uma outra imagem nela aplicamos as customizações necessarias para nossa aplicação.

### Parte pratica das imagens:
A ideia é que uma imagem tenha o menor tamanho possível;
Uma imagem pode ser utilizada por vários containers;
Imagens são construídas através de um arquivo chamado Dockerfile; 
**Em uma imagem temos tudo que precisamos para aplicação inicia**:
 - Bibliotecas do S.O
 - Código Fonte
 - Dependências
 - Configurações do ambiente
 - Scripts de iniciação



 # Objetivo
 - Este ambiente não é exclusivamente para desenvolvimento
 - Também serve para o time de devops valide o funcionamento completo da aplicação
 - Testar deploy usando Docker e Kubernets



 ### Exmeplo de Dockerfile

 ```dockerfile
    FROM python:3.7-slim

    RUN apt-get update -y && \
        apt-get install -y inputils-ping curl telnet wget traceroute && \
        apt-get clean -y

    COPY manage.py /app/
    COPY ./demo_django /app/demo_django
    COPY docker-entry-point.sh /app/

    EXPOSE 8000

    WORKDIR /app

    CMD python3 manage.py runserver 0.0.0.0:8000
 ```


 ### Cada detalhe do Dockerfile

- **FROM**: Define a imagem base que será utilizada.
- **ARG**: Similar a uma variável de ambiente, entretanto será utilizado somente durante o build.
- **LABELS**: Define metadados com informações referente a image: Versão, mantenedor, descrição e outros.
- **RUN**:  Executa um commando, como se fosse em um terminal.
- **ENV**:  Define uma variável de ambiente, será utilizada no build e também durante a execução do container.
- **COPY**: Copia arquivos ou diretórios para dentro da imagem
- **EXPOSE**: Informa a(s) porta(s) que o container vai escutar. Por padrão c protocol é TCP, porém Podemos definir também UDP.
- **:VOLUME**: Cria um ponto de montage no container, toda vez que um cor for criado um volume será criado também pelo Docker Engine
- **ENTRYPOINT**: Executa um commando na inicialização do container, este éo processo principal do container, se o processo falhar o contain morrer.
- **CMD**: Executa um commando na inicialização, se o ENTRYPOINT est definido, o CMD será parâmetros para o ENTRYPOINT