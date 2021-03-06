# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.4]

### Fixed

- Fix `maintenance_schedule` showing permanent drift and fails apply

## [0.0.3]

### BREAKING CHANGES

- Drop support for Terraform `< 1.0`
- Drop support for hashicorp/google-beta provider `< 4.9`

### Added

- Add unit tests

### Changed

- Changed `var.provider` to be optional instead of required since it can be inherited from the provider configuration

## [0.0.2]

### Added

- Support for provider `v4.x`

## [0.0.1]

### Added

- Initial Implementation

[unreleased]: https://github.com/mineiros-io/terraform-google-memorystore-redis/compare/v0.0.4...HEAD
[0.0.4]: https://github.com/mineiros-io/terraform-google-memorystore-redis/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mineiros-io/terraform-google-memorystore-redis/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mineiros-io/terraform-google-memorystore-redis/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-memorystore-redis/releases/tag/v0.0.1
