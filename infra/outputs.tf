output "vpc_id" {
  value       = module.network.vpc_id
  description = "VPC id"
}
output "website_url" {
  description = "The website URL."
  value       = format("http://%s/users", aws_lb.lb.dns_name)
}

output "db_address" {
  value = aws_db_instance.database.address
}
