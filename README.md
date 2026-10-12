<p align="center">
  <img
    src="./assets/x.jpeg"
    alt="Banner do projeto"
    width="550"
    style="max-width: 90%; border-radius: 30px;"
  >
</p>

# IaC para EC2 e n8n

**Versão:** 1.0

Projeto simples para criar uma instância EC2 com Ubuntu Server 24.04 LTS e executar o n8n usando Docker Compose para provisionar um ambiente para criação de automaçÕes.

[![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white)](https://developer.hashicorp.com/terraform/docs)
[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white)](https://aws.amazon.com/)
[![Amazon EC2](https://img.shields.io/badge/Amazon-EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://documentation.ubuntu.com/release-notes/24.04/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/)
[![n8n](https://img.shields.io/badge/n8n-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)](https://docs.n8n.io/)

## Pré-requisitos

- Uma conta na AWS.
- Terraform CLI.
- AWS CLI configurada.
- Uma chave pública SSH.

Configure suas credenciais da AWS:

```bash
aws configure
aws sts get-caller-identity
```

## Configuração

Descubra seu IP público:

```bash
curl https://checkip.amazonaws.com
```

Crie o arquivo com suas configurações:

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Depois, edite `terraform/terraform.tfvars`:

```hcl
aws_region          = "us-east-1"
instance_type       = "t3.micro"
ssh_public_key_path = "~/.ssh/id_ed25519.pub"
allowed_ipv4_cidr   = "SEU_IP_PUBLICO/32"
```

O IP informado será o único autorizado a acessar o SSH na porta `22` e o n8n na porta `5678`.

## Executando

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Após a criação, veja o endereço do n8n:

```bash
terraform output -raw n8n_url
```

Para acessar a instância por SSH:

```bash
ssh ubuntu@$(terraform output -raw public_ip)
```

> [!WARNING]
> A instância EC2 pode gerar custos na sua conta AWS.

Quando terminar, remova os recursos:

```bash
terraform destroy
```

## Comandos do Terraform para entendimento

| Comando | Descrição |
| --- | --- |
| `terraform init` | Inicializa o projeto e instala os providers. |
| `terraform fmt` | Formata os arquivos Terraform. |
| `terraform validate` | Valida a sintaxe e a configuração. |
| `terraform plan` | Mostra o que será criado ou alterado. |
| `terraform apply` | Aplica as alterações na AWS. |
| `terraform output` | Exibe os valores de saída, como o IP e a URL do n8n. |
| `terraform plan -destroy` | Mostra o plano de remoção dos recursos. |
| `terraform destroy` | Remove os recursos criados pelo projeto. |
