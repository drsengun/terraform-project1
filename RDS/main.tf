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
  vpc_security_group_ids = [aws_security_group.rds_allow_rule.id]
  multi_az = true
  skip_final_snapshot = true
  lifecycle {
    prevent_destroy = false
    ignore_changes = all
  }
}

resource "random_string" "rds_password" {
  length  = 16
  special = false
}

resource "aws_security_group" "rds_allow_rule" {
  description = "Allow port 3306"
  vpc_id      = module.vpc.vpc_ids
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
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
