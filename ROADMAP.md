# Roadmap

This document tracks planned improvements for the Mailinator Ruby client.

## Phase 1

- [x] Add structural docs (`ROADMAP.md`, `CHANGELOG.md`, `AI_INSTRUCTIONS.md`, `EXAMPLEs.md`) - completed
- [x] Update outdated dependencies (`rake` and `webmock` updated; `httparty` pinned to latest Ruby 2.6-compatible range)
- [x] Update version number - completed (`1.0.7`)
- [ ] Publish those changes (minor release)

## Next

- [ ] Mark deprecated endpoints as deprecated in code 
    - Rules endpoints marked deprecated in code/docs
    - `client.domains.create_domain` and `client.domains.delete_domain` marked deprecated in code/docs
- [ ] Fix URL path inconsistencies between SDK and OpenAPI specification
- [x] Add optional query parameter support:
    - `messages.fetch_inbox_message` now supports optional `delete`
    - `messages.fetch_sms_message` now supports inbox listing query params (`skip`, `limit`, `sort`, `decode_subject`, `cursor`, `full`, `wait`, `delete`)
- [ ] Implement Streaming Messages endpoint (`/api/v2/domains/private/stream/` and inbox variant) with supported query params (`full`, `limit`, `throttleInterval`, `delete`)
- [ ] Fix integration test bug: custom-service webhook tests use `@webhookTokenPrivateDomain` instead of `@webhookTokenCustomService`
- [ ] Decide policy for flaky/500-prone integration flows (`messages.fetch_inbox` with `full`/`wait`, and `webhooks.private_webhook`) and gate or quarantine accordingly
- [ ] Publish those changes
