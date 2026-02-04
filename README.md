# Terraform AWS – Infraestrutura Elástica com Nginx

Projeto de **Infraestrutura como Código (IaC)** utilizando **Terraform** para provisionar uma infraestrutura **elástica e altamente disponível** na **AWS**, com organização em **stacks** e **módulos reutilizáveis**, simulando um cenário real de Cloud/DevOps.

---

## Visão Geral da Arquitetura

A infraestrutura é organizada em **stacks independentes**, seguindo boas práticas de isolamento e responsabilidade:

- **Stack Network**
  - VPC customizada
  - Subnets públicas e privadas
  - Internet Gateway
  - NAT Gateway
  - Route Tables

- **Stack Compute**
  - Security Groups
  - Application Load Balancer (ALB)
  - Launch Template
  - Auto Scaling Group (ASG)
  - Instâncias EC2 Ubuntu com Nginx

As instâncias EC2 ficam em **subnets privadas**, sem acesso direto à internet, recebendo tráfego exclusivamente através do **Application Load Balancer**.

---

## Principais Funcionalidades

- Escalabilidade horizontal automática (**scale-out / scale-in**) baseada em métricas de CPU
- Alta disponibilidade com múltiplas Availability Zones
- Separação clara entre **network** e **compute**
- Reutilização de código com **módulos Terraform**
- Infraestrutura preparada para múltiplos ambientes

---

## Tecnologias Utilizadas

- Terraform
- AWS (VPC, EC2, ALB, Auto Scaling, CloudWatch)
- Linux (Ubuntu)
- Nginx
- Conceitos de Cloud Computing, IaC e DevOps

---

## Objetivo do Projeto

Projeto desenvolvido com foco em **aprendizado prático**, **transição de carreira** e **demonstração de competências em Cloud Computing e Terraform**, seguindo padrões próximos aos utilizados em ambientes corporativos.

---

## Autor

**Fabio Henrique Shreiner**  
Infraestrutura | Cloud | DevOps  

📍 Monte Azul Paulista – SP, Brasil  
📧 fshreiner21@gmail.com  
🔗 https://www.linkedin.com/in/fabio-shreiner