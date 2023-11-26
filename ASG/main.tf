
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical
}

resource "aws_autoscaling_group" "web-asg" {
  launch_template {
   id =  aws_launch_template.as_conf.name
   version = "$Latest"
    }
  min_size             = 1
  max_size             = 3
  name                = "web-asg"
  vpc_zone_identifier = "${(module.vpc.public_subnets[0])}"
  desired_capacity    = 2


}
resource "aws_launch_template" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "../VPC/"
}
module "vpc-california" {
  source = "../VPC/"
  # Other module configuration options go here
}





resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"

  subnets            = "${(module.vpc.public_subnets[0])}"

  enable_deletion_protection = true

}