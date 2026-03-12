# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project aims to follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Changed

- Removed `wait` query parameter from `messages.fetch_sms_message` because the endpoint does not support it.
- Added `messages.fetch_message_summary` for `GET /api/v2/domains/{domain}/messages/{messageId}/summary`.
- Added `messages.fetch_message_text` for `GET /api/v2/domains/{domain}/messages/{messageId}/text`.
- Removed `wait` query parameter from `messages.fetch_inbox`.
- Fixed `webhooks.private_webhook` to include the webhook payload in the request body.
- Debugging and test updates.
- Made attachment download tests derive attachment IDs from the attachments list, removing the need for `MAILINATOR_TEST_ATTACHMENT_ID`.

## [1.0.7]

### Added

- Optional `delete` query parameter support to `messages.fetch_inbox_message`.
- Inbox-list query parameters to `messages.fetch_sms_message` (`skip`, `limit`, `sort`, `decode_subject`, `cursor`, `full`, `delete`).
- `.env.example` with Mailinator integration test variables.
- Resource-scoped integration test files:
  - `test/authenticators_api_test.rb`
  - `test/domains_api_test.rb`
  - `test/messages_api_test.rb`
  - `test/rules_api_test.rb`
  - `test/stats_api_test.rb`
  - `test/webhooks_api_test.rb`
- Focused query-parameter regression tests in `test/messages_query_params_test.rb`.

### Deprecated

- Marked all Rules endpoints as deprecated:
  - `client.rules.create_rule`
  - `client.rules.enable_rule`
  - `client.rules.disable_rule`
  - `client.rules.get_all_rules`
  - `client.rules.get_rule`
  - `client.rules.delete_rule`
- Marked Domain mutation endpoints as deprecated:
  - `client.domains.create_domain`
  - `client.domains.delete_domain`
- Added deprecation markers in code (`lib/mailinator_client/rules.rb`) and deprecation notices in docs (`docs/rules.md`, `README.md`).

### Changed

- Updated dependency constraints:
  - Runtime: `httparty` to `>= 0.21, < 0.22` (Ruby 2.6-compatible)
  - Development: `minitest >= 5.25, < 7.0`, `rake >= 13.0, < 14.0`, `webmock >= 3.26, < 4.0`
- Updated integration testing structure by splitting the previous monolithic `test/mailinator_client_api_test.rb`.
- Added `.env` loading support in `test/test_helper.rb`.
- Hardened API error handling for non-JSON/empty error responses:
  - `MailinatorClient::ResponseError` now handles `nil` parsed responses safely.
  - `Client#request` now passes raw response body into `ResponseError`.
