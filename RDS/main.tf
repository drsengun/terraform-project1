# Create a RDS
resource "aws_db_subnet_group" "db_sub_group" {
  name = "db_sub_group"
  subnet_ids = (module.vpc.private_subnets)
}

# Create DB instance
resource "aws_db_instance" "db_instance" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t2.micro"
  username = "admin"
  password = random_string.rds_password.result
  db_subnet_group_name = aws_db_subnet_group.db_sub_group.name
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  multi_az = true
  publicly_accessible = false
  lifecycle {
    prevent_destroy = false
    ignore_changes = all
  }
}


resource "random_string" "rds_password" {
  length  = 16
  special = false
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


# Create an ASG for DB
resource "aws_autoscaling_group" "db_asg" {
  name = "db_asg"
  launch_template {
    id = aws_launch_template.db_template.id
  }
  vpc_zone_identifier = (module.vpc.private_subnets)
  min_size = 1
  max_size = 3
  desired_capacity = 1
}

resource "aws_launch_template" "db_template" {
  name_prefix = "db_template"
  image_id = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  key_name = "terraform-project"
  security_group_names = [aws_security_group.rds_allow_rule.name]
  user_data = file("userdata.sh")
  lifecycle {
    prevent_destroy = false
    ignore_changes = all
  }
  network_interfaces {
    associate_public_ip_address = false
  }
}

resource "aws_security_group" "rds_allow_rule" {
  description = "Allow port 3306"
  vpc_id      = module.vpc.vpc_ids
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "vpc" {
  source = "../VPC/"
  region = var.region
}
