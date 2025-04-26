terraform {
  backend "s3" {
    bucket = "athulin-buck"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    
  }
}
