terraform {
 backend "gcs" {
   bucket  = "tripod-dev-tf-state"
   prefix  = "terraform/state"
 }
}