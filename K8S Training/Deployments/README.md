# Deployment
um deployment é um objeto que gerencia um conjunto de réplicas de pods. Quando você cria um deployment no Kubernetes, você está basicamente dizendo ao sistema como você quer que sua aplicação seja executada e acessível. O deployment garante que um número especificado de réplicas do pod estejam rodando a qualquer momento. Se um pod falha, o deployment automaticamente cria outro pod para substituir, mantendo o estado desejado da aplicação.

Esse processo é essencial para a implementação de estratégias de entrega contínua e para a garantia de alta disponibilidade e escalabilidade das aplicações em contêineres. O Kubernetes cuida da complexidade de gerenciar onde e como os contêineres são executados, permitindo que os desenvolvedores se concentrem na construção de software.

# Minikube
Primeiramente, certifique-se de estar com o minikube instalado.
Referência https://kubernetes.io/docs/tutorials/hello-minikube/



# Como subir um deployment ?
kubectl apply -f ./deployment.yaml


# Validando deployments
kubectl get deployments

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

# Descrição do deployment, este comando lista a descrição de todos os deployments
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

Além disso, é recomendável automatizar tanto quanto possível o processo de CI/CD, usando ferramentas como Jenkins, GitLab CI ou GitHub Actions, para que as atualizações dos aplicativos sejam mais gerenciáveis e menos propensas a erro humano.