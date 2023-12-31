resource "aws_instance" "back" {
  ami             = "ami-07823ef2a91f04b91"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Back-end Instance"
  }

  user_data = <<-EOF
              #!/bin/bash

              exec > >(tee -a /home/ec2-user/user_data.log) 2>&1

              yum install -y git
              yum install -y nodejs
              git clone https://github.com/lucaspluchon/platform2-archi.git /home/ec2-user/app
              cd /home/ec2-user/app/back
              npm install
              export DB_HOST=${aws_db_instance.default.address}
              export DB_USER="postgres"
              export DB_PASS="postgres"
              export DB_NAME="postgres"
              export DB_PORT=5432
              export PORT=80
              npm start
              EOF

}

output "backend_ip" {
  value = aws_instance.back.public_ip
}

