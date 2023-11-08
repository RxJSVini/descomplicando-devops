import docker
import sys

client = docker.from_env()

container_name = sys.argv[1]
container_image_name = sys.argv[2]
container_ports = {f'{sys.argv[3]}/tcp': sys.argv[3]}


try:

    container = client.containers.run(
            image=container_image_name, 
            name=container_name, 
            ports=container_ports, 
            detach=True
            )
        
except ValueError:
    print("Error")