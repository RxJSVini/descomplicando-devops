# Pipelines
### Referencias
https://docs.gitlab.com/ee/ci/pipelines/
<hr/>

### Sintax do yaml
https://docs.gitlab.com/ee/ci/yaml/

### Variaveis pré definidas
https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

### Dind - Docker in Docker para build de imagens
https://docs.gitlab.com/ee/ci/docker/using_docker_build.html

## Job 1 
```yaml
JobInicial:
  tags:
  - shell
  script:
  - echo "Olá Github"
   # O erro abaixo podera ocorrer caso vc não tenha nenhum runner com o nome que está em - tags
    # # This job is stuck because of one of the following problems. There are no active runners online,nos runners for the protected branch, or no runners that match all of the job's tags: shell

     # Go to project CI settings

```

## Job 2
```yaml
    SegundoJob:
    when: delayed
    start_in: 1 minute
    script: echo "Execução em 1 minuto"
```


## Job 3 - Com etapas(estágios)

```yaml
    stages:
        - e1
        - e2

    Etapa1:
        stage: e1
        when: on_success
        script:
            - echo "Primeira etapa"
    Etapa2:
        stage: e2
        when: on_failure
        script: 
            - echo "Falha na etapa 1"

```


## Timeout

```yaml
    Job4:
        timeout: 1m
        script: sleep 5s; echo "Este job tem um tempo de execução limitado a 1min"
```



## after script and before script

```yaml
    after_script:
        - echo "Antes da execução"
    before_script:
        - echo "Depois da execução"
    
```

## Scripts com mais de 1 ou 2 linhas de código

Você pode criar um shell externo, dar as permissões e executa-lo.
### collapsed multi-line command

```yaml
    job:
    script: |
        echo "olá, mundo 1"
        echo "olá, mundo 2"

```

### Outra forma de fazer

```bash
    #Criamos um script externo, chamado test.sh de exemplo
    #!/bin/bash
    echo "Olá, Mundo! Externo"
```

**Forma 1, executando arquivo externo**
```yaml
job:
    script:
        - chmod +x test.sh
        - ./test.sh

```

**Forma 2, executando com o pipe |**

```yaml
    job:
    script: |
        echo "olá, mundo 1"
        echo "olá, mundo 2"

```

## Pipeline considerando variaveis de ambiente

```yaml
    job6:
        script:
            - echo "Executando quando há uma mesclagem"
        only:
            - merge_requests
    job7:
        only:
            - tags
        script:
            - echo "Executando quando uma tag é criada"
    job8:
        only:
            variables:
                - $RELEASE == "staging"
        script:
            - echo "Executando porque declarou a variavel RELEASE com o valor staging"

```


## Parallel
Refereência: https://docs.gitlab.com/ee/ci/yaml/#parallel
<hr/>
Introduzido no GitLab 15.9, o valor máximo parallelfoi aumentado de 50 para 200.

Use parallelpara executar um trabalho várias vezes em paralelo em um único pipeline.

Devem existir vários executores ou um único executor deve ser configurado para executar vários trabalhos simultaneamente.

```yaml
   job9:
   parallel: 3
   script: echo 'sleep 5'

```

### Cache de arquivos

