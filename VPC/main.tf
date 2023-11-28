

data "aws_availability_zones" "available" {
  state = "available"
}


locals {
  vpc_availability_zones = length(data.aws_availability_zones.available.names) > 0 ? [data.aws_availability_zones.available.names[0]] : []
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = toset(data.aws_availability_zones.available.names)

  private_subnets = var.region != "us-west-1" ? ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"
  ] : [
    "10.0.1.0/24", "10.0.2.0/24",
  ]

  public_subnets = var.region != "us-west-1" ? [
    "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"
  ] : [
    "10.0.101.0/24", "10.0.102.0/24", 
  ]

  map_public_ip_on_launch = true
  create_database_subnet_group = true
  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_support = true
  enable_dns_hostnames = true
  
  manage_default_security_group = true

  default_security_group_ingress = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "SSH access from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  default_security_group_egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = "0.0.0.0/0"
      
    }
  ]
}

