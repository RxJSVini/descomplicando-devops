# POD
Um pod é a menor e mais básica unidade de implantação que você pode criar e gerenciar. É um wrapper que contém um ou mais contêineres (geralmente Docker), os quais compartilham recursos como armazenamento e rede. Cada pod é executado em um nó do cluster do Kubernetes, que pode ser uma máquina física ou virtual.

Os contêineres dentro de um mesmo pod têm o seguinte em comum:

Endereço IP: Todos os contêineres no pod compartilham um único endereço IP e podem se comunicar entre si através de localhost.
Volumes: Os contêineres podem compartilhar dados usando volumes que são definidos no nível do pod.
Informações de ciclo de vida: O estado do pod abrange todos os contêineres dentro dele. Se o pod inicia ou termina, isso afeta todos os contêineres simultaneamente.
O pod é fundamental no Kubernetes porque ele é a unidade de escala, ou seja, quando você escala sua aplicação, você está aumentando ou diminuindo o número de pods.


# Minikube
Primeiramente, certifique-se de estar com o minikube instalado.
Referência https://kubernetes.io/docs/tutorials/hello-minikube/

# Como subir um pod ?

kubectl apply -f ./pod.yaml


# Validando pod
kubectl get pod

*** Observe que no arquivo de pod definimos 3 replicas iniciais, e por isso teremos 3 pods relacionados a esse pod ***

# Obtendo pods
kubectl get pods

# Como escalar o pod ?
kubectl scale pod name-pod --replicas=quantidade de replicas

# Excluindo pod
kubectl delete pod name-pod

# Descrição do pod, este comando lista a descrição de um pod especifico
kubectl describe pod app-html-pod

# Descrição do pod, este comando lista a descrição de todos os pod
kubectl describe pod

# Port-forward em pods
Refência https://kubernetes.io/pt-br/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
kubectl port-forward pod-name port:port