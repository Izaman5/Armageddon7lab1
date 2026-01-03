# module "secrets_manager" {
#   source      = "./secrets_manager"
#   db_password = var.db_password
# }

# module "rds_database" {
#   source      = "./rds"
#   db_username = var.db_username
# }



# resource "aws_secretsmanager_secret" "db_password" {
#   name = "dev/mysql/password"
# }

# resource "aws_secretsmanager_secret_version" "db_password_version" {
#   secret_id     = aws_secretsmanager_secret.db_password.id
#   secret_string = var.db_password
# }
# resource "aws_db_subnet_group" "db-subnet-group" {
#   name       = "db-subnet-group"
#   subnet_ids = var.private_subnets

#   tags = {
#     Name = "DB-subnet-group"
#   }
# }

# resource "aws_db_instance" "workingdb" {
#   allocated_storage    = 10
#   db_name              = "mydb"
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   username             = "user"
#   password             = "password"
#   parameter_group_name = "default.mysql8.0"
#   skip_final_snapshot  = true
#   publicly_accessible  = false
#   db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
#  vpc_security_group_ids = [aws_security_group.sg-rds-lab.id,]
# }



  # username             = var.db_username
  # password             = data.aws_secretsmanager_secret_version.db_password_version.secret_string
