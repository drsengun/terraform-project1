data "aws_ami" "amazon-linux" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
resource "aws_autoscaling_group" "web-asg" {
   count = var.region != "us-west-1" ? 1 : 0
  launch_template {
   id =  aws_launch_template.as_conf.id
   version = "$Latest"
    }
  
  min_size             = 1
  max_size             = 3
  name                = "web-asg"
  vpc_zone_identifier = "${(module.vpc.public_subnets)}"
  desired_capacity    = 2
  

}

resource "aws_launch_template" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
    lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}



module "vpc" {
  source = "../VPC/"
  region = var.region
}
module "vpc-california" {
  source = "../VPC/"
  region = var.region
}


resource "aws_lb" "test" {
  count = var.region != "us-west-1" ? 1 : 0
  name               = "test"
  internal           = false
  load_balancer_type = "application"
  subnets            = "${(module.vpc.public_subnets)}"

  enable_deletion_protection = false
  
}

resource "aws_lb" "test-california" {
  count = var.region == "us-west-1" ? 1 : 0
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = "${(module.vpc-california.public_subnets)}"

  enable_deletion_protection = false
  
}

resource "aws_autoscaling_group" "web-asg-california" {
    count = var.region == "us-west-1" ? 1 : 0
  launch_template {
   id =  aws_launch_template.as_conf.id
   version = "$Latest"
    }
  
  min_size             = 1
  max_size             = 3
  name                = "web-asg"
  vpc_zone_identifier = "${(module.vpc-california.public_subnets)}"
  desired_capacity    = 2
  

}