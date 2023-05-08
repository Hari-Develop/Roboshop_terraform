terraform {
    backend "s3" {
        bucket = "terraform-72"
        key    = "roboshop/terraform.tfstate"
        region = "us-east-1"
    }
}