```yaml
    job1:
  when: manual
  script:
    - echo " Executa somente manual."

job2:
  stage: deploy
  when: delayed
  start_in: 1 minute #5 seconds, 30 minutes, 1 day, 1 week
  script: echo 'Execucao em 1 minuto...'

#####

stages:
  - e1
  - e2
  - e3

Etapa1:
  stage: e1
  when: on_success
  script:
    - iopuewqorwerecho "Etapa 1"

Etapa2:
  stage: e2
  when: on_failure
  script:
    - echo "Falha na etapa 1"

Etapa3:
  stage: e3
  when: always
  script:
    - echo "Sempre será executado"

#####

job3:
  timeout: 1m
  script:
    - sleep 20
    - echo "executa com timeout para o stage com maximo de 1 minuto"

################
before_script:
  - echo before

after_script:
  - echo after

job4:
  script:
    - echo "executando o script"
################

job11.1:
  script:
    - echo "Script com mais de uma linha."
    - |
      i=0
      while [ $i -ne 5 ]
        do
          i=$(($i+1))
          echo "$i"
      done

job5:
  script:
    - echo "Executar quando muda um arquivo."
  only:
    changes:
      - teste.txt
      - docker/scripts/*
      - "*.md"
      - scripts/*.{rb,py,sh}

#####################
job6:
  script:
    - echo "Executa quando solicita mesclagem"
  only:
    - merge_requests

job7:
  only:
    - tags
  script:
    - echo " Executa somente com tag."
  when: manual

job8:
  only:
    variables:
      - $RELEASE == "staging"
  script: echo "only variables"
#####################




job8:
  parallel: 3
  script:
    - echo "3 trabalhos trabalho paralelo"

###############
build_a:
  image: alpine
  script:
    - echo "Executando um build"
    - sleep 10
  tags:
    - docker

test_a:
  needs: [build_a]
  script:
    - docker run -dit --name teste ubuntu
  tags:
    - shell
###############

job18:
  script:
    - echo "Exemplo de cache de arquivos."
  artifacts:
    name: "artefatos-exemplo"
    when: on_success # faça upload de artefatos somente quando o trabalho for bem-sucedido
    expire_in: 1 min 5 sec # '42' ; 42 seconds ; 3 mins 4 sec ; 2 hrs 20 min ; 2h20min ; 6 mos 1 day ; 47 yrs 6 mos and 4d ; 3 weeks and 2 days ; never
    paths:
      - teste.txt

########### Aprendendo Variáveis ###########
job11:
  script:
    - echo "Mostrando variaveis do GitLab"
    - export

job12:
  stage: test
  script:
    - echo "$CI_JOB_STAGE"

#################################
variables:
  VAR1: "teste1"
  VAR2: "teste2"

job12_a:
  variables:
    VAR3: "teste3"
  script:
    - echo "$VAR1"
    - echo "$VAR2"
    - echo "$VAR3"

job12_b:
  script:
    - echo "$VAR1"
    - echo "$VAR2"
    - echo "$VAR3"
#################################

job13:
  script:
    - echo "Pipeline executada somente na branch main e usuário executor gitdz"
  rules:
    - if: '$CI_COMMIT_BRANCH == "main" && $GITLAB_USER_LOGIN == "gitdz"'
      when: manual
    - if: '$CI_COMMIT_BRANCH == "develop"'
      when: never

job14:
  script: echo "Executa exceto mensagem de commit push-tests"
  except:
    variables:
      - $CI_COMMIT_MESSAGE =~ /push-tests/

#############
variables:
  GLOBAL_VAR: global
job15:
  script:
    - echo " Apresenta declaração de variavel $GLOBAL_VAR"
job16:
  variables:
    LOCAL_VAR: local
  script:
    - echo Apresenta declaração de variavel $GLOBAL_VAR"
    - echo Apresenta declaração de variavel $LOCAL_VAR"
#############

############# OTIMIZAR YAML
job9: &cache
  when: manual
  script:
    - echo "Ola mundo"
job10:
  <<: *cache
#############

#############
job1:
  only: &variavel
    variables:
      - $GATILHO == "valor"
  script: echo "Ancora em uma sessão do Job"

job2:
  only: *variavel
  script: echo "Resultado da ancora"
#############

#############
.before-script: &before
  - echo "Execute este script primeiro"

.script: &script
  - echo "Execute este script por segundo"

.after-script: &after
  - echo "Execute este script por ultimo"

job1:
  before_script:
    - *before
  script:
    - *script
    - echo "Execute somente, para este job"
  after_script:
    - *after

############# Execução via api #############
job19:
  only:
    - tags
  when: manual
  script:
    - echo " Este Job executa com gatilho de tag."
#############



# Utilizado para gatilho com curl
#curl -X POST \
#     --fail \
#     -F token=c450ddc1e103178a5f6c1d0cd9d6e9 \
#     -F "ref=0.0.1" \
#     https://gitlab.com/api/v4/projects/34316608/trigger/pipeline

job20:
  only:
    variables:
      - $GATILHO == "valor"
  script:
    - echo "Executando job por uma variavel == valor"

# Utilizado para gatilho com curl
#curl -X POST \
#     --fail \
#     -F token=c450ddc1e103178a5f6c1d0cd9d6e9 \
#     -F "ref=main" \
#     -F "variables[GATILHO]=valor" \
#     https://gitlab.com/api/v4/projects/34316608/trigger/pipeline
##########################################


```



