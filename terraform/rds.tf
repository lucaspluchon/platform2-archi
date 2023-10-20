resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t2.micro"
  name                 = "postgres"
  username             = "postgres"
  password             = "postgres"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
}
