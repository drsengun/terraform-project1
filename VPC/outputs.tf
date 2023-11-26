output "vpc_ids" {
  value = concat([for vpc in module.vpc : vpc.vpc_id], [for vpc in module.vpc-california : vpc.vpc_id])
}

output "private_subnets" {
  value = concat([for vpc in module.vpc : vpc.private_subnets], [for vpc in module.vpc-california : vpc.private_subnets])
}

output "public_subnets" {
  value = concat([for vpc in module.vpc : vpc.public_subnets], [for vpc in module.vpc-california : vpc.public_subnets])
}

