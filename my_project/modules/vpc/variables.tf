variable "vpc_name" {
  type    = string
  default = "my_vpc_aws"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}


variable "public_subnet" {
  type    = string
  default = "public_subnet_aws"
}


variable "subnet_count" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_rt" {
  type    = string
  default = "public_rt_aws"
}


locals {
  azs = data.aws_availability_zones.available.names
}

locals {
  common_tags = {
    env = "prod"
    by  = "terraform"
  }
}


variable "igw" {
  type    = string
  default = "my_igw_aws"
}
