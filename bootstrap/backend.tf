terraform {
  backend "s3" {
    bucket         = "terraform-ollionstatebucket"
    key            = "control-tower/bootstrap.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
