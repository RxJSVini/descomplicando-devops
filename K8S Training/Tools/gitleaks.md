# Instalando o go

### Primeiro vamos fazer um wget passando a url do arquivo compactado do go

**Repositório oficial: https://github.com/gitleaks/gitleaks

Comando:

```bash
wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
```

### Depois vamos descompactar o arquivo.
```bash
sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
```

 É o comando usado para criar, extrair, listar, testar e manipular arquivos em formato tar no Unix e sistemas semelhantes. -C /usr/local: Esta opção é específica e muito importante. O -C indica a mudança para um diretório específico antes de realizar qualquer operação. Neste caso, o comando mudará para o diretório /usr/local antes de extrair o arquivo tar.




### Vamos exportar o arquivo de execução do Go como variavel de ambiente.

```bash
    export PATH=$PATH:/usr/local/go/bin
```


### Instalando o gitleaks
```bash
git clone https://github.com/gitleaks/gitleaks.git
cd gitleaks
make build
```


```bash
sudo mv gitleaks /usr/local/bin/

```

Verifique se o Gitleaks está acessível de qualquer lugar usando:

```bash
which gitleaks
```
