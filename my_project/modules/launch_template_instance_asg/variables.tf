variable "security_group_id" {
  type = string
}

variable "subnet" {
  type = list(string)
}

variable "target_group_arn" {
  type = list(string)
}

variable "launch_template_name" {
  type = string
}

variable "ami_id" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "petproject-key"
}

variable "cpu_credits" {
  type    = string
  default = "standard"
}

variable "instance_initiated_shutdown_behavior" {
  type    = string
  default = "terminate"
}

variable "device_name" {
  type    = string
  default = "/dev/sdf"
}

variable "ebs" {
  type = object({
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
  })

  default = {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

variable "metadata_options" {
  type = object({
    http_endpoint               = string
    http_tokens                 = string
    http_put_response_hop_limit = number
    instance_metadata_tags      = string
  })

  default = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"  
  }
}

variable "user_data_file" {
  type    = string
}

variable "instance_name" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "scaling_size" {
  type = object({
    max_size         = number
    min_size         = number
    desired_capacity = number
  })
}

variable "health_check_grace_period" {
  type = string
  default = "300"
}

variable "health_check_type" {
  type = string
  default = "ELB"
}

variable "force_delete" {
  type = bool
  default = true
}

variable "instance_maintenance_policy" {
  type = object({
    min_healthy_percentage = number
    max_healthy_percentage = number
  })
  default = {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
}

variable "tags" {
  type = map(string)
}