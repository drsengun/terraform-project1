terraform {
  backend "s3" {
    bucket = "company-wide-storage-illiasoroka"
    key    = "path/to/my/3"
    region = "us-east-1"
  }
}
