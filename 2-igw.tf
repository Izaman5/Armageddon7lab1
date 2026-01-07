# Explanation: Even Wookiees need to reach the wider galaxy—IGW is your door to the public internet.
resource "aws_internet_gateway" "echobase_igw01" {
  vpc_id = aws_vpc.echobase_vpc01.id

  tags = {
    Name = "${local.name_prefix}-igw01"
  }
}


# Explanation: Chewbacca wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "echobase_nat_eip01" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip01"
  }
}



# # Explanation: Even Wookiees need to reach the wider galaxy—IGW is your door to the public internet.
# resource "aws_internet_gateway" "chewbacca_igw01" {
#   vpc_id = aws_vpc.echobase_vpc01.id

#   tags = {
#     Name = "${local.name_prefix}-igw01"
#   }
# }

# # resource "aws_internet_gateway" "igw" {
# #   vpc_id = aws_vpc.main.id

# #   tags = {
# #     Name    = "db_ig"
# #     Service = "db_ig"

# #   }
# # }