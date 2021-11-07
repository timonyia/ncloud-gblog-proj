terraform {
  backend "s3" {
    profile        = "ecs-course"
    region         = "eu-west-2"
    bucket         = "ri-backend-state-bucket"
    key            = "infrastructure/terraform.tfstate"
    dynamodb_table = "s3-state-lock"
  }
}