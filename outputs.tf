output "vpc" {
  value = lookup(module.vpc, "main" , null)
}

output "vpc_id" {
  value = aws_vpc.main.id
}