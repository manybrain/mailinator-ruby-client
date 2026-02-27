# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project aims to follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Initial changelog scaffold.

### Deprecated

- Marked all Rules endpoints as deprecated:
  - `client.rules.create_rule`
  - `client.rules.enable_rule`
  - `client.rules.disable_rule`
  - `client.rules.get_all_rules`
  - `client.rules.get_rule`
  - `client.rules.delete_rule`
- Added deprecation markers in code (`lib/mailinator_client/rules.rb`) and deprecation notices in docs (`docs/rules.md`, `README.md`).
