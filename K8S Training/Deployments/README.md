# Deployment no Kubernetes Usando Minikube

## Introdução ao Deployment
Um deployment é um objeto no Kubernetes que gerencia um conjunto de réplicas de pods. Ao criar um deployment, você instrui o sistema sobre como deseja que sua aplicação seja executada e acessível. O deployment garante que um número especificado de réplicas do pod estejam rodando a qualquer momento. Se um pod falhar, o deployment cria automaticamente outro para substituir, assegurando a continuidade e o estado desejado da aplicação.

Este processo é fundamental para estratégias de entrega contínua, proporcionando alta disponibilidade e escalabilidade para aplicações em contêineres.

## Preparação com Minikube
Antes de iniciar, é crucial ter o Minikube instalado. Ele permite a execução do Kubernetes localmente.

Referência para instalação: [Hello Minikube](https://kubernetes.io/docs/tutorials/hello-minikube/)


### Tabela de apiVersion para Recursos Kubernetes
- **POD**: v1
- **Deployment**: apps/v1
- **Service**: v1

## Comandos Essenciais para Gerenciamento de Deployment

### Criando um Deployment
```bash
kubectl apply -f ./deployment.yaml
```

*** Observe que no arquivo de deployment definimos 3 replicas iniciais, e por isso teremos 3 pods relacionados a esse deployment ***

# Obtendo pods
kubectl get pods

# Como escalar o deployments ?
Referência: https://kubernetes.io/docs/tutorials/kubernetes-basics/scale/scale-intro/

kubectl scale deployment name-deployment --replicas=quantidade de replicas

# Excluindo deployments
kubectl delete deployments name-deployment

# Descrição do deployment, este comando lista a descrição de um deployment especifico
kubectl describe deployments app-html-deployment

###  Descrição do deployment, este comando lista a descrição de todos os deployments
kubectl describe deployments

# Expondo um deployment
kubectl explose deployment app-html-deployment --type-LoadBalancer --name=app-html --port=80

# Pegando a url do serviço exposto pelo minikube
```bash
    minikube service --url app-name
```

# Atualizando aplicativo

Para atualizar um aplicativo no Kubernetes que está sendo executado via Minikube, você precisa seguir uma série de etapas técnicas que normalmente envolvem a atualização da imagem do contêiner do aplicativo ou de sua configuração. Aqui está um guia técnico sobre como fazer isso:

 - **Atualize a Imagem do Contêiner**: Se a atualização envolve uma nova versão da imagem do contêiner, você precisa construir ou obter a nova imagem e fazer o push dela para o registro de contêineres que você está utilizando.

- **Modifique a Configuração do Pod**: Atualize o arquivo de configuração do Kubernetes (geralmente um arquivo YAML) que define o Pod ou Deployment para usar a nova imagem. Isso geralmente envolve alterar a tag da imagem no arquivo de especificação.

**Aplicar as Mudanças**: Use o comando kubectl apply para aplicar as mudanças no cluster. Por exemplo, se você modificou um Deployment chamado meu-app para usar a imagem minha-imagem:2.0, o comando seria:

```bash
    kubectl apply -f meu-app-deployment.yaml
```
Isso instrui o Kubernetes a atualizar os Pods com a nova imagem.

- **Verificar o Status do Rollout**: Use o comando kubectl rollout status para acompanhar o progresso da atualização:

```bash
    kubectl rollout status deployment/meu-app
```

- **Rolback de aplicativos**:
```bash
    kubectl rollout undo deployment/meu-app
```

### Para versão especifica
```bash
    kubectl rollout undo deployment/meu-app --to-revision=1
```
Além disso, é recomendável automatizar tanto quanto possível o processo de CI/CD, usando ferramentas como Jenkins, GitLab CI ou GitHub Actions, para que as atualizações dos aplicativos sejam mais gerenciáveis e menos propensas a erro humano.




# Deployment e Service em um único arquivo

É possível definir um Pod e um Service no Kubernetes em um único arquivo YAML. No entanto, há alguns pontos críticos e práticas recomendadas que devem ser considerados:

Uso de Pods vs. Deployments: No seu YAML, você está criando um Pod diretamente. Embora isso seja tecnicamente possível, na prática, é mais comum e recomendado usar um Deployment (ou StatefulSet para certos casos) para gerenciar Pods. Deployments fornecem funcionalidades adicionais, como atualizações rolling, reversão, escalabilidade, entre outros. Se você usar um Deployment, o próprio Kubernetes cuidará da criação e gerenciamento dos Pods.

Aqui está uma versão revisada do seu YAML, usando um Deployment em vez de um Pod direto e corrigindo o problema do selector:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: myapp-deployment
spec:
    replicas: 1
    selector:
        matchLabels:
            app: myapp
    template:
        metadata:
            labels:
                app: myapp
        spec:
            containers:
            - name: myapp
              image: image-reference
              ports:
                - containerPort: 80

---

apiVersion: v1
kind: Service
metadata:
    name: myapp-service
spec:
    type: NodePort
    selector:
        app: myapp
    ports:
        - port: 80


```



# Atualizando Aplicações
Atualize a Imagem do Contêiner: Construa ou obtenha a nova versão da imagem do contêiner e faça o push para o seu registro.

Modifique a Configuração do Pod: Atualize o arquivo YAML do Kubernetes para a nova imagem.

**Aplicar as Mudanças**:

```bash
kubectl apply -f meu-app-deployment.yaml
```


**Verificar o Status do Rollout**:


```bash
kubectl rollout status deployment/meu-app
```


**Rollback de Aplicações**:

```bash
kubectl rollout undo deployment/meu-app
```