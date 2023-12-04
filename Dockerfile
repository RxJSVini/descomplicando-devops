FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget git make

RUN wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz \
    && rm go1.21.4.linux-amd64.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin"

RUN git clone https://github.com/gitleaks/gitleaks.git \
    && cd gitleaks \
    && make build \
    && mv gitleaks /usr/local/bin/

RUN which gitleaks

CMD ["bash"]
