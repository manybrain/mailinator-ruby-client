# Roadmap

This document tracks completed work, current gaps, and planned improvements for the Mailinator Ruby client.

Gap analysis source of truth: Mailinator OpenAPI spec (`version: 2026-03-04`) from:
`https://raw.githubusercontent.com/manybrain/mailinatordocs/main/openapi/mailinator-api.yaml`

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

Webhooks (`lib/mailinator_client/webhooks.rb`):
- [ ] Add domain-scoped webhook methods matching spec routes
- [ ] Keep existing private-webhook methods for backward compatibility until deprecation decision is approved

- [ ] Fix messages_api_test.rb. Split up into multiple files if needed to isolate new test cases and avoid timeouts. Assert on the body of the responses. 
- [ ] Fix integration test bug: use `MAILINATOR_TEST_WEBHOOKTOKEN_CUSTOMSERVICE` for custom-service webhook tests
- [ ] Add explicit assertions for custom-service webhook calls
- [ ] Update README/docs links to current API reference and remove stale `manybrain.github.io/m8rdocs` links
- [ ] Align docs arg naming with SDK (`domain`, `inbox`, `messageId`)


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

## Completed (Phase 2)

### Added Missing Spec Endpoints

Messages (`lib/mailinator_client/messages.rb`):
- [x] Add `fetch_message_summary` for `GET /domains/{domain}/messages/{messageId}/summary`
- [x] Add `fetch_message_text` for `GET /domains/{domain}/messages/{messageId}/text`
- [x] Add `fetch_message_text_plain` for `GET /domains/{domain}/messages/{messageId}/textplain`
- [x] Add `fetch_message_text_html` for `GET /domains/{domain}/messages/{messageId}/texthtml`
- [x] Add `fetch_message_headers` for `GET /domains/{domain}/messages/{messageId}/headers`
- [x] Add `stream_domain_messages` for `GET /domains/{domain}/stream`
- [x] Add `stream_inbox_messages` for `GET /domains/{domain}/stream/{inbox}`
- [x] Add `list_domain_messages` for `GET /domains/{domain}/inboxes` (covered by `messages.fetch_inbox` with `inbox: "*"`)

Note: We are intentionally not adding a separate SDK method for `GET /domains/{domain}/inboxes`. The existing `messages.fetch_inbox` with `inbox: "*"` provides equivalent domain-wide listing. Future gap analyses should treat this as covered.