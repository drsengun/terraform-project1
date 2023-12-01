data "terraform_remote_state" "remote" {
	backend = "s3"
        config = {
            bucket = "company-wide-storage-illiasoroka"
            key = "env:/us/path/to/my/vpc"
            region = "us-east-1"
	}
}

resource "aws_db_subnet_group" "default" {
  name       = "sdlc"
  subnet_ids = data.terraform_remote_state.main.outputs.private_subnets
  
}