variable "aws_region" {
  description = "AWS region for provisioning resources"
  type        = string
  default     = "ap-south-1" # Mumbai region (or us-east-1)
}

variable "vpc_a_cidr" {
  description = "CIDR block for VPC-A (Requester)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_a_subnet_cidr" {
  description = "CIDR block for Subnet in VPC-A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_b_cidr" {
  description = "CIDR block for VPC-B (Accepter)"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_b_subnet_cidr" {
  description = "CIDR block for Subnet in VPC-B"
  type        = string
  default     = "10.1.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type for test servers"
  type        = string
  default     = "t2.micro"
}
