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