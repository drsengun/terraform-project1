resource "aws_key_pair" "terraform-project" {
  key_name   = "terraform-project"
  public_key = file("~/.ssh/id_rsa.pub")
}


# 
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



resource "aws_autoscaling_group" "web-asg" {
  launch_template {
    id      = aws_launch_template.as_conf.id
    version = "$Latest"
  }
  min_size            = 1
  max_size            = 3
  name                = "web-asg"
  vpc_zone_identifier = data.terraform_remote_state.remote.outputs.public_subnets
  desired_capacity    = 2

}

resource "aws_launch_template" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  key_name      = "terraform-project"
  user_data = file("${path.module}/userdata.sh")

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
  subnets                    = data.terraform_remote_state.remote.outputs.public_subnets
  security_groups            = [aws_security_group.web-sg.id]
}

resource "aws_lb_target_group" "web-tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.remote.outputs.vpc_ids
  
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
    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Register the instances with the target group - web tier
resource "aws_autoscaling_attachment" "web-attach" {
  autoscaling_group_name = aws_autoscaling_group.web-asg.name
  lb_target_group_arn   = aws_lb_target_group.web-tg.arn
}


# Create Web Security Group
resource "aws_security_group" "web-sg" {
  name        = "Web-SG"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.terraform_remote_state.remote.outputs.vpc_ids

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}


