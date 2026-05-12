variable "project_id" {
  description = "GCP project ID — required, no default. Each partner uses their own project."
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-north1"
}

variable "service_account" {
  description = "Service account email for all Cloud Run services"
  type        = string
}

variable "partner" {
  description = "Partner identifier — unique per company. Used to prefix OpenAPI operationIds and to conditionally deploy Rakettitiede-specific services (Minna, Topi)."
  type        = string
}

variable "image_project_id" {
  description = "GCP project ID where Docker images are stored in Artifact Registry. Defaults to project_id — override if pulling images from Rakettitiede's registry."
  type        = string
  default     = ""
}

variable "image_tag" {
  description = "Docker image tag to deploy. Pin to a specific release (e.g. v1.2.1) — do not use latest in production."
  type        = string
  default     = "latest"
}

variable "gemini_model" {
  description = "Vertex AI Gemini model name used by all Slack bots"
  type        = string
  default     = "gemini-2.5-flash"
}

variable "cloud_run_suffix" {
  description = "Cloud Run URL suffix (the random hash in the service URL). Leave empty on first apply — update after deploy."
  type        = string
  default     = ""
}

locals {
  image_project = var.image_project_id != "" ? var.image_project_id : var.project_id
}
