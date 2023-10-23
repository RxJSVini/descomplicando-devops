import docker

client = docker.from_env()


containers = client.containers.list()
#Listando containers
for container in containers:
    print(container)
    