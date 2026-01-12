output "public_ip" {
  value       = aws_instance.nginx.public_ip
  description = "IP público da EC2"
}

output "url" {
  value = "http://${aws_instance.nginx.public_ip}"
}