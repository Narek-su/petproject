resource "aws_launch_template" "launch_template" {
  name = var.launch_template_name

  image_id               = "ami-04bee561b50ae0b42"
  instance_type          = "t3.micro"
  key_name               = "petproject-key"
  vpc_security_group_ids = [var.security_group_id]

  credit_specification {
    cpu_credits = "standard"
  }

  instance_initiated_shutdown_behavior = "terminate"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 8
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = var.instance_name
      }
    )
  }

  user_data = filebase64("${path.module}/install_nginx.sh")
}


resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  max_size                  = var.scaling_size.max_size
  min_size                  = var.scaling_size.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.scaling_size.desired_capacity
  force_delete              = true

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arn

  vpc_zone_identifier = var.subnet

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
}
