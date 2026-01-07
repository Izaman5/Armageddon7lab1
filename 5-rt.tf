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
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat.id

#   }


#   tags = {
#     Name = "private"
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id

#   }

#   tags = {
#     Name = "public"
#   }
# }

# resource "aws_route_table_association" "private_subneta" {
#   subnet_id      = aws_subnet.private_subneta.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private_subnetb" {
#   subnet_id      = aws_subnet.private_subnetb.id
#   route_table_id = aws_route_table.private.id
# }
# resource "aws_route_table_association" "private_subnetc" {
#   subnet_id      = aws_subnet.private_subnetc.id
#   route_table_id = aws_route_table.private.id
# }


# #public

# resource "aws_route_table_association" "public_subneta" {
#   subnet_id      = aws_subnet.public_subneta.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "public_subnetb" {
#   subnet_id      = aws_subnet.public_subnetb.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "public_subnetc" {
#   subnet_id      = aws_subnet.public_subnetc.id
#   route_table_id = aws_route_table.public.id
# }