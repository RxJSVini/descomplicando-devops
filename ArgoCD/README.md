## ArgoCD oque é ?

Argo CD é uma ferramenta declarativa de entrega contínua GitOps de código aberto para Kubernetes. Ele automatiza o processo de implantação de aplicativos no Kubernetes monitorando continuamente um repositório Git e aplicando quaisquer alterações ao estado desejado do aplicativo. O Argo CD pode ser usado para implantar aplicativos em qualquer cluster Kubernetes, independentemente de seu tamanho ou complexidade.

O Argo CD funciona observando alterações em um repositório Git. Quando uma alteração for detectada, o Argo CD criará ou atualizará automaticamente um arquivo de manifesto do Kubernetes com base nas alterações no repositório Git. Este arquivo de manifesto é então aplicado ao cluster Kubernetes, o que fará com que o estado desejado do aplicativo seja alcançado.

O Argo CD pode ser usado para implantar aplicativos de diversas maneiras. Ele pode ser usado para implantar aplicativos do zero ou para atualizar aplicativos existentes. O Argo CD também pode ser usado para reverter implantações, se necessário.

Argo CD é uma ferramenta poderosa que pode ser usada para simplificar o processo de implantação de aplicativos no Kubernetes. É fácil de usar e pode ser usado para implantar aplicativos em qualquer cluster Kubernetes.



## O que vamos aprender no Day-1?
Durante o day-1 iremos aprender o que é o ArgoCD, vamos entender o que é o GitOps e o que é estado desejado, vamos entender o que é um continuous delivery e como o ArgoCD pode nos ajudar a entregar nossas aplicações no Kubernetes de forma contínua e segura.

Vamos ainda ver como instalar o nosso ArgoCD no Kubernetes como um operador, e também iremos instalar o ArgoCD CLI, que é a ferramenta que vamos utilizar para gerenciar as nossas aplicações no ArgoCD.

Vamos adicionar o nosso cluster e criar a nossa primeira aplicação no ArgoCD, para que seja possível o deploy em nosso cluster.

Enfim, muita coisa interessante para aprender no day-1, e para isso, vamos precisar de alguns pré-requisitos.

- Ter um cluster Kubernetes rodando
- Ter o kubectl instalado
- Ter força de vontade para aprender

### O que é GitOps?
Esse livro não tem como objetivo descomplicar o GitOps. Nesse livro o nosso objetivo é descomplicar uma das etapas fundamentais do GitOps, que é a utilização do ArgoCD para gerenciar as entregas contínuas no Kubernetes.

O GitOps é um conceito que foi criado pela Weaveworks, e que tem como objetivo facilitar a entrega de aplicações no Kubernetes, utilizando o Git como fonte de verdade. O Git é a fonte de verdade, e o Git é o único lugar onde você vai encontrar a verdade sobre o estado da sua aplicação.

Se lá é a fonte da verdade, vale a pena falar que quando estamos falando de GitOps, estamos falando sobre modo declarativo de gerenciar as aplicações no Kubernetes. Quando falamos em declarativo, estamos falando que o estado que das suas aplicação no Kubernetes, é o mesmo que está no Git, que é o mesmo que você deseja que esteja no Kubernetes.


### Repositório descomplicando ARGOCD
https://github.com/badtuxx/DescomplicandoArgoCD




### Artigo de Implementação do ArgoCD

https://blog.knoldus.com/how-to-create-applications-in-argocd/