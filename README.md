
# Ferramenta para gerenciamento grafico de k&S
https://docs.k8slens.dev/

## Introdução ao Cluster Kubernetes (K8S)

1. **Definição de Cluster**: Ao implantar o Kubernetes (K8S), você obtém um cluster. Este cluster é composto por um conjunto de máquinas físicas ou virtuais, chamadas de nós (nodes), que executam aplicativos em containers. Para alta disponibilidade e escalabilidade, um cluster típico contém múltiplos Worker Nodes e, idealmente, múltiplos Master Nodes.
2. **Elementos do Cluster**: O cluster possui dois tipos principais de nós: Worker Nodes e Master Nodes. O Worker Node é responsável por hospedar os Pods, que são os componentes executáveis de uma aplicação. O Master Node, ou plano de controle, gerencia o estado geral do cluster e toma decisões globais, como escalonamento e implantação.

## Tipos de Nós

### Worker Node

Hospeda os Pods, que são os componentes mínimos de execução de uma aplicação no Kubernetes.

### Master Node

Em um ambiente de desenvolvimento como o Minikube, uma única máquina atua como Master Node e Worker Node simultaneamente. No entanto, em um ambiente de produção, é recomendado ter múltiplos Master Nodes para garantir alta disponibilidade. O Master Node é crucial; sua indisponibilidade pode tornar o cluster inteiro inoperante.

## Tipos de Cluster

### Cluster Local

Um exemplo é o Minikube, que é ideal para aprendizado e desenvolvimento, mas não para produção.

### Cluster em Nuvem

Nesse cenário, você pode optar por usar o Control Plane como um serviço, liberando você das tarefas de gerenciamento de máquina, como backup e manutenção. Exemplos incluem AWS EKS, GKE e Azure AKS.

## Componentes de Gerenciamento

Estes componentes podem ser executados em qualquer nó do cluster, mas normalmente são inicializados no Master Node para simplificar a configuração.

- **kube-apiserver**: É o servidor API que valida e configura os dados para os objetos do cluster, como Pods, serviços, etc.
- **etcd**: É um armazenamento de chave-valor usado para manter o estado consistente do cluster.
- **kube-scheduler**: Responsável por agendar os Pods nos Worker Nodes.
- **kube-controller-manager**: Controla os controladores que regulam o estado do cluster.

## Ferramentas para Desenvolvimento Local

### Docker Desktop

É uma opção para executar containers localmente no Windows e macOS. Não é adequado para ambientes de produção.

[Site Oficial](https://www.docker.com/products/docker-desktop/)

### Minikube

É uma ferramenta que cria um cluster Kubernetes de nó único em sua máquina local, ideal para aprendizado e desenvolvimento.

[Site Oficial](https://minikube.sigs.k8s.io/docs/start/)

### Requisitos

- **CPUs**: Pelo menos 2 CPUs
- **Memória**: Pelo menos 2 GB
- **Espaço em Disco**: Pelo menos 20 GB
- **Conexão de Internet**: Necessária para atualizações e downloads
- **Hypervisor ou Container Runtime**: Docker, Hyper-V, VirtualBox, etc.

### Kubeadm 
Comando usado para criar cluster

### Kubelet 
Componente que executa em todas as máquinas no seu cluster e cuida das tarefas como a inicialização de pods e containers.
### kubectl

É a ferramenta CLI para interagir com o cluster Kubernetes. Com ela, você pode executar uma variedade de operações como instalar aplicações, inspecionar recursos e visualizar logs.


### Onde encontrar os arquivos de configuração do Kubernets no Linux ?
ls ~/.kube/config
cat ~/.kube/config
*** Fazendo backup da configuração do K8S ***
mv ~/.kube/config ~/.kube/config.bak

### Validar status do Cluster EKS

aws eks --region sa-east-1 describe-cluster --name clusterName --query cluster.status


### Comando na as para conectar no EKS em Nuvem

aws eks --region sa-east-1 update-kubeconfig --name clusterName

### Dica: 
Acesse https://docs.aws.amazon.com/pt_br/eks/latest/userguide/authenticate-oidc-identity-provider.html


### Primeiros passos com Kubernets

Implementando um aplicativo

PODS: 

Um pod do K*S é um conjunto de um ou mais containers, sendo a menor unidade de uma aplicação K8S. Os pods são compostos por um container nos casos de uso mais comuns, ou por vários containers fortemente acoplados em cenários mais avançados. Os containers são agripados nesses pods para que os recursos sejam compartilhados de modo inteligente.


### CURIOSIDADES

## Amazon ECS: Uma Visão Rápida

### O que é?

O Amazon Elastic Container Service (ECS) é um serviço de orquestração de contêineres totalmente gerenciado que facilita a execução, o stop e o gerenciamento de contêineres Docker.

### Características Principais

1. **Simplicidade na AWS**: Integra-se facilmente com outros serviços da AWS como ELB (Elastic Load Balancer), RDS, e S3.
2. **Flexibilidade de Execução**: Suporta dois modos de execução - EC2 e Fargate.
    - **EC2**: Você gerencia as instâncias EC2 onde os contêineres são executados.
    - **Fargate**: A AWS gerencia as instâncias, permitindo um modelo "serverless".
3. **Task Definitions**: Utilizadas para especificar as configurações do contêiner, como imagem do Docker, recursos, e variáveis de ambiente.
4. **Services**: Mantêm um número específico de instâncias de uma Task Definition em execução, facilitando o balanceamento de carga e atualizações contínuas.

### Pontos Críticos

1. **Custo**: O uso de Fargate pode ser mais caro do que EC2 se você já tiver uma infraestrutura bem gerenciada.
2. **Limitações de recursos**: Cada modo de lançamento tem suas próprias limitações, como CPU, memória e balanceamento de rede.

### Por que é Importante?

ECS facilita o gerenciamento de contêineres em grande escala e oferece uma alternativa ao Kubernetes para aqueles já investidos no ecossistema AWS.

## Exemplo de Task Definition do Amazon ECS

Aqui está um exemplo de como uma definição de tarefa ECS pode se parecer:

```json
{
  "family": "my-task-definition",
  "containerDefinitions": [
    {
      "name": "my-container",
      "image": "my-image",
      "secrets": [
        {
          "name": "MY_SECRET_KEY",
          "valueFrom": "arn:aws:ssm:region:aws_account_id:parameter/my_secret_key"
        }
      ]
    }
  ]
}


# Minikube
Primeiramente, certifique-se de estar com o minikube instalado.
Referência https://kubernetes.io/docs/tutorials/hello-minikube/
