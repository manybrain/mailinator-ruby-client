# Roadmap

This document tracks planned improvements for the Mailinator Ruby client.

## Phase 1

- [x] Add structural docs (`ROADMAP.md`, `CHANGELOG.md`, `AI_INSTRUCTIONS.md`, `EXAMPLEs.md`) - completed
- [ ] Update outdated dependencies
- [x] Update version number - completed (`1.0.7`)
- [ ] Publish those changes (minor release)

## Next

- [ ] Mark deprecated endpoints as deprecated in code 
    - Rules endpoints marked deprecated in code/docs
- [ ] Fix URL path inconsistencies between SDK and OpenAPI specification
- [ ] Add optional `delete` query parameter to the "Get an inbox" method
- [ ] Implement Streaming Messages endpoint (`/api/v2/domains/private/stream/` and inbox variant) with supported query params (`full`, `limit`, `throttleInterval`, `delete`)
- [ ] Publish those changes
