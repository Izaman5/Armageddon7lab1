resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id

  }


  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private_subneta" {
  subnet_id      = aws_subnet.private_subneta.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnetb" {
  subnet_id      = aws_subnet.private_subnetb.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_subnetc" {
  subnet_id      = aws_subnet.private_subnetc.id
  route_table_id = aws_route_table.private.id
}


#public

resource "aws_route_table_association" "public_subneta" {
  subnet_id      = aws_subnet.public_subneta.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnetb" {
  subnet_id      = aws_subnet.public_subnetb.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnetc" {
  subnet_id      = aws_subnet.public_subnetc.id
  route_table_id = aws_route_table.public.id
}