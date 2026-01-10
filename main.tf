############################################
# Locals (naming convention: echobase-*)
############################################

locals {
  name_prefix = var.project_name
}

############################################
# VPC + Internet Gateway
############################################

# Explanation: Chewbacca needs a hyperlane—this VPC is the Millennium Falcon’s flight corridor.
resource "aws_vpc" "echobase_vpc01" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc01"
  }
}

# Explanation: Even Wookiees need to reach the wider galaxy—IGW is your door to the public internet.
resource "aws_internet_gateway" "echobase_igw01" {
  vpc_id = aws_vpc.echobase_vpc01.id

  tags = {
    Name = "${local.name_prefix}-igw01"
  }
}

############################################
# Subnets (Public + Private)
############################################
# Explanation: Public subnets are like docking bays—ships can land directly from space (internet).
resource "aws_subnet" "echobase_public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.echobase_vpc01.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-subnet0${count.index + 1}"
  }
}

# Explanation: Private subnets are the hidden Rebel base—no direct access from the internet.
resource "aws_subnet" "echobase_private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.echobase_vpc01.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${local.name_prefix}-private-subnet0${count.index + 1}"
  }
}

############################################
# NAT Gateway + EIP
############################################
# Explanation: Chewbacca wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "echobase_nat_eip01" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip01"
  }
}

# Explanation: NAT is Chewbacca’s smuggler tunnel—private subnets can reach out without being seen.
resource "aws_nat_gateway" "echobase_nat01" {
  allocation_id = aws_eip.echobase_nat_eip01.id
  subnet_id     = aws_subnet.echobase_public_subnets[0].id # NAT in a public subnet

  tags = {
    Name = "${local.name_prefix}-nat01"
  }

  depends_on = [aws_internet_gateway.echobase_igw01]
}

############################################
# Routing (Public + Private Route Tables)
############################################

# Explanation: Public route table = “open lanes” to the galaxy via IGW.
resource "aws_route_table" "echobase_public_rt01" {
  vpc_id = aws_vpc.echobase_vpc01.id

  tags = {
    Name = "${local.name_prefix}-public-rt01"
  }
}

# Explanation: This route is the Kessel Run—0.0.0.0/0 goes out the IGW.
resource "aws_route" "echobase_public_default_route" {
  route_table_id         = aws_route_table.echobase_public_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.echobase_igw01.id
}

# Explanation: Attach public subnets to the “public lanes.”
resource "aws_route_table_association" "echobase_public_rta" {
  count          = length(aws_subnet.echobase_public_subnets)
  subnet_id      = aws_subnet.echobase_public_subnets[count.index].id
  route_table_id = aws_route_table.echobase_public_rt01.id
}

# Explanation: Private route table = “stay hidden, but still ship supplies.”
resource "aws_route_table" "echobase_private_rt01" {
  vpc_id = aws_vpc.echobase_vpc01.id

  tags = {
    Name = "${local.name_prefix}-private-rt01"
  }
}

# Explanation: Private subnets route outbound internet via NAT (Chewbacca-approved stealth).
resource "aws_route" "echobase_private_default_route" {
  route_table_id         = aws_route_table.echobase_private_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.echobase_nat01.id
}

# Explanation: Attach private subnets to the “stealth lanes.”
resource "aws_route_table_association" "echobase_private_rta" {
  count          = length(aws_subnet.echobase_private_subnets)
  subnet_id      = aws_subnet.echobase_private_subnets[count.index].id
  route_table_id = aws_route_table.echobase_private_rt01.id
}

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
