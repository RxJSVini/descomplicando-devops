# POD
Um pod é a menor e mais básica unidade de implantação que você pode criar e gerenciar. É um wrapper que contém um ou mais contêineres (geralmente Docker), os quais compartilham recursos como armazenamento e rede. Cada pod é executado em um nó do cluster do Kubernetes, que pode ser uma máquina física ou virtual.

Os contêineres dentro de um mesmo pod têm o seguinte em comum:

Endereço IP: Todos os contêineres no pod compartilham um único endereço IP e podem se comunicar entre si através de localhost.
Volumes: Os contêineres podem compartilhar dados usando volumes que são definidos no nível do pod.
Informações de ciclo de vida: O estado do pod abrange todos os contêineres dentro dele. Se o pod inicia ou termina, isso afeta todos os contêineres simultaneamente.
O pod é fundamental no Kubernetes porque ele é a unidade de escala, ou seja, quando você escala sua aplicação, você está aumentando ou diminuindo o número de pods.