


variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-3"

}

variable "instance_type" {
  description = "instance size"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "ami type"
  type        = string
  default     = "ami-00da6ca695594e43b"
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Database user name"
  type        = string
}

# variable "private_subnets" {
#   description = "List of private subnet IDs for the RDS DB subnet group"
#   type        = list(string)
#   default     = [ "subnet-0c88b295d3dcb6896", "subnet-0f64852951816f7e5", "subnet-0ed96e40afe77a3e0"] # Replace with your actual subnet IDs
# }


variable "rds_security_group" {
  description = "List of security group IDs to associate with the RDS instance"
  type        = list(string)
  default     = ["sg-rds-lab"] # Replace with your actual security group ID
}

output "subnet_idsa" {
  description = "Private subnet A"
  value       = aws_subnet.private_subneta.id
}
output "subnet_idsb" {
  description = "Private subnet C"
  value       = aws_subnet.private_subnetb.id
}
output "subnet_idsc" {
  description = "Private subnet C"
  value       = aws_subnet.private_subnetc.id
}