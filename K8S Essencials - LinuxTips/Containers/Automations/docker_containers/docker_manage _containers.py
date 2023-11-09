import docker

client = docker.from_env()


container = client.containers.get('28628838f22b')

print(container.attrs['Config']['Image'])