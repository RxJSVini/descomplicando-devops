# Namespaces

Namespace no Kubernetes é um mecanismo para isolar grupos de recursos dentro do mesmo cluster. Pense em namespaces como uma forma de dividir um cluster físico em vários clusters virtuais. Isso é particularmente útil em ambientes com muitos usuários e projetos para evitar interferências e conflitos entre eles, pois os recursos em diferentes namespaces operam como se estivessem em clusters separados, embora a infraestrutura subjacente seja compartilhada.


Cada recurso Kubernetes é criado dentro de um namespace específico, e um namespace pode conter objetos como pods, serviços, deployments e outros recursos. Quando você trabalha com Kubernetes, se não especificar um namespace, o sistema assume que está operando no namespace default. Além do namespace default, há outros dois namespaces que são criados automaticamente:

- **kube-system**: 
Este namespace contém os recursos do sistema necessários para que o Kubernetes funcione.

- **kube-public**: 
Este é um namespace especial que é legível por todos os usuários e usado para recursos públicos do cluster.


## Erros comuns pra quem está iniciando

**No resources found in default namespaces**

Se você recebeu uma mensagem informando que não existe um namespace específico, isso significa que você está tentando criar ou interagir com recursos em um namespace que não existe no seu cluster Kubernetes. Por padrão, se você não especificar um namespace em seus arquivos YAML ou em seus comandos kubectl, o Kubernetes assume o namespace default.

**OBS:** Para resolver o problema, você tem algumas opções:

Essa é a primeira opção, e a mais simples, usar o namespace existente:
- **Use o Namespace Default**:
Se você não precisa de um namespace específico e está bem em usar o namespace padrão, simplesmente não especifique um namespace em seus arquivos YAML ou comandos.

Aqui podemos botar a criatividade em ação, e criar um namespace:
- **Crie o Namespace**:
Se você deseja organizar seus recursos em um namespace específico, você deve primeiro criar esse namespace antes de implantar seus recursos. Você pode fazer isso com o seguinte comando kubectl:

```bash
    kubectl create namespace meu-namespace
```

Depois de criar o namespace, você deve incluir a seção namespace nos seus arquivos YAML para especificar em qual namespace seus recursos serão criados.

### Exemplo para um Deployment:

```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: meu-app-deployment
    namespace: meu-namespace
    # ... outras configurações ...
```

### Exemplo para um Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: meu-app-service
  namespace: meu-namespace
# ... outras configurações ...
```

Alternativa final:
- **Especifique o Namespace nos Comandos kubectl**:
  Se você preferir, pode especificar o namespace diretamente nos comandos kubectl usando a flag --namespace, assim:


```bash
    kubectl apply -f deployment.yaml --namespace=meu-namespace
    kubectl apply -f service.yaml --namespace=meu-namespace
```

### Em Resumo
Usar namespaces permite que você organize seus recursos de forma que reflita as diferentes equipes, aplicações ou ambientes de teste e produção. Isso também fornece um nível de segurança, permitindo que você aplique políticas de acesso e quotas de recursos a diferentes namespaces para controlar quem pode acessar o quê dentro do seu cluster Kubernetes.