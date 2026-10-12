data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "n8n" {
  name        = "n8n-sg"
  description = "Firewall da instância do n8n"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "n8n-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.n8n.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.n8n.id
  cidr_ipv4         = var.allowed_ipv4_cidr
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "n8n" {
  security_group_id = aws_security_group.n8n.id
  cidr_ipv4         = var.allowed_ipv4_cidr
  from_port         = 5678
  to_port           = 5678
  ip_protocol       = "tcp"
}
