# Roadmap

This document tracks completed work, current gaps, and planned improvements for the Mailinator Ruby client.

Gap analysis source of truth: Mailinator OpenAPI spec (`version: 2026-03-04`) from:
`https://raw.githubusercontent.com/manybrain/mailinatordocs/main/openapi/mailinator-api.yaml`

## Completed (Phase 1)

- [x] Add structural docs (`ROADMAP.md`, `CHANGELOG.md`, `AI_INSTRUCTIONS.md`, `EXAMPLES.md`)
- [x] Update outdated dependencies (`rake` and `webmock`; `httparty` pinned to latest Ruby 2.6-compatible range)
- [x] Update version number (`1.0.7`)
- [x] Publish those changes (minor release)
- [x] Add optional query parameter support:
  - `messages.fetch_inbox_message` supports optional `delete`
  - `messages.fetch_sms_message` supports inbox listing query params (`skip`, `limit`, `sort`, `decode_subject`/`decodeSubject`, `cursor`, `full`, `wait`, `delete`)
- [x] Mark deprecated endpoints as deprecated in code/docs:
  - Rules endpoints
  - `client.domains.create_domain` and `client.domains.delete_domain`

## Next Release Plan (Phase 2)

### 1. Add Missing Spec Endpoints

Messages (`lib/mailinator_client/messages.rb`):
- [ ] Add `list_domain_messages` for `GET /domains/{domain}/inboxes`
- [x] Add `fetch_message_summary` for `GET /domains/{domain}/messages/{messageId}/summary`
- [ ] Add `fetch_message_text` for `GET /domains/{domain}/messages/{messageId}/text`
- [ ] Add `fetch_message_text_plain` for `GET /domains/{domain}/messages/{messageId}/textplain`
- [ ] Add `fetch_message_text_html` for `GET /domains/{domain}/messages/{messageId}/texthtml`
- [ ] Add `fetch_message_headers` for `GET /domains/{domain}/messages/{messageId}/headers`
- [ ] Add `stream_domain_messages` for `GET /domains/{domain}/stream`
- [ ] Add `stream_inbox_messages` for `GET /domains/{domain}/stream/{inbox}`

Webhooks (`lib/mailinator_client/webhooks.rb`):
- [ ] Add domain-scoped webhook methods matching spec routes
- [ ] Keep existing private-webhook methods for backward compatibility until deprecation decision is approved

### 2. Test and Docs Follow-Through

- [ ] Add unit tests for all new methods (path, HTTP verb, params)
- [ ] Fix integration test bug: use `MAILINATOR_TEST_WEBHOOKTOKEN_CUSTOMSERVICE` for custom-service webhook tests
- [ ] Add explicit assertions for custom-service webhook calls
- [ ] Update README/docs links to current API reference and remove stale `manybrain.github.io/m8rdocs` links
- [ ] Align docs arg naming with SDK (`domain`, `inbox`, `messageId`)

## Hardening (Phase 3)

- [ ] Produce and maintain endpoint coverage matrix (OpenAPI operationId -> SDK method)
- [ ] Add CI check to detect future OpenAPI drift against SDK path+method map
- [ ] Define policy for operations present in SDK but missing from spec:
  - [ ] keep + mark deprecated
  - [ ] keep + annotate as undocumented
  - [ ] remove in next major release (requires explicit approval)
- [ ] Define policy for flaky/500-prone integration flows (`messages.fetch_inbox` with `full`/`wait`, `webhooks.private_webhook`):
  - [ ] gate by env vars and/or quarantine tags
  - [ ] separate smoke and full integration suites

## Definition of Done for Next Release

- [ ] All 10 missing spec operations implemented or explicitly waived with rationale.
- [ ] Webhook token integration test bug fixed.
- [ ] Documentation link and parameter consistency cleanup completed.
- [ ] New/updated tests pass in CI and local unit suite.
