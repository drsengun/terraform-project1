terraform {
  backend "s3" {
    bucket = "company-wide-storage-illiasoroka"
    key    = "path/to/my/key/1"
    region = "us-east-1"
  }
}
