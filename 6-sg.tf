############################################
# Security Groups (EC2 + RDS)
############################################

# Explanation: EC2 SG is Chewbacca’s bodyguard—only let in what you mean to.
resource "aws_security_group" "echobase_ec2_sg01" {
  name        = "${local.name_prefix}-ec2-sg01"
  description = "EC2 app security group"
  vpc_id      = aws_vpc.echobase_vpc01.id

  # TODO: student adds inbound rules (HTTP 80, SSH 22 from their IP)
  # TODO: student ensures outbound allows DB port to RDS SG (or allow all outbound)

  tags = {
    Name = "${local.name_prefix}-ec2-sg01"
  }
}


resource "aws_vpc_security_group_ingress_rule" "echobase_ec2_http_rule" {
  security_group_id = aws_security_group.echobase_ec2_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "echobase_ec2_ssh_rule" {
  security_group_id = aws_security_group.echobase_ec2_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "echobase_ec2_egress_rule" {
  security_group_id = aws_security_group.echobase_ec2_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}

# # Explanation: RDS SG is the Rebel vault—only the app server gets a keycard.
# resource "aws_security_group" "echobase_rds_sg01" {
#   name        = "${local.name_prefix}-rds-sg01"
#   description = "RDS security group"
#   vpc_id      = aws_vpc.echobase_vpc01.id
#     tags = {
#     Name = "${local.name_prefix}-rds-sg01"
#   }
# }


  # TODO: student adds inbound MySQL 3306 from aws_security_group.chewbacca_ec2_sg01.id
resource "aws_security_group" "echobase_rds_sg01" {
  name        = "${local.name_prefix}-rds-sg01"
  vpc_id      = aws_vpc.echobase_vpc01.id

  tags = {
    Name = "${local.name_prefix}-rds-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "echobase_ec2tords_rule" {
  security_group_id = aws_security_group.echobase_rds_sg01.id

  referenced_security_group_id = aws_security_group.echobase_ec2_sg01.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"

  description = "Allow traffic to web tier instances"

  tags = merge(

    {
      Name = "${local.name_prefix}-echobase_ec2tords_rule"
    }
  )
}


# from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
    
#     # Reference the ID of the other security group here
#    referenced_security_group_id = aws_security_group.echobase_ec2_sg01.id
#     description     = "Allow HTTP traffic from the ELB security group"
#   }
#     }


############################################
# RDS Subnet Group
############################################

# Explanation: RDS hides in private subnets like the Rebel base on Hoth—cold, quiet, and not public.
resource "aws_db_subnet_group" "echobase_rds_subnet_group01" {
  name       = "${local.name_prefix}-rds-subnet-group01"
  subnet_ids = aws_subnet.echobase_private_subnets[*].id

  tags = {
    Name = "${local.name_prefix}-rds-subnet-group01"
  }
}

# # for web server only 
# resource "aws_security_group" "sg-ec2-lab" {
#   name        = "EC2 Security Group"
#   description = "Allow HTTP and SSH for web server"
#   vpc_id      = aws_vpc.main.id



#   tags = {
#     Name = "sg-ec2-lab"
#   }
# }
# resource "aws_vpc_security_group_ingress_rule" "http" {
#   security_group_id = aws_security_group.sg-ec2-lab.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "ssh" {
#   security_group_id = aws_security_group.sg-ec2-lab.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

# resource "aws_vpc_security_group_egress_rule" "egress" {
#   security_group_id = aws_security_group.sg-ec2-lab.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"

# }


# resource "aws_security_group" "sg-rds-lab" {
#   name        = "DB Security Group"
#   description = "Allow TCP Only"
#   vpc_id      = aws_vpc.main.id



#   tags = {
#     Name = "sg-rds-lab"
#   }
# }



# # Define the ingress rule in the destination SG to allow traffic from the source SG
# resource "aws_vpc_security_group_ingress_rule" "app_to_db_rule" {

#   description                  = "Allow app servers to access DB on port 3306"
#   from_port                    = 3306
#   to_port                      = 3306
#   ip_protocol                  = "tcp"
#   security_group_id            = aws_security_group.sg-rds-lab.id
#   referenced_security_group_id = aws_security_group.sg-ec2-lab.id
# }