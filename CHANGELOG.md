# Changelog

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
