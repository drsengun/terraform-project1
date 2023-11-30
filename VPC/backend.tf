terraform {
  backend "s3" {
    bucket = "company-wide-storage-illiasoroka"
    key    = "path/to/my/1.tfstate"
    region = "us-east-1"
  }
}
