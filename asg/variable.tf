variable "userdata" {
  type    = string
  default = ""
}

variable "region" {
  description = "AWS regions"
  type        = string
  default     = "us-east-1"
}
