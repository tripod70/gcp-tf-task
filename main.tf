terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public-subnetwork" {
  network = google_compute_network.vpc_network.name 
  name = var.vpc_subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  region = var.region
  depends_on    = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "rules" { 
  project = var.project_id
  name = "firewall-rule" 
  depends_on    = [google_compute_network.vpc_network]
  network = google_compute_network.vpc_network.name
  allow { 
    protocol = "tcp" 
    ports = ["22", "80", "443"] 
  } 
  source_ranges = var.firewall_src_ranges
}

resource "google_compute_instance" "vm_instance" {
  name         = var.gce_instance_name
  machine_type = var.gce_instance_type
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    #network =  google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnetwork.name
    access_config {
    }
  }
  service_account {
    email  = "${google_service_account.sa.email}"
    #email  = data.terraform_remote_state.gcs.outputs.sa_email
    scopes = ["cloud-platform"]
  }
}

resource "google_service_account" "sa" {
  account_id   = var.sa_name
  project      = var.project_id
}

resource "google_project_iam_member" "sa" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.sa.name
}
