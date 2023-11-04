# ecs-compose
Demo de Ecs compose-x

## ecs-compose install

Instalar o ecs-compose-x:

```sh
python3 -m venv ~/venv
source ~/venv/bin/activate
pip install pip -U
pip install ecs-composex
pip install "ecs-composex[ecrscan]" # opcional
```

## Configuração da Conta AWS

Conforme a [documentação](https://docs.compose-x.io/requisites.html#aws-account-configuration), obter variáveis de ambiente do AWS CLI (AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY_ID, e AWS_SESSION_TOKEN) e executar:

```sh
ecs-compose-x init
```

Saída do console será como:

```
2023-11-03 19:53:15 [    INFO] ECS Setting awsvpcTrunking set to 'enabled'
2023-11-03 19:53:15 [    INFO] ECS Setting serviceLongArnFormat set to 'enabled'
2023-11-03 19:53:16 [    INFO] ECS Setting taskLongArnFormat set to 'enabled'
2023-11-03 19:53:16 [    INFO] ECS Setting containerInstanceLongArnFormat set to 'enabled'
2023-11-03 19:53:16 [    INFO] ECS Setting containerInsights set to 'enabled'
2023-11-03 19:53:18 [    INFO] Bucket ecs-composex-xxxxxxxxxx-us-east-1 successfully created.
```

## Arquivos de deployment

* **docker-compose.yaml**: arquivo de deployment comum (descreve serviços, volumes, networks, etc).
* **docker-compose.override.yaml**: arquivo de deployment específico para o ambiente de desenvolvimento local (sobrescreve e completa configurações).
* **aws-compose-x.yaml**: arquivo de deployment específico para o ambiente ECS (sobrescreve e completa configurações).

## Executando no ECS

ecs-compose-x up -f docker-compose.yaml -f aws-compose-x.yaml -n frontend-app
