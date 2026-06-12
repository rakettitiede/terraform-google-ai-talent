# terraform-google-ai-talent

[![Terraform Registry](https://img.shields.io/badge/terraform-registry-623CE4?logo=terraform)](https://registry.terraform.io/modules/rakettitiede/ai-talent/google/latest)

Terraform module for deploying the [ai-talent](https://github.com/rakettitiede/ai-talent-platform) ecosystem on GCP.

## Overview

This module deploys a talent search system that lets consultancies find the right people for projects — both internally and across partner companies.

For each partner, three services are deployed to your own GCP project:

- **mcp-agileday** — search backend that indexes your consultant data from AgileDay
- **Pyry** — Slack bot for internal searches ("Find a senior React developer with fintech experience")
- **mcp-talent-network** — federation node that exposes an anonymized view of your consultants to the Minna network

All candidate data is stored in your own GCP environment (Cloud Storage buckets). Rakettitiede does not have access to your consultant database — only the anonymized search results you choose to expose via the federation node.

**Minna (Rakettitiede only):** Aggregates search results across all partner nodes, enabling cross-company talent discovery while preserving privacy.

## Getting Started

See [docs/partner-onboarding.md](docs/partner-onboarding.md) for setup instructions.
