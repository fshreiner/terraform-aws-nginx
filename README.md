# Terraform AWS – EC2 com Nginx em VPC customizada

Projeto de **Infraestrutura como Código (IaC)** utilizando **Terraform** para provisionar uma infraestrutura básica na **AWS**, com foco em **baixo custo**, **boas práticas** e **uso em DevOps/Cloud**.

O projeto cria uma **VPC**, uma **subnet pública**, configura os **Security Groups** e provisiona uma **instância EC2 Ubuntu** com **Nginx instalado automaticamente**.

---

## Arquitetura

VPC (10.0.0.0/16)
├─ Subnet Pública (10.0.1.0/24)
│ ├─ EC2 Ubuntu 22.04
│ │ └─ Nginx (porta 80)
│ └─ Internet Gateway
└─ Security Group
├─ Inbound 22 (SSH) – IP restrito
└─ Inbound 80 (HTTP) – Público

---

## 🛠️ Tecnologias Utilizadas

- Terraform
- AWS Provider
- AWS EC2
- AWS VPC
- Ubuntu Server 22.04
- Nginx
- Linux

---

## 📁 Estrutura do Projeto

terraform-aws-nginx/
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── security_group.tf
├── ec2.tf
├── outputs.tf
└── README.md

---

## 📋 Pré-requisitos

- Conta na AWS
- Terraform instalado
- AWS CLI configurada **ou** variáveis de ambiente
- Access Key e Secret Key da AWS

---

## 🔐 Configuração de Credenciais (Recomendado)

Configure as credenciais via variáveis de ambiente:

```bash
export AWS_ACCESS_KEY_ID="SUA_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="SUA_SECRET_KEY"
```

---

## Variáveis utilizadas

| Variável      | Descrição             | Exemplo         |
| ------------- | --------------------- | --------------- |
| aws_region    | Região AWS            | us-east-1       |
| project_name  | Nome do projeto       | terraform-nginx |
| instance_type | Tipo da instância EC2 | t3.micro        |
| my_ip         | IP permitido para SSH | 187.xxx.xxx.xxx |


## Como Executar
```bash
terraform init
terraform plan
terraform apply
```

## Acessar a Aplicação

Após o terraform apply, os outputs serão exibidos:

public_ip = "54.xxx.xxx.xxx"
url       = "http://54.xxx.xxx.xxx"

Podemos acessar a instância diretamente pela URL retornada.

## Destruir a Infraestrutura
Após as validações, é recomendável destruir a infraestrutura para evitar custos desnecessários no provider:
```bash
terraform destroy
```


## Autor

# Fabio Henrique Shreiner

**Infra & Operações | Cloud | DevOps | SRE**  
Monte Azul Paulista, São Paulo, Brasil | (17) 99616-5523 | fshreiner21@gmail.com | https://www.linkedin.com/in/fabio-shreiner/