output "public_ip" {
  description = "Endereço IPv4 público da instância EC2"
  value       = aws_instance.web.public_ip
}

output "n8n_url" {
  description = "URL para acessar o n8n"
  value       = "http://${aws_instance.web.public_ip}:5678"
}
