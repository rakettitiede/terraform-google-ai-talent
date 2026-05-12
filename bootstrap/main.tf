terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "terraform_state" {
  name                        = "${var.project_id}-terraform-state"
  location                    = var.region
  uniform_bucket_level_access = true
  versioning { enabled = true }
  force_destroy = false
  lifecycle { prevent_destroy = true }
}

output "state_bucket" {
  value = google_storage_bucket.terraform_state.name
}
