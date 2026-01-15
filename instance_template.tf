data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "nginx" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private["a"].id
  vpc_security_group_ids      = [aws_security_group.nginx_ec2.id]
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "${var.project_name}-ec2"
  }
}

resource "aws_lb_target_group_attachment" "nginx" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}