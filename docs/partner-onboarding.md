# Partner Onboarding Guide

Deploy Pyry (Slack talent search) and join the Minna federation (cross-company search).

## Prerequisites

- GCP project with billing
- AgileDay account
- Slack workspace admin access
- Terraform >= 1.7, gcloud CLI

---

## Phase 1: GCP Setup

```bash
gcloud config set project YOUR_PROJECT_ID

gcloud services enable \
  cloudrun.googleapis.com \
  artifactregistry.googleapis.com \
  secretmanager.googleapis.com \
  aiplatform.googleapis.com \
  storage.googleapis.com \
  iam.googleapis.com

gcloud iam service-accounts create terraform-deployer \
  --display-name="Terraform Deployer"

SA_EMAIL=terraform-deployer@YOUR_PROJECT_ID.iam.gserviceaccount.com

for role in roles/run.admin roles/artifactregistry.admin roles/storage.admin \
  roles/secretmanager.admin roles/iam.serviceAccountAdmin roles/aiplatform.user \
  roles/serviceusage.serviceUsageConsumer; do
  gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:$SA_EMAIL" --role="$role"
done
```

---

## Phase 2: Request Image Access

**Email kalle@rakettitiede.com:**
- Service account: `terraform-deployer@YOUR_PROJECT_ID.iam.gserviceaccount.com`
- Partner identifier (lowercase): e.g., `acme`

**Wait for reply with:** confirmed partner ID.

---

## Phase 3: Create Terraform State Bucket

**Option A — gcloud:**
```bash
gcloud storage buckets create gs://YOUR_PROJECT_ID-terraform-state \
  --location=europe-north1 --uniform-bucket-level-access
```

**Option B — bootstrap module:**
```bash
mkdir tf-bootstrap && cd tf-bootstrap
cat > main.tf << 'EOF'
module "bootstrap" {
  source  = "rakettitiede/ai-talent/google//modules/bootstrap"
  version = "~> 1.0"
  project_id = "YOUR_PROJECT_ID"
}
output "state_bucket" { value = module.bootstrap.state_bucket }
EOF

terraform init && terraform apply
cd .. && rm -rf tf-bootstrap
```

---

## Phase 4: Deploy

```bash
mkdir ai-talent && cd ai-talent
```

**main.tf:**
```hcl
module "ai_talent" {
  source            = "rakettitiede/ai-talent/google"
  version           = "~> 2.0"
  project_id        = "YOUR_PROJECT_ID"
  service_account   = "terraform-deployer@YOUR_PROJECT_ID.iam.gserviceaccount.com"
  partner           = "your-partner-id"
  agileday_base_url = "https://api.agileday.io"
  # image_tags defaults to versions tested with this module release
}
output "pyry_url" { value = module.ai_talent.pyry_url }
output "search_mcp_url" { value = module.ai_talent.search_mcp_url }
output "network_mcp_url" { value = module.ai_talent.network_mcp_url }
```

**backend.tf:**
```hcl
terraform {
  backend "gcs" {
    bucket = "YOUR_STATE_BUCKET"
    prefix = "ai-talent"
  }
}
```

```bash
terraform init && terraform apply
```

---

## Phase 5: Create Slack App

1. https://api.slack.com/apps → Create New App → From scratch
2. Name: `Pyry`, select workspace

**OAuth & Permissions → Bot Token Scopes:**
- `im:history`, `im:read`, `im:write`

Click **Install to Workspace**.

**App Home** — enable all:
- Home Tab
- Messages Tab
- Allow users to send Slash commands and messages from the messages tab

**Store credentials:**
```bash
echo -n "xoxb-your-bot-token" | gcloud secrets versions add pyry-bot-token --data-file=-
echo -n "your-signing-secret" | gcloud secrets versions add pyry-slack-signing-secret --data-file=-
```

**Event Subscriptions:**
- Enable Events
- Request URL: `https://PYRY_URL/slack/events`
- Bot events: `message.im`, `app_home_opened`

---

## Phase 6: Initialize Database

Get AgileDay token: Browser DevTools → Application → Cookies → copy session cookie.

```bash
API_KEY=$(gcloud secrets versions access latest --secret=ai-talent-search-mcp-api-key)
curl -X POST "$(terraform output -raw search_mcp_url)/api/v1/refresh" \
  -H "X-API-Key: $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"token": "YOUR_AGILEDAY_TOKEN"}'
```

---

## Phase 7: Verify Pyry

DM Pyry in Slack: "Find a senior React developer"

---

## Phase 8: Join Federation

**Email kalle@rakettitiede.com:**
```bash
terraform output -raw network_mcp_url
```

Rakettitiede will:
1. Add your node to Minna's federation
2. Send you the Minna install link

**Install Minna:**
1. Have a workspace admin click the install link
2. Authorize Minna for your workspace
3. After authorization, send the redirect URL (contains a `code` parameter) back to Rakettitiede
4. Rakettitiede will complete the token exchange and enable Minna for your workspace

Test Minna: "Find a consultant with Kubernetes experience"

---

## Maintenance

**Refresh database:**
```bash
API_KEY=$(gcloud secrets versions access latest --secret=ai-talent-search-mcp-api-key)
curl -X POST "$(terraform output -raw search_mcp_url)/api/v1/refresh" \
  -H "X-API-Key: $API_KEY" -H "Content-Type: application/json" \
  -d '{"token": "FRESH_AGILEDAY_TOKEN"}'
```

**Update versions:** Edit image_tags, run `terraform apply`.
