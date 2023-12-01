data "terraform_remote_state" "remote" {
	backend = "s3"
        config = {
            bucket = "company-wide-storage-illiasoroka"
            key = "env:/us/path/to/my/vpc"
            region = "us-east-1"
	}
}

