resource "aws_db_instance" "postgres" {
  identifier              = "my-postgres-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = "db.t2.micro"
  username                = var.db_username
  password                = random_password.rds_password.result
  db_name                 = var.db_name
  port                    = 5432
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name
  skip_final_snapshot     = true
  storage_type            = "gp2"
  multi_az                = false
}
