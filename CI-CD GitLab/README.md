```href
https://gitlab.com/treinamentos1/pipeline
```

### Preparando o ambiente Local
```bash
#!/bin/bash
# 01-install-docker.sh
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

```

```bash
#!/bin/bash
#02-install-compose.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

```

### Instalação do agent-runner
```bash
#!/bin/bash
#03-install-agente.sh
# Instalar o Gitlab-Runner
sudo curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner

# Inserir usuário gitlab-runner ao grupo docker
sudo usermod -aG docker gitlab-runner

# Adicionar o gitlab-runner ao sudo sem pedir senha
sudo echo "gitlab-runner    ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers


```


### Configuração do Runner
```bash
#!/bin/bash

# Ingressar o Runner em modo shell no GitLab
sudo gitlab-runner register -n \
  --url https://gitlab.com/ \
  --registration-token TOKEN \
  --executor shell \
  --description "Runner Shell"

# Criar o container gitlab-runner para Docker
docker run -dit \
  --name runner-docker \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /opt/gitlab-runner/config:/etc/gitlab-runner \
  gitlab/gitlab-runner:ubuntu-v14.9.1

# Ingressar o Runner em modo docker no GitLab
docker exec -it runner-docker \
gitlab-runner register -n \
  --url https://gitlab.com/ \
  --registration-token TOKEN \
  --clone-url http://IP \
  --executor docker \
  --docker-image "docker:latest" \
  --docker-privileged


```


### Ramificação das branchs

# Branches no Git

## Main/Main
- **Descrição**: A branch principal que contém o código de produção.
- **Tipo**: Produção.
- **Tempo de Vida**: Permanente.
- **Criada de**: Inicial do repositório.
- **Pode ir para**: Recebe merges de `hotfix` e `release`.

## Develop
- **Descrição**: Contém o estado mais atual do desenvolvimento.
- **Tipo**: Desenvolvimento.
- **Tempo de Vida**: Permanente.
- **Criada de**: `main` no início do projeto.
- **Pode ir para**: Recebe `feature` branches e envia para `release`.

## Feature
- **Descrição**: Para novas funcionalidades ou melhorias no código.
- **Tipo**: Suporte.
- **Tempo de Vida**: Finito, até a funcionalidade ser concluída.
- **Criada de**: `develop`.
- **Pode ir para**: `develop` após a conclusão.

## Hotfix
- **Descrição**: Correções críticas para a produção.
- **Tipo**: Emergência.
- **Tempo de Vida**: Finito, até a correção ser aplicada.
- **Criada de**: `main`.
- **Pode ir para**: `main` e posteriormente para `develop`.

## Release
- **Descrição**: Preparação de novas versões para produção.
- **Tipo**: Pre-lançamento.
- **Tempo de Vida**: Finito, até o lançamento ser concluído.
- **Criada de**: `develop`.
- **Pode ir para**: `main` para o lançamento e depois para `develop`.





# Gitflow e Versionamento Semântico

## Gitflow
É uma estratégia robusta de branches que envolve várias branches para diferentes propósitos, garantindo organização e eficiência no desenvolvimento e lançamento de software.

### Branches Principais no Gitflow:
- `feature`: Para novas funcionalidades.
- `develop`: Integração de features, branch de desenvolvimento constante.
- `release`: Preparação para um novo lançamento de versão.
- `hotfix`: Correções urgentes na produção.
- `main`: O código de produção estável.

## Versionamento Semântico
Um sistema de versionamento que reflete mudanças no software de maneira estruturada e previsível.

### Estrutura:
- `MAJOR`: Mudanças que quebram a compatibilidade com versões anteriores.
- `MINOR`: Novas funcionalidades que não quebram compatibilidade com versões anteriores.
- `PATCH`: Correções de bugs que não quebram compatibilidade com versões anteriores.

### Uso:
- Versão inicial começa em `1.0.0`.
- Ao fazer mudanças incompatíveis com a API, incrementa-se a versão `MAJOR`.
- Ao adicionar funcionalidades mantendo compatibilidade, incrementa-se a versão `MINOR`.
- Para correções de bugs que não afetam a API, incrementa-se a versão `PATCH`.
- Prefixos adicionais podem ser usados para pre-releases, como `-alpha`, `-beta`, `-rc` (release candidate).


# GitOps

GitOps é um paradigma para gerenciamento de infraestrutura e aplicações que utiliza o Git como a fonte de verdade para a configuração declarativa do sistema.

## Conceitos Principais
- **Código Declarativo**: A infraestrutura e as aplicações são definidas em um formato declarativo.
- **Fonte Única da Verdade**: O Git mantém o estado desejado e o histórico de todas as mudanças.
- **Automação**: Mudanças no repositório Git desencadeiam processos automáticos para atualizar a infraestrutura.
- **Revisão de Código**: As alterações são revisadas por meio de pull/merge requests.
- **Monitoramento e Autocorreção**: O sistema é continuamente monitorado e ajustado para alinhar-se com o estado declarado no Git.

## Benefícios do GitOps
- **Produtividade**: Processos automatizados para implantação e manutenção.
- **Rastreabilidade**: Histórico completo de mudanças no Git.
- **Velocidade**: Implantações rápidas e ciclos de feedback curtos.
- **Estabilidade**: Redução de erros humanos graças à automação.
- **Segurança**: Controle de acesso e revisão de código aprimorados.
