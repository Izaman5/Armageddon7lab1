# Explanation: This is the holocron of state—your relational data lives here, not on the EC2.
resource "aws_db_instance" "echobase_rds01" {
  identifier             = "${local.name_prefix}-rds01"
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.echobase_rds_subnet_group01.name
  vpc_security_group_ids = [aws_security_group.echobase_rds_sg01.id]

  publicly_accessible    = false
  skip_final_snapshot    = true

  # TODO: student sets multi_az / backups / monitoring as stretch goals

  tags = {
    Name = "${local.name_prefix}-rds01"
  }
}
###################CREATE DBASE##############################

# resource "aws_db_instance" "labdb" {
#   allocated_storage    = 10
#   db_name              = "labdb"
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   username             = "user"
#   password             = "password"
#   parameter_group_name = "default.mysql8.0"
#   skip_final_snapshot  = true
#   publicly_accessible  = false
#   db_subnet_group_name   = aws_db_subnet_group.dbase-subnet.name
#  vpc_security_group_ids = [aws_security_group.sg-rds-lab.id]
# }



  # username             = var.db_username
  # password             = data.aws_secretsmanager_secret_version.db_password_version.secret_string
# module "secrets_manager" {
#   source      = "./secrets_manager"
#   db_password = var.db_password
# }

# module "rds_database" {
#   source      = "./rds"
#   db_username = var.db_username
# }
