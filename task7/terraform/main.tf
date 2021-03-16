provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "internship"
}

provider "google" {
  project = "exadel-internship-2021"
  region  = "europe-west3"
  zone    = "europe-west3-b"
}

# aws s3api create-bucket --bucket internship-jenkins-terraform --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2 --profile internship
terraform {
  backend "s3" {
    bucket  = "internship-jenkins-tf"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    profile = "internship"
  }
}