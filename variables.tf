variable "project_id" { }

variable "credentials_file" { }

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "vpc_network_name" {
    default = "net-00"
 }

variable "vpc_subnetwork_name" {
    default = "subnet-00"
 }

variable "ip_cidr_range" { }

variable "firewall_src_ranges" { 
    type = list(string)
}

variable "gce_instance_name" {
#    default = "vm-00"
}

variable "gce_instance_type" {
    default = "e2-micro"
 }

variable "sa_name" {
    default = "sa-tech"
}

variable "roles" {
  type        = list(string)
  default     = ["roles/cloudconfig.serviceAgent","roles/iam.serviceAccountUser"]
}