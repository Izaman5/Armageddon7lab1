# 

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

# VPC resource
# # This creates the virtual private cloud
# resource "aws_vpc" "main" {
#   cidr_block           = "10.124.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   tags = {
#     Name = "main_vpc"
#   }
# }