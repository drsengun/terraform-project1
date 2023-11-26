resource "aws_key_pair" "terraform-project" {
  key_name = "terraform-project"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  count = var.region != "us-west-1" ? 1 : 0

  name = "my-vpc"
  cidr = "10.0.0.0/16"


  azs             = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
    ]


  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

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


module "vpc-california" {
  source = "terraform-aws-modules/vpc/aws"
  count = var.region == "us-west-1" ? 1 : 0

  name = "my-california-vpc"
  cidr = "10.0.0.0/16"


  azs             = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],

    ]


  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

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

data "aws_availability_zones" "available" {
  state = "available"
}


# # Creates a security Group
# resource "aws_security_group" "sec-group" {
#   name        = "sec-group"
#   description = "Allow TLS inbound traffic"

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#     ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }
