#!/usr/bin/env bash
set -euo pipefail

# Verifica a existência dos comandos necessários
command -v kubectl >/dev/null 2>&1 || { echo >&2 "kubectl cli não configurado. Saindo."; exit 1; }
command -v aws >/dev/null 2>&1 || { echo >&2 "aws cli não configurado. Saindo."; exit 1; }

# Verifica as variáveis de ambiente AWS
if [ -z "$AWS_ACCESS_KEY_ID" ]; then echo "AWS_ACCESS_KEY_ID não configurado."; exit 1; fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then echo "AWS_SECRET_ACCESS_KEY não configurado."; exit 1; fi
if [ -z "$S3_BUCKET" ]; then echo "S3_BUCKET não configurado."; exit 1; fi

# Localização da chave de criptografia
chave_criptografia="./chave.key"

# Define namespaces a serem excluídos
exclude_namespaces=("default" "another namespaces")

# Cria um diretório temporário para os backups
backup_dir=$(mktemp -d)
trap 'rm -rf -- "$backup_dir"' EXIT

# Obtém a lista de namespaces
namespaces=($(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'))
if [ ${#namespaces[@]} -eq 0 ]; then echo "Namespace nao encontrado. Saindo."; exit 1; fi

# Processa cada namespace
for namespace in "${namespaces[@]}"; do
    if [[ " ${exclude_namespaces[*]} " =~ " ${namespace} " ]]; then
        echo "Pulando namespace: $namespace"
        continue
    fi

    # Processa cada segredo no namespace
    secrets=($(kubectl get secrets -n "$namespace" -o jsonpath='{.items[*].metadata.name}'))
    for secret in "${secrets[@]}"; do
        currentDateTime=$(date +%d%m%Y%H%M%S)
        secret_file="$backup_dir/$secret-$namespace-$currentDateTime.json"
        kubectl get secrets "$secret" -n "$namespace" -o json > "$secret_file"

        # Criptografa o arquivo de segredo
        secret_file_enc="$secret_file.enc"
        openssl enc -aes-256-cbc -pbkdf2 -iter 10000 -salt -in "$secret_file" -out "$secret_file_enc" -pass file:"$chave_criptografia"

        # Envia o arquivo criptografado para o S3
        aws s3 cp "$secret_file_enc" "s3://$S3_BUCKET/$namespace/$secret_file_enc"
    done
done
