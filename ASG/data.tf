data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "company-wide-storage-illiasoroka"
    key    = "path/to/my/1.tfstate"
    region = "us-east-1"
    }
  }

