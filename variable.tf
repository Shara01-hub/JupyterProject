# variable for the VPC CIDR block
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

# variable for the public subnet az1a CIDR block
variable "public_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR block for the public subnet in availability zone 1a"
}

# variable for the public subnet az1b CIDR block
variable "public_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = "The CIDR block for the public subnet in availability zone 1b"
}

# variable for private app subnet 1a CIDR block
variable "private_app_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.3.0/24"
  description = "The CIDR block for the private app subnet in availability zone 1a"
}

# variable for private app subnet 1b CIDR block
variable "private_app_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.4.0/24"
  description = "The CIDR block for the private app subnet in availability zone 1b"
}

# variable for private DB subnet 1a CIDR block
variable "private_DB_app_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.5.0/24"
  description = "The CIDR block for the private database subnet in availability zone 1a"
}

# variable for private DB subnet 1b CIDR block
variable "private_DB_app_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.6.0/24"
  description = "The CIDR block for the private database subnet in availability zone 1b"
}

#variable for domain name
variable "domain_name" {
  type        = string
  default     = "cloudrainbowtester.com"
  description = "The domain name for my route53"

}

#variable for my ASG image_id
variable "ec2_ami_id" {
  type        = string
  default     = "ami-07a6f770277670015"
  description = "ami id for the ec2 instance"

}
