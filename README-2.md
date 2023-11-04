1. Execute o seguinte comando para construir a imagem do Docker: :white_check_mark:

```bash
# Na pasta do projeto, buildar a imagem

docker build -t my-health-check-app .
```



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



1. Faça login no Amazon ECR: :white_check_mark:

```bash
aws ecr get-login-password --region <sua-região> | docker login --username AWS --password-stdin <seu-id-da-conta>.dkr.ecr.<sua-região>.amazonaws.com
```

1. Crie um repositório no Amazon ECR: :white_check_mark:

```bash
aws ecr create-repository --repository-name my-health-check-app
```

1. Marque a imagem e faça o push para o repositório: :white_check_mark:

```docker
docker tag my-health-check-app:latest <seu-id-da-conta>.dkr.ecr.<sua-região>.amazonaws.com/my-health-check-app:latest

docker push <seu-id-da-conta>.dkr.ecr.<sua-região>.amazonaws.com/my-health-check-app:latest
```



**Criar um Serviço ECS**

Agora que você enviou a imagem do Docker para o Amazon ECR, você pode criar um serviço ECS para executar seu aplicativo.

1. No Console da AWS, vá para o serviço ECS.

2. Clique em "Clusters" e crie um novo cluster.

3. Crie uma definição de tarefa que use a imagem do contêiner do ECR que você enviou.

4. Crie um serviço e associe-o à definição de tarefa. Certifique-se de definir um equilibrador de carga (load balancer) se desejar.

   

   https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-ecs-ec2-v2.html

   

### Resumo dos Comandos

```bash
# Logar
aws ecr get-login-password --region sua-regiao | docker login --username AWS --password-stdin sua-conta-id.dkr.ecr.sua-regiao.amazonaws.com

# Criar repositorio ECR
aws ecr create-repository --repository-name my-health-check-app

# Na pasta do projeto, buildar a imagem
docker build -t my-health-check-app .

# taggeara imagem
docker tag my-health-check-app:latest <id-da-conta>.dkr.ecr.us-east-1.amazonaws.com/my-health-check-app:latest

# publicar no ECR
docker push <id-da-conta>.dkr.ecr.us-east-1.amazonaws.com/my-health-check-app:latest

# Instanciar CLuster com variável

# Registrar o task-definition OBS: Criar o arquivo task.json
aws ecs register-task-definition --cli-input-json file:///home/tec/Projects/health-check-api/fargate/task.json

# Criar o serviço no ECS
aws ecs create-service --cluster ecs-teste-fargate --service-name my-health-check-app-service --task-definition platform-health-check --desired-count 1 --launch-type FARGATE --network-configuration file:///home/tec/Projects/health-check-api/fargate/awsvpc.json

#ou
aws ecs create-service --cluster ecs-teste-ec2 --service-name my-health-check-app-service --task-definition platform-health-check --desired-count 1 --launch-type EC2

#ou
aws ecs create-service --cluster ecs-teste-fargate --service-name my-health-check-app-service --task-definition teste-task-definition --desired-count 1 --launch-type FARGATE --network-configuration file:///home/tec/Projects/health-check-api/fargate/awsvpc.json
```





<hr>


#### Testar o Health Check Endpoint

Depois que o serviço ECS estiver em execução, você pode acessar o endpoint de verificação de saúde em `http://<seu-load-balancer-URL>/health` para verificar se o aplicativo está funcionando corretamente. Certifique-se de ajustar as configurações de segurança, como grupos de segurança e permissões do IAM, conforme necessário.
