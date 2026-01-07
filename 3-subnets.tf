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


# #Public Subnets A, B, C

# resource "aws_subnet" "public_subneta" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.1.0/24"
#   availability_zone       = "ap-northeast-3a"
#   map_public_ip_on_launch = true
#  # subnet_id               = "subnet-publica"
#   tags = {
#     Name    = "public_access_subneta"
#     Service = "public access"
#   }
# }
# resource "aws_subnet" "public_subnetb" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.2.0/24"
#   availability_zone       = "ap-northeast-3b"
#   map_public_ip_on_launch = true
 
# #  id                      = "subnet-publicb"
#   tags = {
#     Name    = "public_access_subnetb"
#     Service = "public access"
#   }
# }
# resource "aws_subnet" "public_subnetc" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.3.0/24"
#   availability_zone       = "ap-northeast-3c"
#   map_public_ip_on_launch = true
#  #  id                      = "subnet-publicc"
#   tags = {
#     Name    = "public_access_subnetc"
#     Service = "public access"
#   }
# }


# #Private Subnets A, B, C
# resource "aws_subnet" "private_subneta" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.11.0/24"
#   availability_zone       = "ap-northeast-3a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name    = "private_dbase_subneta"
#     Service = "private database"
#   }
# }
# resource "aws_subnet" "private_subnetb" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.12.0/24"
#   availability_zone       = "ap-northeast-3b"
#   map_public_ip_on_launch = true
#   tags = {
#     Name    = "private_dbase_subnetb"
#     Service = "private database"
#   }
# }

# resource "aws_subnet" "private_subnetc" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.124.13.0/24"
#   availability_zone       = "ap-northeast-3c"
#   map_public_ip_on_launch = true
#   tags = {
#     Name    = "private_dbase_subnetc"
#     Service = "private database"
#   }
# }

# # resource "aws_ec2_subnet_cidr_reservation" "private-subnetc-id" {
# #   cidr_block       = "10.124.13.0/24"
# #   reservation_type = "prefix"
# #   subnet_id        = aws_subnet.private-subnetc.id
# # }
# ##############CREATE DBase subnet Group#####################
# resource "aws_db_subnet_group" "dbase-subnet" {
#   name       = "my-db-subnet-group"
#   subnet_ids = [aws_subnet.private_subneta.id,aws_subnet.private_subnetb.id,aws_subnet.private_subnetc.id] # List of your private subnet IDs
#   tags = {
#     Name = "My DB subnet group"
#   }
# }