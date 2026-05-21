# terraform-google-ai-talent

[![Terraform Registry](https://img.shields.io/badge/terraform-registry-623CE4?logo=terraform)](https://registry.terraform.io/modules/rakettitiede/ai-talent/google/latest)

Terraform module for deploying the [ai-talent](https://github.com/rakettitiede/ai-talent-platform) ecosystem on GCP.

## What gets deployed

**All partners:**
- `mcp-agileday` + Pyry Slack bot — internal consultant search
- `mcp-talent-network` — anonymous federated search node

**Rakettitiede only (`partner = "rakettitiede"`):**
- Minna Slack bot — federated search interface (aggregates all partner nodes)
- `ai-talent-bench-mcp` + Topi Slack bot — salary projections

## Prerequisites

- Terraform >= 1.7
- GCP project with billing enabled
- Service account with roles: `roles/run.admin`, `roles/artifactregistry.admin`, `roles/storage.admin`, `roles/secretmanager.admin`, `roles/iam.admin`, `roles/aiplatform.user`
- `gcloud auth application-default login`

## Quick Start

### 1. Bootstrap (once per project)

```bash
cd bootstrap
terraform init
terraform apply -var="project_id=your-project-id"
```

### 2. Deploy

```bash
cp terraform.tfvars.example terraform.tfvars
# fill in project_id, service_account, partner, image_tags

terraform init -backend-config=backend.tfvars
terraform plan
terraform apply
```

### 3. Populate Slack secrets

After apply, add your Slack tokens:

```bash
echo -n "xoxb-your-token" | gcloud secrets versions add pyry-bot-token --data-file=-
echo -n "your-signing-secret" | gcloud secrets versions add pyry-slack-signing-secret --data-file=-
```

See [ai-talent-platform/assistants/slack-general-setup.md](https://github.com/rakettitiede/ai-talent-platform/blob/main/assistants/slack-general-setup.md).

## partner variable

`partner` is required and must be unique per company, so Minna can identify results by source:

- `rakettitiede` → deploys full stack including Minna and Topi
- `partner A`, `partner B`, etc. → deploys internal search + federation node only

## Docker images

Images are pulled from Rakettitiede's Artifact Registry (`ai-cv-match-471207`) by default. Each service is pinned independently via the `image_tags` map:

```hcl
image_tags = {
  agileday    = "v3.8.0"
  pyry        = "v1.3.0"
  network_mcp = "v0.5.0"
  minna       = "v1.2.0"
  bench_mcp   = "v1.2.0"
  topi        = "v1.4.0"
}
```

To self-host images, override `artifact_registry_project_id` with your own GCP project ID.

## GCP AR access grant (Rakettitiede runs this for each partner)

```bash
for repo in mcp-agileday ai-talent-search-pyry mcp-talent-network; do
  gcloud artifacts repositories add-iam-policy-binding $repo \
    --location=europe-north1 \
    --project=ai-cv-match-471207 \
    --member="serviceAccount:PARTNER_SA@PARTNER_PROJECT.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.reader"
done
```
