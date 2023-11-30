data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "aws-team1"
    key    = "env:/dev/path/to/my/1.tfstate"
    region = "us-east-1"
    }
  }



output all {
    value = data.terraform_remote_state.remote.outputs.*
}