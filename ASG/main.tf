resource "aws_key_pair" "terraform-project" {
  key_name   = "terraform-project"
  public_key = file("~/.ssh/id_rsa.pub")
}

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

data "aws_availability_zones" "available" {
  state = "available"
}


module "vpc" {
  source = "../VPC/"
  region = var.region
}

resource "aws_autoscaling_group" "web-asg" {
  launch_template {
    id      = aws_launch_template.as_conf.id
    version = "$Latest"
  }
  min_size            = 1
  max_size            = 3
  name                = "web-asg"
  vpc_zone_identifier = (module.vpc.public_subnets)
  desired_capacity    = 2

}

resource "aws_launch_template" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  key_name      = "terraform-project"
  user_data     = file("userdata.sh")
  lifecycle {
    create_before_destroy = true
  }
  network_interfaces {
    associate_public_ip_address = true
  }
}

resource "aws_lb" "web-lb" {
  name                       = "web-lb"
  internal                   = true
  load_balancer_type         = "application"
  subnets                    = (module.vpc.public_subnets)
}

resource "aws_lb_target_group" "web-tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_ids
  
  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Create Load Balancer listener - web tier
resource "aws_lb_listener" "web-listner" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

# Register the instances with the target group - web tier
resource "aws_autoscaling_attachment" "web-attach" {
  autoscaling_group_name = aws_autoscaling_group.web-asg.name
  lb_target_group_arn   = aws_lb_target_group.web-tg.arn
}



