# output "vpc_ids" {
#   value = concat([for vpc in module.vpc : vpc.vpc_id])
# }

# output "private_subnets" {
#   value = concat([for vpc in module.vpc : vpc.private_subnets])
# }

# output "public_subnets" {
#   value = concat([for vpc in module.vpc : vpc.public_subnets])
# }
output "vpc_ids" {
  value = [for vpc in module.vpc : vpc.vpc_id]
}

output "private_subnets" {
  value = flatten([for vpc in module.vpc : vpc.private_subnets])
}

output "public_subnets" {
  value = flatten([for vpc in module.vpc : vpc.public_subnets])
}

output "vpc_ids_california" {
  value = [for vpc in module.vpc-california : vpc.vpc_id]
}

output "private_subnets_california" {
  value = flatten([for vpc in module.vpc-california : vpc.private_subnets])
}

output "public_subnets_california" {
  value = flatten([for vpc in module.vpc-california : vpc.public_subnets])
}
