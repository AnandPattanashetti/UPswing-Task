terraform {
  backend "s3" {
    bucket = "upswingbucketterrafrombackend" 
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
