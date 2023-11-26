### Introdução ao Persistente Volume

Acesse: 
```href
https://kubernetes.io/pt-br/docs/concepts/storage/persistent-volumes/

```
**O gerenciamento de armazenamento é uma questão bem diferente do gerenciamento de instancias computacionais. O subsistema persistentVolume proê uma API para usuarios e administradores que mostra de forma detalhada de como o armazenamento é provido, e como ele é consumido. Para isso, o K8S possui duas novas apis. PersistentVolume e PersistentVolumeClaim**



Exemplo de pod com volume:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pv-recycler
  namespace: default
spec:
  restartPolicy: Never
  volumes:
  - name: vol
    hostPath:
      path: /any/path/it/will/be/replaced
  containers:
  - name: pv-recycler
    image: "registry.k8s.io/busybox"
    command: ["/bin/sh", "-c", "test -e /scrub && rm -rf /scrub/..?* /scrub/.[!.]* /scrub/*  && test -z \"$(ls -A /scrub)\" || exit 1"]
    volumeMounts:
    - name: vol
      mountPath: /scrub
```
### Configurando arquivo yaml  para criar um MySQL com persistentVolume - Local


```yaml
    apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.6
        name: mysql
        env:
          # Use secret in real usage
        - name: MYSQL_ROOT_PASSWORD
          value: Senha123
        - name: MYSQL_DATABASE
          value: meubanco
        ports:
        - containerPort: 3306
          name: mysql
        
        volumeMounts:
        - name: local
          mountPath: /var/lib/mysql
      volumes:
      - name: local
        hostPath:
          path: /meubanco/
```


```SQL
CREATE TABLE mensagens (
    id int,
    nome varchar(50),
    mensagem varchar(100)
);

INSERT INTO mensagens (id,nome,mensagem) VALUES (1, 'Carlos da Silva', 'Hello World!!');

SELECT * FROM mensagens
```


### Mais detalhes para o PV

// Temos que ter muito cuidado nas configurações de storage, uma vez que podemos impactar todo o nosso cluster

```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: local
      labels:
        type: local
    spec:
        storageClassName: manual
        capacity:
          storage: 100Mi
        accessModes:
            - ReadWriteOnce
    hostPah: /meubanco/
```

### Outro exemplo de pv


```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: local
      labels:
        type: local
    spec:
        storageClassName: manual
        accessModes:
            - ReadWriteOnce
        resource:
          requests:
            storage: 100Mi

```



### Configurando arquivo yaml  para criar um MySQL com persistentVolume - Em nuvem
```yaml
    apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: mysql:5.6
        name: mysql
        env:
          # Use secret in real usage
        - name: MYSQL_ROOT_PASSWORD
          value: Senha123
        - name: MYSQL_DATABASE
          value: meubanco
        ports:
        - containerPort: 3306
          name: mysql
        
        volumeMounts:
        - name: local
          mountPath: /var/lib/mysql
      volumes:
      - name: lpvc-gcp
        persistentVolumeClaim:
            claiName: pvc-gcp
```


### Usando NFS(Cloud FireStore Server)

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: fileserver
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteMany
  nfs:
    path: /dados
    server: 10.111.75.10

```

---
```yaml
    apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
        name: fileserver
        spec:
        accessModes:
        - ReadWriteMany
        storageClassName: ""
        volumeName: fileserver
        resources:
            requests:
            storage: 10Gi

```
---
```yaml
apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: httpd
    spec:
    replicas: 6
    selector:
        matchLabels:
        app: httpd
    template:
        metadata:
        labels:
            app: httpd
        spec:
        containers:
        - image: httpd:latest
            name: httpd
            ports:
            - containerPort: 80
            name: httpd
            
            volumeMounts:
            - name: fileserver
            mountPath: /usr/local/apache2/htdocs/
        volumes:
        - name: fileserver
            persistentVolumeClaim:
            claimName: fileserver
```



