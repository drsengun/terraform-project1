variable "userdata" {
  type    = string
  default = ""
}

variable "region" {
  description = "AWS regions"
  type        = string
  default     = ""
}

variable "web_asg" {
  description = "ASG"
  type = object({
    vpc_ids                  = list(string)
    private_subnets          = list(string)
    public_subnets           = list(string)
    default_security_group_id = string
    // other variables...
  })
  default = {
    vpc_ids                  = []
    private_subnets          = []
    public_subnets           = []
    default_security_group_id = ""
    // other default values...
  }
}
variable "vpc_public_subnets" {
  type    = list(string)
  default = []
}

variable "vpc_security_group_id" {
  type    = string
  default = ""
}