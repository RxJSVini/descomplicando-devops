No Minikube, o Service do tipo LoadBalancer mostrará o endereço IP externo como <pending> porque, por padrão, o Minikube não provê um IP externo real, já que está executando localmente e não em um provedor de nuvem que fornece balanceadores de carga.

Para acessar o serviço que está sendo exposto como um LoadBalancer no Minikube, você pode usar o comando minikube service, que abrirá uma nova janela do navegador apontando para o serviço ou fornecerá um URL que você pode usar. Aqui está o comando específico novamente:

```bash
    minikube service blog-service-loadbalancer
```
Isso vai fazer o Minikube encaminhar o tráfego do seu computador para o serviço dentro do Minikube. O Minikube faz o mapeamento da porta do LoadBalancer para uma porta no seu computador, então mesmo que o IP externo esteja pendente, o Minikube ainda permite que você acesse o serviço.

Se você quiser ver o URL sem abrir o navegador, você pode adicionar a flag --url:

```bash
    minikube service blog-service-loadbalancer --url

```
O status "Pending" para o IP externo de um serviço do tipo LoadBalancer no Minikube é esperado, pois o Minikube não fornece um IP externo real. No entanto, o Minikube tem uma funcionalidade integrada para acessar serviços do tipo LoadBalancer.

Para acessar o serviço, você não precisa esperar por um IP externo; você pode utilizar o comando minikube tunnel. Este comando cria um túnel entre o Minikube e o sistema operacional do host para fornecer IPs externos aos serviços do tipo LoadBalancer.

Execute o seguinte comando em um terminal separado:

```bash
    minikube tunnel
```

Este comando pedirá permissão de administrador, pois precisa configurar rotas de rede no host. Depois de executar o minikube tunnel, o status do IP externo do serviço LoadBalancer deve mudar de <pending> para um endereço IP real (que será acessível apenas localmente).

Referência:
https://minikube.sigs.k8s.io/docs/handbook/accessing/#access-to-ports-1024-on-windows-requires-root-permission