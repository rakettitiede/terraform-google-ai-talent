# Partner Onboarding Checklist

## Receive from Partner
- [ ] Service account email
- [ ] Partner identifier (lowercase)

## Grant Image Access
```bash
PARTNER_SA="terraform-deployer@partner-project.iam.gserviceaccount.com"
for repo in mcp-agileday ai-talent-search-pyry mcp-talent-network; do
  gcloud artifacts repositories add-iam-policy-binding $repo \
    --project=ai-cv-match-471207 --location=europe-north1 \
    --member="serviceAccount:$PARTNER_SA" --role="roles/artifactregistry.reader"
done
```
- [ ] Done

## Reply to Partner
- [ ] Confirmed partner ID
- [ ] Image tags:
```bash
for repo in mcp-agileday ai-talent-search-pyry mcp-talent-network; do
  gcloud artifacts docker images list \
    europe-north1-docker.pkg.dev/ai-cv-match-471207/$repo/$repo \
    --include-tags --limit=3
done
```

## After Partner Deploys
- [ ] Receive network_mcp_url

```bash
PARTNER_ID="ACME"
PARTNER_URL="https://mcp-talent-network-xxxxx.run.app"
gcloud run services update ai-talent-network-minna \
  --region europe-north1 --project ai-cv-match-471207 \
  --update-env-vars MCP_API_URL_$PARTNER_ID=$PARTNER_URL
```
- [ ] Added to Minna

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
