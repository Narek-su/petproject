resource "aws_launch_template" "launch_template" {
  name = var.launch_template_name

  image_id = var.ami_id != "" ? var.ami_id : data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size           = var.ebs.volume_size
      volume_type           = var.ebs.volume_type
      delete_on_termination = var.ebs.delete_on_termination
    }
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
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

  user_data = filebase64(var.user_data_file)
}


resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  max_size                  = var.scaling_size.max_size
  min_size                  = var.scaling_size.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.scaling_size.desired_capacity
  force_delete              = var.force_delete

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arn

  vpc_zone_identifier = var.subnet

  instance_maintenance_policy {
    min_healthy_percentage = var.instance_maintenance_policy.min_healthy_percentage
    max_healthy_percentage = var.instance_maintenance_policy.max_healthy_percentage
  }
}
