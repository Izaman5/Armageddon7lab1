
variable "aws_region" {
  description = "AWS Region for Project"
  type        = string
  default     = "ap-northeast-3"
}

variable "project_name" {
  description = "Project Name Echo Base"
  type        = string
  default     = "echobase"
}

variable "vpc_cidr" {
  description = "VPC CIDR (use 10.x.x.x/xx as instructed)."
  type        = string
  default     = "10.124.0.0/16" # TODO: student supplies
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.124.1.0/24", "10.124.2.0/24", "10.124.3.0/24"] # TODO: student supplies
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.124.11.0/24", "10.124.12.0/24", "10.124.13.0/24"] # TODO: student supplies
}

variable "azs" {
  description = "Availability Zones list (match count with subnets)."
  type        = list(string)
  default     = ["ap-northeast-3a", "ap-northeast-3b", "ap-northeast-3c"] # TODO: student supplies
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 app host."
  type        = string
  default     = "ami-00da6ca695594e43b" # TODO
}

variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "RDS engine."
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "labdb" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "password" # TODO: student supplies
}

variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "whatwouldyodado@gmail.com" # TODO: student supplies
}




# variable "aws_region" {
#   description = "AWS region"
#   type        = string
#   default     = "ap-northeast-3"

# }

# variable "instance_type" {
#   description = "instance size"
#   type        = string
#   default     = "t3.micro"
# }

# variable "ami" {
#   description = "ami type"
#   type        = string
#   default     = "ami-00da6ca695594e43b"
# }

# variable "db_password" {
#   description = "Database admin password"
#   type        = string
#   sensitive   = true
# }

# variable "db_username" {
#   description = "Database user name"
#   type        = string
# }
# ##############CREATE DBase subnet Group#####################
# # variable "private_subnets" {
# #   description = "List of private subnet IDs for the RDS DB subnet group"
# #   type        = list(string)
# #   default     = [ "subnet-0cb560d458c65594f", "subnet-01f2d7d13787c0105", "subnet-0ed96e40afe77a3e0"] # Replace with your actual subnet IDs
# # }
# variable "private_subnets" {
#   description = "List of private subnet IDs for the RDS DB subnet group"
#   type        = list(string)
#   default     = ["subnet-privatea", "subnet-privateb", "subnet-privatec"] # Replace with your actual subnet IDs
# }

# variable "rds_security_group" {
#   description = "List of security group IDs to associate with the RDS instance"
#   type        = list(string)
#   default     = ["sg-rds-lab"] # Replace with your actual security group ID
# }

# # output "subnet_idsa" {
# #   description = "Private subnet A"
# #   value       = aws_subnet.private_subneta.id
# # }
# # output "subnet_idsb" {
# #   description = "Private subnet C"
# #   value       = aws_subnet.private_subnetb.id
# # }
# # output "subnet_idsc" {
# #   description = "Private subnet C"
# #   value       = aws_subnet.private_subnetc.id
# # }
# ###########INCREASE VARS########