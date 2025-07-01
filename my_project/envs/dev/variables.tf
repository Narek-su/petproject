#------------------------------------------------network------------------------------------------------------#
variable "vpc_name" {
  type    = string
  default = "my_vpc_aws"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_name" {
  type    = string
  default = "public_subnet_aws"
}

variable "subnet_count" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_rt_name" {
  type    = string
  default = "public_rt_aws"
}

variable "igw_name" {
  type    = string
  default = "my_igw_aws"
}

#----------------------------------------------sg names------------------------------------------------------#
variable "sg_name" {
  type = object({
    lb  = string
    ec2 = string
  })
  default = {
    lb  = "alb_sg_aws"
    ec2 = "ec2_sg_aws"
  }
}

#-----------------------------------------load balancer name------------------------------------------------#
variable "lb_name" {
  type    = string
  default = "my-lb-aws"
}

#-----------------------------------------load balancer type------------------------------------------------#
variable "lb_type" {
  type    = string
  default = "application"
}

#------------------------------------internet-facing or internal (for alb)----------------------------------#
variable "internal" {
  type    = bool
  default = false
}

#----------------------------------------target group name--------------------------------------------------#
variable "tg_name" {
  type    = string
  default = "instance-lb-tg"
}

variable "launch_template_name" {
  type    = string
  default = "ubuntu-t3micro-template"
}
#------------------------------------------instance name----------------------------------------------------#
variable "instance_name" {
  type    = string
  default = "web_petproject"
}

#--------------------------------------------asg name-------------------------------------------------------#
variable "asg_name" {
  type    = string
  default = "asg_aws"
}

#----------------------------------------asg scaling size---------------------------------------------------#
variable "scaling_size" {
  type = object({
    max_size         = number
    min_size         = number
    desired_capacity = number
  })
  default = {
    max_size         = 5
    min_size         = 2
    desired_capacity = 4
  }
}

#----------------------------------------------locals-------------------------------------------------------#
locals {
  common_tags = {
    env = "dev"
    by  = "terraform"
  }
}
