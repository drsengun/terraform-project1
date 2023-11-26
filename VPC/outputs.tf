# output "vpc_ids" {
#   value = concat([for vpc in module.vpc : vpc.vpc_id], [for vpc in module.vpc-california : vpc.vpc_id])
# }

# output "private_subnets" {
#   value = concat([for vpc in module.vpc : vpc.private_subnets], [for vpc in module.vpc-california : vpc.private_subnets])
# }

# output "public_subnets" {
#   value = concat([for vpc in module.vpc : vpc.public_subnets], [for vpc in module.vpc-california : vpc.public_subnets])
# }
output "vpc_ids" {
  value = module.vpc != null && can(module.vpc.vpc_id) ? [module.vpc.vpc_id] : []
}


output "private_subnets" {
  value = module.vpc != null && can(module.vpc.private_subnets) ? module.vpc.private_subnets : []
}


output "public_subnets" {
  value = module.vpc != null && can(module.vpc.public_subnets) ? module.vpc.public_subnets : []
}


