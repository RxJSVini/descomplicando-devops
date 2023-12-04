# Pipelines
### Referencias
https://docs.gitlab.com/ee/ci/pipelines/
https://docs.gitlab.com/ee/ci/yaml/

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