resource "aws_lb" "nginx_lb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  internal           = false

  subnets         = values(aws_subnet.public)[*].id
  security_groups = [aws_security_group.nginx_lb.id]

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "nginx" {
  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.tf_nginx.id

  health_check {
    path = "/"
  }

  tags = {
    Name = "${var.project_name}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}