# Dive: Análise de Imagens Docker

**O que é o Dive?**
Dive é uma ferramenta de linha de comando que permite aos desenvolvedores explorar as camadas de uma imagem Docker, identificando o conteúdo de cada camada e analisando a eficiência do uso do espaço. Essa ferramenta é essencial para otimizar imagens Docker, reduzindo seu tamanho e melhorando a eficiência na entrega e no armazenamento.

**Principais Funcionalidades**
Visualização Detalhada das Camadas: Dive mostra a composição de cada camada da imagem Docker, incluindo arquivos adicionados, modificados ou removidos.

Análise de Eficiência da Imagem: Calcula uma métrica de eficiência, indicando a porcentagem de espaço desperdiçado na imagem. Isso ajuda a identificar redundâncias e a otimizar a construção das camadas.

Integração com Ambientes de CI/CD: Dive pode ser integrado em pipelines de CI/CD para garantir que as imagens Docker sejam eficientes antes de serem enviadas para um registro de container.

**Instalação**
O Dive pode ser instalado em sistemas operacionais Windows, Linux e macOS. Aqui estão as instruções básicas de instalação:

**Windows**: Disponível para download direto ou via Chocolatey.
**Linux**: Disponível para várias distribuições, geralmente instalado via gerenciadores de pacotes como apt ou yum.
**macOS**: Instalável via Homebrew ou MacPorts.


### Formas de uso

**Primeiro exemplo**:

```bash
dive <nome-da-imagem>
```

Substitua <strong> nome-da-image </strong> pela tag da imagem que você deseja analisar.


### Outra forma de uso

```powershell
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive:latest <dive arguments...>
```




### Integração com CI/CD
Para integrar o Dive em um pipeline de CI/CD:

```bash
CI=true dive <nome-da-imagem>
```