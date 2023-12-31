resource "aws_db_instance" "default" {
  allocated_storage    = 20
  max_allocated_storage = 100
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  db_name              = "postgres"
  username             = "postgres"
  password             = "postgres"
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  publicly_accessible  = true
  multi_az             = true
}

output "db_instance_address" {
  value = aws_db_instance.default.address
}
