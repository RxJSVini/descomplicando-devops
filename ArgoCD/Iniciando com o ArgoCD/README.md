# Instalando o ArgoCD como um operador no Kubernets

Para instalar o ArgoCD como um operador no Kubernets, antes pricisamos criar uma namespace chamada argocd, e para isso basta executar o seguinte comando:

## Criando o namespace do ArgoCD
```bash
kubectl create namespace argocd
```


## Instalando o ArgoCD

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```



## Checando a instalação do ArgoCD

Onde temos os seguintes pods:

Vamos ver se os pods do ArgoCD foram criados com sucesso:
```bash
kubectl get pods -n argocd
```


```bash
NAME                                                READY   STATUS    RESTARTS   AGE
argocd-application-controller-0                     1/1     Running   0          115s
argocd-applicationset-controller-5f67f4c987-vdtpr   1/1     Running   0          117s
argocd-dex-server-5859d89dcc-c69fx                  1/1     Running   0          117s
argocd-notifications-controller-75c986587-7jznn     1/1     Running   0          116s
argocd-redis-74c8c9c8c6-mzdlv                       1/1     Running   0          116s
argocd-repo-server-76f77874d7-8qscp                 1/1     Running   0          116s
argocd-server-64d5654c48-tkv65                      1/1     Running   0          116s
```


## Instalando o ArgoCD CLI
Como eu falei, o ArgoCD possui uma interface gráfica, mas também é possível interagir com ele através de comandos. Para isso, precisamos instalar o argocd CLI.

Nós vamos focar a primeira parte desse livro no CLI, para que você consiga entender como funciona o ArgoCD por baixo dos panos, e depois sim, se delicie com a interface gráfica.

Para instalar o argocd CLI no Linux, basta executar o seguinte comando:
```bash
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

rm argocd-linux-amd64
```



Com o comando acima fizemos o download do binário do argocd CLI, e o instalamos no diretório /usr/local/bin/argocd, para fazer a instalação utilizamos o comando install do Linux, que é um comando que faz a instalação de arquivos e diretórios. Passamos os parâmetros -m 555 para definir as permissões do arquivo, e o nome do arquivo que queremos instalar.

Pronto! O nosso argocd CLI está instalado.

Vamos ver se ele está funcionando corretamente:
```bash
argocd version
```