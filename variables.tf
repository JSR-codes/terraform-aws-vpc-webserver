variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used to tag all resources"
  type        = string
  default     = "tf-vpc-webserver"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet (reserved for future use, e.g. a database)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for both subnets"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type for the web server"
  type        = string
  default     = "t2.micro" # free-tier eligible
}

variable "key_name" {
  description = "Name of an EXISTING EC2 key pair in your AWS account, used for SSH access"
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR form (e.g. 203.0.113.5/32), used to restrict SSH access. Find yours at https://checkip.amazonaws.com"
  type        = string
}
