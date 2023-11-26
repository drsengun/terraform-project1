# output "vpc_ids" {
#   value = concat([for vpc in module.vpc : vpc.vpc_id])
# }

# output "private_subnets" {
#   value = concat([for vpc in module.vpc : vpc.private_subnets])
# }

# output "public_subnets" {
#   value = concat([for vpc in module.vpc : vpc.public_subnets])
# }

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_ids" {
  value = module.vpc.vpc_id
}

output "provider" {
  value = var.region
}