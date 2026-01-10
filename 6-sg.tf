
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