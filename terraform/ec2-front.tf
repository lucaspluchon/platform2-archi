resource "aws_instance" "front" {
  ami             = "ami-07823ef2a91f04b91"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "Front-end Instance"
  }

  user_data = <<-EOF
              #!/bin/bash

              exec > >(tee -a /home/ec2-user/user_data.log) 2>&1

              yum install -y git
              yum install -y nodejs
              git clone https://github.com/lucaspluchon/platform2-archi.git /home/ec2-user/app
              cd /home/ec2-user/app/front
              export REACT_APP_API_URL=http://${aws_instance.back.public_ip}/api/comments
              export PORT=80
              npm install
              npm start
              EOF
}

output "front_ip" {
  value = aws_instance.front.public_ip
}
