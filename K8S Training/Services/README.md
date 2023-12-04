# Kubernetes Services

## Introdução
O Kubernetes `Service` é um objeto que define um conjunto de pods e uma política para acessá-los. Isso é especialmente útil para gerenciar o acesso aos pods, que podem ser criados e destruídos frequentemente.

## Tipos de Services
Existem vários tipos de Services no Kubernetes:


### Tabela com o valor que vai no apiVersion, de acordo com cada recurso do K8S

- **POD**: v1
- **Deployment**: apps/v1
- **Service**:v1

### 1. ClusterIP
- **Descrição**: Este é o tipo padrão. Expõe o Service em um endereço IP interno no cluster. Isso torna o Service acessível apenas dentro do cluster.
- **Uso**: Ideal para aplicações internas do cluster.

### 2. NodePort
- **Descrição**: Expõe o Service em cada IP do nó no qual o cluster está rodando, em uma porta estática (NodePort). Um ClusterIP é automaticamente criado.
- **Uso**: Útil para acesso externo quando um balanceador de carga externo não é usado.

### 3. LoadBalancer
- **Descrição**: Expõe o Service externamente usando o balanceador de carga do provedor de nuvem. Cria automaticamente um NodePort e um ClusterIP.
- **Uso**: Ideal para aplicações que exigem acesso externo e estão hospedadas em ambientes de nuvem.

### 4. ExternalName
- **Descrição**: Mapeia o Service para um nome DNS externo. Não usa proxy ou encaminhamento.
- **Uso**: Adequado para serviços que são gerenciados fora do Kubernetes e precisam ser acessados por recursos dentro do cluster.

## Seletores e Pods
- **Seletores**: Services usam seletores de rótulos para identificar os pods aos quais eles fornecem acesso.
- **Pods sem seletores**: Também é possível criar um Service sem um seletor e definir manualmente o endpoint.

## Exemplo Básico
Aqui está um exemplo simples de um manifest de Service em YAML:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: meu-service
spec:
  type: ClusterIP
  selector:
    app: MeuApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376

