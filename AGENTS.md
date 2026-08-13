All AI agents (Codex, Copilot, Antigravity) must follow this file and the rules in `.agent/rules/`.

# Project Standards and Agent Behavior

- **Language and tests:** This is a Ruby SDK tested with Minitest.
- **Primary workflow:** Use the `.agent/tdd-flow` skill for feature implementation and bug fixes, subject to `.agent/rules/tdd.md`.
- **Test style:** Write behavior-driven assertions. Endpoint integration tests must use real HTTP requests; do not mock them.
- **Skipped tests:** Never infer or change implementation for a skipped test. Leave the underlying code untouched.
- **OpenAPI source of truth:** Use the [Mailinator OpenAPI specification](https://raw.githubusercontent.com/manybrain/mailinatordocs/main/openapi/mailinator-api.yaml).
- **Spec strictness:** Only assert behavior and properties explicitly defined by the OpenAPI specification. Do not invent validations. Flag ambiguities or gaps for human review.
- **Request paths:** Resource wrappers use paths relative to `https://api.mailinator.com/api/v2`; do not include `/api/v2` or `/v2` in resource method paths.
- **Gap-analysis changes:** Follow `docs/openapi-maintenance.md`. Present the implementation plan and wait for approval before changing SDK coverage.

# Project References

- `docs/openapi-maintenance.md` documents the SDK architecture, conventions, and OpenAPI gap-analysis workflow.
- `ROADMAP.md` tracks known gaps and planned improvements.
