# ######### Create an EC2 Auto Scaling Group - web ############
# resource "aws_autoscaling_group" "web-asg" {
#   min_size = 1
#   max_size = 3
#   name = "web-asg"
#   vpc_zone_identifier = module.vpc.public_subnets
#   desired_capacity = 2
# }

# resource "aws_launch_template" "foobar" {
#   name_prefix   = "foobar"
#   image_id      = "ami-0fa1ca9559f1892ec"
#   instance_type = "t2.micro"
# }

# data "aws_availability_zones" "available" {
#   state = "available"
# }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

}
# resource “aws_autoscaling_group” “three-tier-web-asg” {
#   name                 = “three-tier-web-asg”
#   launch_configuration = aws_launch_configuration.three-tier-web-lconfig.id
#   vpc_zone_identifier  = [aws_subnet.three-tier-pub-sub-1.id, aws_subnet.three-tier-pub-sub-2.id]
#   min_size             = 2
#   max_size             = 3
#   desired_capacity     = 2
# }
# ###### Create a launch configuration for the EC2 instances #####
# resource “aws_launch_configuration” “three-tier-web-lconfig” {
#   name_prefix                 = “three-tier-web-lconfig”
#   image_id                    = “ami-0b3a4110c36b9a5f0”
#   instance_type               = “t2.micro”
#   key_name                    = “three-tier-web-asg-kp”
#   security_groups             = [aws_security_group.three-tier-ec2-asg-sg.id]
#   user_data = file("${path.module}/userdata.sh")
    
#   }                          



module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "example-asg"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       =  ["subnet-0942ea9c940eb3131"]




  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = "ami-ebd02392"
  instance_type     = "t3.micro"
  ebs_optimized     = true
  enable_monitoring = true




  # This will ensure imdsv2 is enabled, required, and a single hop which is aws security
  # best practices
  # See https://docs.aws.amazon.com/securityhub/latest/userguide/autoscaling-controls.html#autoscaling-4
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = ["sg-12345678"]
    },
    {
      delete_on_termination = true
      description           = "eth1"
      device_index          = 1
      security_groups       = ["sg-12345678"]
    }
  ]

  placement = {
    availability_zone = "${(data.aws_availability_zones.available.names[0])}"
  }


}

data "aws_availability_zones" "available" {
  state = "available"
}