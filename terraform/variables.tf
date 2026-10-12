variable "aws_region" {
  description = "Região da AWS onde a infraestrutura será criada"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "ssh_public_key_path" {
  description = "Caminho da chave pública SSH"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "allowed_ipv4_cidr" {
  description = "Endereço IPv4 autorizado a acessar o SSH e o n8n, no formato CIDR"
  type        = string

  validation {
    condition = (
      can(cidrhost(var.allowed_ipv4_cidr, 0)) &&
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/32$", var.allowed_ipv4_cidr))
    )
    error_message = "Informe um endereço IPv4 válido terminado em /32, por exemplo: 203.0.113.10/32."
  }
}
