https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/


### Tabela com o valor que vai no apiVersion, de acordo com cada recurso do K8S

- **POD**: v1
- **Deployment**: apps/v1
- **Service**:v1


Os Secrets podem ser criados de forma independente dos Pods que os consomem. Isso reduz o risco de que o Secret e seus dados sejam expostos durante o processo de criação, visualização e edição ou atualização de Pods.


```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  ROOT_PASSWORD: Senha123
  MYSQL_DATABASE: meubanco

```

### Exemplo de secret mais complexo

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
  labels:
    app: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:5.7
          ports:
            - containerPort: 3306
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: my-secret
                  key: ROOT_PASSWORD
                  
            - name: MYSQL_DATABASE
              valueFrom:
                secretKeyRef:
                  name: my-secret
                  key: MYSQL_DATABASE
```