# Explanation: Chewbacca wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "echobse_nat_eip01" {
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

# resource "aws_eip" "nat" {


#   tags = {
#     Name = "nat"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_subneta.id

#   tags = {
#     Name = "nat"
#   }

#   depends_on = [aws_internet_gateway.igw]
# }