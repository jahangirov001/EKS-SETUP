 terraform {
   backend "s3" {
     bucket  = "example-bucket"
     region  = "us-west-2"
     key     = "example_key/terraform.tfstate"
     encrypt = true
     dynamodb_table = "terraform-lock"
   }
 }
