resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = [var.security_group_id]
  subnets            = var.subnet

  tags = var.tags
}

resource "aws_lb_target_group" "target_group" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
