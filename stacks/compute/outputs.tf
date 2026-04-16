output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = module.alb.alb_dns_name
}
