output "private_key" {
  value     = google_service_account_key.sa_key.private_key
  sensitive = true
}

output "decoded_private_key" {
  value     = base64decode(google_service_account_key.sa_key.private_key)
  sensitive = true
}

output "public_ip" {
  value     = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "net_info" {
  value     = data.terraform_remote_state.gcs.outputs.public_ip
}