### Repositório de Exemplos

```href
https://gitlab.com/treinamentos1/pipeline/-/blob/main/.gitlab-ci.yml_exemplos

```


### Variáveis - Exportando variáveis
```yaml
    job12:
    script: |
      echo 'Apresentando variáveis'
      export
```

### Pipeline com condições

```yaml
  JobBuild:
    script:
      - echo "Pipeline executada somente na branch main e usuário executor gitdz"
    rules:
      - if: '$CI_COMMIT_BRANCH == "main" && $GITLAB_USER_LOGIN == "gitdz"'
        when: manual
      - if: '$CI_COMMIT_BRANCH == "develop"'
        when: never

```


### Executa exceto mensagem de commit push-tests
```yaml
job14:
  script: echo "Executa exceto mensagem de commit push-tests"
  except:
    variables:
      - $CI_COMMIT_MESSAGE =~ /push-tests/

```


# Otimização de YAML

### Ancora

```yaml
  job1:
  only: &variavel
    variables:
      - $GATILHO == "valor"
  script: echo "Ancora em uma sessão do Job"

job2:
  only: *variavel
  script: echo "Resultado da ancora"
#############

#############
.before-script: &before
  - echo "Execute este script primeiro"

.script: &script
  - echo "Execute este script por segundo"

.after-script: &after
  - echo "Execute este script por ultimo"

job1:
  before_script:
    - *before
  script:
    - *script
    - echo "Execute somente, para este job"
  after_script:
    - *after


```

### Ancora em uma sessão ONLY
```yaml
job1:
  only: &variavel
    variables:
      - $GATILHO == "valor"
  script: echo "Ancora em uma sessão do Job"

job2:
  only: *variavel
  script: echo "Resultado da ancora"


```



### Ancora em scripts

```yaml
.before-script: &before
  - echo "Execute este script primeiro"

.script: &script
  - echo "Execute este script por segundo"

.after-script: &after
  - echo "Execute este script por ultimo"

job1:
  before_script:
    - *before
  script:
    - *script
    - echo "Execute somente, para este job"
  after_script:
    - *after
```

### Enviando notificação ao telegram
1 - Criar o Bot com @BotFather e coletar o Token
  - Executar /newbot
  - Escolhe um nome_bot
  - Escolhe um para usuario_bot
  - /help
  - Mudar a imagem do bot
2 - Verificar as ações vinculadas ao bot via API
  https://api.telegram.org/botTOKEN
3 - Criar um Grupo
4 - Adicionar o Bot ao Grupo
5 - Coletar o ID do chat (etapa 2)
6 - Enviar uma mensagem via CURL
  curl -X POST "https://api.telegram.org/bot<TOKEN>/sendMessage" -d "chat_id=<-ID>&text=Meu texto"



### Enviando notificação ao teams

```shell
#On macOS or Linux
curl -H 'Content-Type: application/json' -d '{"text": "Hello World"}' <YOUR WEBHOOK URL>
```



### BUILD COM ENVIO DE MENSAGEM


```yaml
stages:
  - "build"
  - "notification"

default:
  image: docker:24.0.5
  services:
  - docker:24.0.5-dind
  before_script:
  - apk add --update curl && rm -rf /var/cache/apk/*
  - docker info
  - export LOWERCASE_PROJECT_NAME=$(echo $CI_PROJECT_NAME | tr '[:upper:]' '[:lower:]')
  - docker login -u $DOCKERHUB_USER_NAME -p $DOCKERHUB_USER_PASSWORD

BuildingImage:
  stage: build
  # Build de uma imagem container
  script:
  - docker build -t $DOCKERHUB_USER_NAME/$LOWERCASE_PROJECT_NAME:$CI_COMMIT_REF_NAME .
  - docker push $DOCKERHUB_USER_NAME/$LOWERCASE_PROJECT_NAME:$CI_COMMIT_REF_NAME
  after_script:
  - docker logout

SendNotification:
  stage: notification
  script: |
    curl -X POST "https://api.telegram.org/bot<BOT TOKEN>/sendMessage" -d "chat_id=<CHAT ID>&text=Meu texto"

```