terraform {
  backend "s3" {
    bucket         = "terraformollionstatebucket"
    key            = "control-tower/landing-zone.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
