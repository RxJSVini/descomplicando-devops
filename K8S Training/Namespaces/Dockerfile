FROM ubuntu:20.04

WORKDIR /home
# Instalar pacotes necessários
RUN apt-get update && \
    apt-get install -y wget unzip curl vim dos2unix && \
    wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \
    unzip awscli-exe-linux-x86_64.zip && \
    rm awscli-exe-linux-x86_64.zip && \
    ./aws/install && \
    rm -rf aws && \
    apt-get clean && \
    apt-get clean
 
COPY backup.sh /home/
COPY chave.key /home/
RUN dos2unix backup.sh


# Instalar kubectl
# Defina a variável de ambiente para a versão do kubectl
ARG KUBECTL_VERSION=v1.20.0
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# Comando para manter o contêiner rodando
CMD tail -f /dev/null
