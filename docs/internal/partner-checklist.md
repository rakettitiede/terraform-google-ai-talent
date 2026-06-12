# Partner Onboarding Checklist

## Receive from Partner
- [ ] Partner identifier (lowercase)
- [ ] GCP project number (not project ID)

## Grant Image Access

Cloud Run uses a service agent to pull images. Grant access to the partner's Cloud Run Service Agent:

```bash
PROJECT_NUMBER="107604611556"  # Partner's project number
for repo in mcp-agileday ai-talent-search-pyry mcp-talent-network; do
  gcloud artifacts repositories add-iam-policy-binding $repo \
    --project=ai-cv-match-471207 --location=europe-north1 \
    --member="serviceAccount:service-${PROJECT_NUMBER}@serverless-robot-prod.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.reader"
done
```
- [ ] Done

## Reply to Partner
- [ ] Confirmed partner ID
- [ ] Image access granted

## After Partner Deploys
- [ ] Receive network_mcp_url

**Update partner_mcp_urls in terraform.tfvars** (map of partner name to URL):
```hcl
partner_mcp_urls = {
  partner-a   = "https://mcp-talent-network-aaa.run.app"
  partner-b   = "https://mcp-talent-network-bbb.run.app"
  new-partner = "https://mcp-talent-network-zzz.run.app"  # Add new partner
}
```

Then apply (this updates the `minna-mcp-api-urls` secret with the new federation map):
```bash
terraform apply
```
- [ ] Added to partner_mcp_urls
- [ ] Terraform applied (creates new secret version with updated URLs)

## Install Minna in Partner Workspace

**Send install URL to partner:**
```
https://slack.com/oauth/v2/authorize?client_id=MINNA_CLIENT_ID&scope=app_mentions:read,chat:write,im:history,im:read,im:write
```
- [ ] Sent install URL

**Receive OAuth code from partner** (from redirect URL after authorization)

**Exchange code for token:**
```bash
curl -X POST "https://slack.com/api/oauth.v2.access" \
  -d "client_id=MINNA_CLIENT_ID" \
  -d "client_secret=MINNA_CLIENT_SECRET" \
  -d "code=CODE_FROM_PARTNER"
```

Response contains `team.id` and `access_token` (xoxb-...).

**Update SLACK_BOT_TOKENS secret:**
```bash
# Get current tokens
CURRENT=$(gcloud secrets versions access latest --secret=minna-bot-tokens --project=ai-cv-match-471207)

# Add new team (merge with existing JSON)
# Example: {"T123":"xoxb-existing","T456":"xoxb-new-partner"}
NEW_TOKENS='{"T123":"xoxb-existing","TNEW":"xoxb-new-token"}'

echo -n "$NEW_TOKENS" | gcloud secrets versions add minna-bot-tokens \
  --project=ai-cv-match-471207 --data-file=-
```

**Redeploy Minna to pick up new token:**
```bash
gcloud run services update ai-talent-network-minna \
  --region europe-north1 --project ai-cv-match-471207
```

- [ ] Token exchanged and added to secret
- [ ] Minna redeployed
- [ ] Partner confirmed Minna working
