resource "aws_key_pair" "n8n" {
  key_name   = "n8n-key"
  public_key = file(pathexpand(var.ssh_public_key_path))

  tags = {
    Name = "n8n-key"
  }
}
