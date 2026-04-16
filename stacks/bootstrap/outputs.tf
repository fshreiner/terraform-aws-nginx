output "state_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "zone_name" {
  value = aws_route53_zone.this.name
}