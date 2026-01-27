# Terraform AWS – Infraestrutura Elástica com Nginx

Projeto de **Infraestrutura como Código (IaC)** utilizando **Terraform** para provisionar uma infraestrutura **elástica** na **AWS**, simulando um cenário real de Cloud/DevOps.

---

## Descrição

A infraestrutura criada inclui:

- **VPC customizada**
- **Subnets públicas e privadas**
- **Security Groups** com separação por camadas
- **Application Load Balancer (ALB)**
- **Launch Template**
- **Auto Scaling Group (ASG)**
- **Instâncias EC2 Ubuntu** com **Nginx instalado automaticamente**
- **Escalabilidade horizontal** baseada em métricas de CPU (CloudWatch)

As instâncias EC2 **não são expostas diretamente à internet**, recebendo tráfego apenas através do **Load Balancer**.

---

## Funcionamento

- O **Launch Template** define o padrão das instâncias (AMI, tipo, bootstrap).
- O **Auto Scaling Group** cria ou remove instâncias conforme a carga.
- O **Application Load Balancer** distribui o tráfego entre instâncias saudáveis.
- O **CloudWatch** monitora a utilização de CPU para **scale-out** e **scale-in**.

---

## Tecnologias e Conceitos

- Terraform
- AWS (EC2, VPC, ALB, ASG, CloudWatch)
- Infraestrutura como Código (IaC)
- Elasticidade e Alta Disponibilidade
- Linux (Ubuntu)
- Nginx

---

## Autor

**Fabio Henrique Shreiner**  
Infraestrutura | Cloud | DevOps | SRE  

📍 Monte Azul Paulista – SP, Brasil  
📧 fshreiner21@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/fabio-shreiner)
