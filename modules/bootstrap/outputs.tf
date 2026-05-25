output "state_bucket" {
  description = "Name of the GCS bucket created for Terraform remote state."
  value       = google_storage_bucket.terraform_state.name
}
