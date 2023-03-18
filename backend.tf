terraform {
 backend "gcs" {
   bucket  = "tripod-dev-tf-state"
   prefix  = "terraform/state"
 }
}

data "terraform_remote_state" "gcs" {
  backend = "gcs"
  config = {
    bucket  = "tripod-dev-tf-state"
    prefix  = "terraform/state"
 }
}