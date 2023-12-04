# Kubernets

**Oque é Kubernets ?**
- Kubernetes é um projeto de software livre que permite a criação e gerenciamento de aplicações em contêiner

- O Kubernets é uma técnologia que revolucionou a orquestração de containers. Inclusive, hoje é uma referencia e essencial no mundo de computação, nuvem e Devops.

- O Kubernets também é conhecido como K8S.Uma forma abreviada e simplificada, 8 letras entre o K e o S - "Ubernete"

**Quem criou o kubernets?**
- Foi criado por Google, mas agora ele é mantido pela CNCF (Cloud Native Computing Foundation)

- Pré-kubernets
    - Originalmente desenvolvido pelo Google para resolver problemas de execução de um numero grande de serviços em escala Global. Inicialmente foi chamado de Borg.

- Nascimento do Kubernets
    - Em 2014 o Google startou o proketo Kubernets para desenvolver um orquestrador de containers open source.

    - Em 2015 o google doou o projeto Kubernets para a CNCF(Cloud Native Computing Fundation).

    - Apartir dessemomento o projeto teve ampla colaboração e adoção da comunidade open source. 


<hr/>

### Principais objetos do Kubernets

Os principais objetos do Kubernetes são:

-  **Pods**: Um pod é a unidade básica de implantação e gerenciamento no Kubernetes. Um pod é um grupo de um ou mais contêineres que são implantados e gerenciados juntos.
-  **Services**: Um serviço é um objeto que define um conjunto de pods e uma política para acessá-los. Os serviços são usados para expor os pods a outros pods ou serviços.
-  **Deployments**: Um deployment é um objeto que define como um conjunto de pods deve ser implantado e gerenciado. Os deployments são usados para gerenciar o ciclo de vida dos pods.
-  **ReplicaSets**: Um ReplicaSet é um objeto que garante que um número especificado de pods esteja sempre em execução. Os ReplicaSets são usados para garantir a disponibilidade dos pods.
-  **Ingress**: Um ingresso é um objeto que define como o tráfego externo deve ser roteado para os serviços. Os ingressos são usados para expor os serviços ao mundo exterior.

<hr/>

### Oque faz o Kubernets tão valioso ?
O kubernets faz as tarefas que o melhor dos administradores de sistemas faria:automação, failover, logging centralizado, e monitoração. Ele  toma que aprendemos com a comunidade de Devops e torna isso em algo em algo pronto para uso imediato.



<hr/>

### Arquitetura do Kubernets
Assim como todo cluster o K8S executa 1 cluster com 2 tipos de Nodes.

- **NodeMaster**
- **NodeWorker**


O NodeMaster é conhecido como Control Plane.

Referência: [Documentação oficial   ](https://kubernetes.io/docs/concepts/overview/)

<hr/>

### Plano de Controle:

- **etcd**: armazenamento de dados confiável e distribuído.
- **kube-apiserver**: ponto central de gerenciamento do Kubernetes.
- **kube-scheduler**: responsável por agendar pods nos nós.
- **kube-controller-manager**: executa os processos de controle.
- **cloud-controller-manager**: integra o cluster com APIs de provedores de nuvem.
- **Cluster (Nós de Trabalho)**:

- **Node 1 e Node 2**: representam os nós de trabalho do Kubernetes.
- **kubelet**: agente que executa em cada nó.
- **kube-proxy**: mantém as regras de rede nos nós.
pod: unidades mais pequenas que podem ser escaladas e gerenciadas no Kubernetes.
- **CRI**: Interface de Runtime do Container.



### Control Plane

-  *Executa todas as tarefas "inteligentes" do Kubernets, é uma espécie de gerente*

- *O Plano de controle é composto por vários componentes:*
    - kube-apiserver
    - etcd
    - kube-scheduler
    - kube-controller-manager
    - cloud-controller-manager


<hr/>

### Worker Nodes

- *kubelet*
- *kube-proxy*
- *runtime do container*


<hr/>

### Objetos Kubernets para iniciantes


*O Kubernets possui diversos objetos, mas para iniciar de fato no apredizado, precisamos focar nos principais, segue a lista abaixo:*

- **Pod**
- **Deployment**
- **ReplicaSet**
- **Service**

<hr/>
**EKS - AWS**
[Configura as dicas para configuração de EKS na AWS](https://aws.amazon.com/pt/eks/)



### Comandos CLI

- **Criando um deployment via CLI, sem ter o .yaml criado**:
```bash
kubectl create deploy python --image python:latest
```

- **Simulando a criação de um recurso, simulando a criação, e exportando um yaml**:
```bash
kubectl create deploy python --image python:latest --dry-run=client -o yaml
```
