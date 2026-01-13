output "alb_dns_name" {
  value = aws_lb.nginx_lb.dns_name
}