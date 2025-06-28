variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_name" {
  type = string
}

variable "subnet_count" {
  type = list(any)
}

variable "public_rt_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "igw_name" {
  type = string
}

locals {
  azs = data.aws_availability_zones.available.names
}