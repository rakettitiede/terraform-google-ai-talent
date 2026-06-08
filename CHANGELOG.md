# Changelog

## [2.3.3](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.3.2...v2.3.3) (2026-06-08)


### Bug Fixes

* **ci:** inline auto-triage workflow and harden project field population ([#30](https://github.com/rakettitiede/terraform-google-ai-talent/issues/30)) ([6449a62](https://github.com/rakettitiede/terraform-google-ai-talent/commit/6449a62eb4482dad309376177333b37551af3d3d))

## [2.3.2](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.3.1...v2.3.2) (2026-06-04)


### Bug Fixes

* **terraform:** add GCP_PROJECT_ID and GCP_LOCATION env vars to network_mcp ([#28](https://github.com/rakettitiede/terraform-google-ai-talent/issues/28)) ([124ee01](https://github.com/rakettitiede/terraform-google-ai-talent/commit/124ee0159899a6791f672b981126e8dd442501bc))

## [2.3.1](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.3.0...v2.3.1) (2026-06-03)


### Bug Fixes

* demonstrate triage table format ([#25](https://github.com/rakettitiede/terraform-google-ai-talent/issues/25)) ([228a8b7](https://github.com/rakettitiede/terraform-google-ai-talent/commit/228a8b7caddbf02122ec65f5c331ff40c35e5c8c))

## [2.3.0](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.2.3...v2.3.0) (2026-06-03)


### Features

* reflect Minna multi-workspace + federation config ([#22](https://github.com/rakettitiede/terraform-google-ai-talent/issues/22)) ([e1ea5df](https://github.com/rakettitiede/terraform-google-ai-talent/commit/e1ea5dffc7ed41ef5c8f1684d287b2fae96e3056))

## [2.2.3](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.2.2...v2.2.3) (2026-05-28)


### Bug Fixes

* rotate API keys on image change instead of every apply ([#18](https://github.com/rakettitiede/terraform-google-ai-talent/issues/18)) ([791bda3](https://github.com/rakettitiede/terraform-google-ai-talent/commit/791bda359cab291e9224765a91239c3387033548))

## [2.2.2](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.2.1...v2.2.2) (2026-05-28)


### Bug Fixes

* set GCP_PROJECT_ID and GCP_LOCATION on agileday service ([#16](https://github.com/rakettitiede/terraform-google-ai-talent/issues/16)) ([c467db1](https://github.com/rakettitiede/terraform-google-ai-talent/commit/c467db1c145f04327c75adcf49a993f644084359))

## [2.2.1](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.2.0...v2.2.1) (2026-05-28)


### Bug Fixes

* grant secretAccessor and add missing agileday env vars ([#14](https://github.com/rakettitiede/terraform-google-ai-talent/issues/14)) ([d6136c9](https://github.com/rakettitiede/terraform-google-ai-talent/commit/d6136c971f113f4fef633cf9c8d386496349dd7e))

## [2.2.0](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.1.0...v2.2.0) (2026-05-27)


### Features

* terraform-managed API_KEY via Secret Manager ([#12](https://github.com/rakettitiede/terraform-google-ai-talent/issues/12)) ([2d41194](https://github.com/rakettitiede/terraform-google-ai-talent/commit/2d41194a0fcc0e81169f3333ffb3711ad1e03022))

## [2.1.0](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v2.0.0...v2.1.0) (2026-05-25)


### Features

* publish bootstrap as a submodule under modules/bootstrap ([#9](https://github.com/rakettitiede/terraform-google-ai-talent/issues/9)) ([72ae06a](https://github.com/rakettitiede/terraform-google-ai-talent/commit/72ae06a9dcbdcd600380accfe0e37fa461d84839))

## [2.0.0](https://github.com/rakettitiede/terraform-google-ai-talent/compare/v1.0.0...v2.0.0) (2026-05-22)


### ⚠ BREAKING CHANGES

* per-service image_tags + artifact_registry_project_id constant ([#7](https://github.com/rakettitiede/terraform-google-ai-talent/issues/7))

### Features

* per-service image_tags + artifact_registry_project_id constant ([#7](https://github.com/rakettitiede/terraform-google-ai-talent/issues/7)) ([893395c](https://github.com/rakettitiede/terraform-google-ai-talent/commit/893395c0b17c43aad603f5fa603b01e58a2df1e8))

## 1.0.0 (2026-05-13)


### Features

* initial ai-talent Terraform module ([50db105](https://github.com/rakettitiede/terraform-google-ai-talent/commit/50db105c1e3050862a6a933eb374f07d5ecbbc62))


### Bug Fixes

* replace LICENSE with canonical Apache 2.0 text ([#4](https://github.com/rakettitiede/terraform-google-ai-talent/issues/4)) ([412a3e9](https://github.com/rakettitiede/terraform-google-ai-talent/commit/412a3e957cc9d9c5590917fa0ec78a845842db47))
* use canonical Apache 2.0 SPDX text ([#5](https://github.com/rakettitiede/terraform-google-ai-talent/issues/5)) ([683e3c1](https://github.com/rakettitiede/terraform-google-ai-talent/commit/683e3c16bdca8642f6d942a13e9ae2a3c5cb3c25))

## [Unreleased]

### Added
- Initial module: full ai-talent ecosystem deployment
- `partner` variable controls Rakettitiede-specific resources (Minna, Topi)
- Bootstrap module for GCS state bucket creation
