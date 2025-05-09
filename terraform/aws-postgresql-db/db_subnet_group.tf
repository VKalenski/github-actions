# Създаване на DB Subnet Group с една подмрежа
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.my_public_subnet.id]

  tags = {
    Name = "my-db-subnet-group"
  }
}
