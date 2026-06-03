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

variable "image_tags" {
  description = "Per-service Docker image tags. All keys required. Pin to specific releases — do not use latest in production."
  type = object({
    agileday    = string
    pyry        = string
    network_mcp = string
    minna       = string
    bench_mcp   = string
    topi        = string
  })
}

variable "artifact_registry_project_id" {
  description = "GCP project hosting Docker images in Artifact Registry. Defaults to Rakettitiede's registry. Override only if self-hosting images."
  type        = string
  default     = "ai-cv-match-471207"
}

variable "agileday_base_url" {
  description = "Base URL for the AgileDay API that mcp-agileday queries."
  type        = string
}

variable "gemini_model" {
  description = "Vertex AI Gemini model name used by all Slack bots"
  type        = string
  default     = "gemini-2.5-flash"
}

variable "partner_mcp_urls" {
  description = "Base URLs of OTHER partners' mcp-talent-network nodes that Minna federates over (Rakettitiede deployment only). The local node is added automatically."
  type        = list(string)
  default     = []
}
