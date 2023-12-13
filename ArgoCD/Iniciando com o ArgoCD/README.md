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



## Expondo o service do ArgoCD para acessar a interface do mesmo
```bash
kubectl port-forward svc/argocd-server 8080:443 -n argocd
```

Pronto, agora podemos acessar o ArgoCD através do endereço localhost:8080, tanto pelo navegador quanto pelo CLI.

Vamos continuar com a nossa saga utilizando o CLI, então vamos fazer a autenticação no ArgoCD.

Para fazer a autenticação no ArgoCD, precisamos executar o seguinte comando:

```bash
argocd login localhost:8080
```



Perceba que ele irá pedir o usuário e a senha, mas não se preocupe, pois o usuário padrão do ArgoCD é o admin, e a senha inicial está armazenada em um secret, então vamos executar o seguinte comando para pegar a senha:

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

## Adicionando cluster no ArgoCD

```bash
argocd cluster add name-cluster
```
## Criando nosso primeiro app no argo

```bash
# O cluster foi pego da saida do comando argocd cluster list
argocd app create nginx-app --repo https://github.com/badtuxx/k8s-deploy-nginx-example.git --path . --dest-server https://live-aks-k-livek8s-26438d-jv87d1xi.hcp.eastus.azmk8s.io:443 --dest-namespace default

```
## Syncronizando app
```bash
argocd app sync nginx-app
```


https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/

# Criando aplicativos automaticamente no Cluster

Para que as aplicações sejam criadas automaticamente no Argo CD a partir dos arquivos YAML em uma pasta específica do seu repositório, você precisará configurar um recurso chamado "App of Apps" no Argo CD. Essa abordagem usa um padrão onde um aplicativo Argo CD (o "app mestre") gerencia a criação e sincronização de outros aplicativos Argo CD definidos em arquivos YAML no seu repositório.

Passos para Configurar o "App of Apps" no Argo CD:
Criar um Aplicativo Mestre no Argo CD:

Este aplicativo apontará para a pasta no seu repositório onde os arquivos de definição de aplicativos (Application) estão localizados.
Você pode criar este aplicativo mestre usando a UI do Argo CD ou a linha de comando.
Estrutura do Repositório:

Certifique-se de que a pasta no seu repositório contenha arquivos YAML válidos de Application do Argo CD.
Exemplo de um Arquivo YAML de Aplicativo Mestre:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: in-cluster
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://your-repo-url.git
    path: path/to/your/applications/folder
    targetRevision: HEAD
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      selfHeal: true
      prune: true

```


## Syncronização da criação de novos apps
https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/
