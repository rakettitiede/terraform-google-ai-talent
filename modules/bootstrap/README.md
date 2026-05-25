# Bootstrap — Terraform State Bucket

One-time setup module that creates the GCS bucket used as the remote state backend for the root `rakettitiede/ai-talent/google` module.

This module uses **local state** (throwaway) because it creates the very bucket that the root module needs for remote state — a classic chicken-and-egg.

## Usage

Create a scratch directory anywhere on your machine and add a single file:

```hcl
# main.tf
module "bootstrap" {
  source  = "rakettitiede/ai-talent/google//modules/bootstrap"
  version = "~> 2.0"

  project_id = "your-gcp-project-id"
}

output "state_bucket" {
  value = module.bootstrap.state_bucket
}
```

Then run:

```fish
mkdir /tmp/bootstrap-scratch && cd /tmp/bootstrap-scratch

# paste main.tf above, then:
terraform init
terraform apply

# note the state_bucket output — you'll need it next
# e.g. your-gcp-project-id-terraform-state
```

Once the bucket exists, you can delete the scratch directory — its local state is no longer needed:

```fish
cd .. && rm -rf /tmp/bootstrap-scratch
```

## Next step

Add a backend block to your root module configuration pointing at the new bucket:

```hcl
terraform {
  backend "gcs" {
    bucket = "your-gcp-project-id-terraform-state"
  }
}
```

Then proceed with `terraform init -backend-config=backend.tfvars` as described in the root README.

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `project_id` | GCP project ID | `string` | — |
| `region` | GCP region for the bucket | `string` | `"europe-north1"` |

## Outputs

| Name | Description |
|------|-------------|
| `state_bucket` | Name of the GCS bucket created for Terraform remote state |
