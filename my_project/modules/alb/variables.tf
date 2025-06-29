variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

#-----------------------------------------load balancer name------------------------------------------------#
variable "lb_name" {
  type = string
}

#-----------------------------------------load balancer type------------------------------------------------#
variable "lb_type" {
  type = string
}

#-------------------------------------Internet-facing or Internal-------------------------------------------#
variable "internal" {
  type = bool
}

#-----------------------------------------target group name-------------------------------------------------#
variable "tg_name" {
  type = string
}

#--------------------------------------------vpc cidr-------------------------------------------------------#
variable "vpc_cidr" {
  type = string
}

#-------------------------------------------common tags-----------------------------------------------------#
variable "tags" {
  type = map(string)
}