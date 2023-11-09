import docker
import sys

client = docker.from_env()

container_name = sys.argv[1]

try:
    container_exists = client.containers.get(container_name)
    if(container_exists):
        print('Já existe um container com este nome, e está em execução')
except docker.errors.NotFound as ex:
    print(f'Não foi encontrado nenhum container com este nome. {ex}')
except ValueError:
    print("Error")