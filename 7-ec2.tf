# resource "aws_instance" "web_server" {
#   ami                         = var.ami
#   associate_public_ip_address = true
#   instance_type               = var.instance_type
#   # key_name = 
#   vpc_security_group_ids = [aws_security_group.sg-ec2-lab.id]
#   subnet_id              = aws_subnet.public_subneta.id


#   user_data = file("user_data.sh")

#   tags = {
#     Name = "web-server"
#   }
# }