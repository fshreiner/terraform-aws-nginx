resource "aws_launch_template" "nginx" {
  name_prefix   = "${var.project_name}-template-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.nginx_instances.id
  ]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update
              apt install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-nginx"
    }
  }
}