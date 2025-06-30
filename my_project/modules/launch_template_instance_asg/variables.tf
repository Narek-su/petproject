variable "security_group_id" {
  type = string
}

variable "launch_template_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "scaling_size" {
  type = object({
    max_size         = number
    min_size         = number
    desired_capacity = number
  })
}

variable "asg_name" {
  type = string
}

variable "subnet" {
  type = list(string)
}

variable "target_group_arn" {
  type = list(string)
}
