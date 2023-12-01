data "terraform_remote_state" "remote" {
	backend = "s3"
        config = {
            bucket = "sdlc-terraform-backend-illiasoroka"
            key = "env:/us/path/to/my/vpc"
            region = "us-east-1"
	}
}