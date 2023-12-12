# Kustomize do Kubernetes

O Kustomize é uma ferramenta integrada ao `kubectl` que facilita a personalização de configurações do Kubernetes de forma declarativa. A partir da versão 1.14 do Kubernetes, o Kustomize permite aos usuários gerenciar suas configurações de aplicativos de maneira mais eficiente e flexível.

## Funcionalidades Principais

### Geração de Recursos
Cria novos recursos com base em recursos existentes.

### Overlay de Configuração
Permite sobrepor mudanças em cima de diretórios de base para manter variantes como desenvolvimento, homologação e produção.

### Patch de Recursos
Aplica patches em recursos para modificar suas configurações.

### Manipulação de Secretos e ConfigMaps
Cria e modifica Secrets e ConfigMaps de forma dinâmica.

### Customização de Nome e Prefixo
Altera nomes e prefixos para evitar colisões em ambientes compartilhados.

## Como Funciona

O Kustomize usa um arquivo `kustomization.yaml`, que especifica as operações de personalização a serem aplicadas aos recursos. Esse arquivo é colocado no diretório dos recursos do Kubernetes ou em um diretório separado.

### Exemplo de Uso

Para modificar a imagem de um deployment, você criaria um `kustomization.yaml` como abaixo:

```yaml
resources:
  - deployment.yaml

images:
  - name: my-app
    newName: my-registry/my-app
    newTag: v1.2.3

```

# Executando o Kustomize
Para aplicar as customizações, use o comando:

```bash
kubectl apply -k ./path/to/kustomization/folder

```

O Kustomize é uma ferramenta essencial para gerenciar configurações complexas do Kubernetes, promovendo infraestrutura como código (IaC) e facilitando a manutenção em ambientes múltiplos e complexos. Ele permite que as modificações sejam definidas separadamente dos recursos originais, aumentando a reusabilidade e a eficiência.