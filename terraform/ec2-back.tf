resource "aws_instance" "back" {
  ami             = "ami-07823ef2a91f04b91"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Back-end Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum install nodejs14
              git clone git@github.com:lucaspluchon/platform2-archi.git /app
              cd /app
              npm install
              export DB_HOST=${aws_db_instance.default.address}
              export DB_USER="postgres"
              export DB_PASS="postgres"
              export DB_NAME="postgres"
              export DB_PORT=5432
              npm start
              EOF
}
