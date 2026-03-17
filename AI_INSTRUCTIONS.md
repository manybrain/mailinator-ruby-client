# AI Instructions

This document explains the relationship between this Ruby client and the Mailinator OpenAPI specification.

**OpenAPI Specification:** [Found on GitHub](https://github.com/manybrain/mailinatordocs/blob/main/openapi/mailinator-api.yaml)

## Codebase Structure

The codebase structure in `lib/mailinator_client/` reflects Mailinator API resource groups.

-   **Entrypoints:**
    -   `lib/mailinator_client.rb` loads all components and provides module-level delegation to a singleton `Client`.
    -   `lib/mailinator_client/client.rb` defines the HTTP execution path and shared request behavior.
-   **Resource wrappers:** API resources live in peer files under `lib/mailinator_client/`:
    -   `authenticators.rb` for authenticator endpoints.
    -   `domains.rb` for domain endpoints.
    -   `messages.rb` for inbox/message endpoints.
    -   `rules.rb` for rule endpoints.
    -   `stats.rb` for team/stat endpoints.
    -   `webhooks.rb` for webhook injection endpoints.
-   **Support files:**
    -   `utils.rb` normalizes input/query structures.
    -   `error.rb` defines `ResponseError`.
    -   `version.rb` defines gem version metadata used in user agent headers.

## Request Patterns

This client uses a **resource wrapper** pattern, not per-operation request classes.

-   Each resource class exposes Ruby methods (for example, `fetch_inbox`, `get_domains`, `create_rule`) that:
    -   accept a params hash,
    -   validate required keys with `ArgumentError`,
    -   construct `path`, `query`, and optional `body`,
    -   call `@client.request(...)`.
-   Method names are snake_case and generally map to one API operation each.
-   Paths are resource-relative and are joined to the client base URL (`https://api.mailinator.com/api/v2`) inside `Client#request`.

## Execution

Requests are executed through `MailinatorClient::Client#request`, which uses `HTTParty`.

```ruby
client = MailinatorClient::Client.new(auth_token: "api_token")
response = client.messages.fetch_inbox(domain: "domain.com", inbox: "inbox_name")
```

Execution flow:
-   Resource method builds request inputs (`method`, `path`, `query`, `headers`, `body`).
-   `Client#request` appends the path to `https://api.mailinator.com/api/v2`.
-   `HTTParty.send` performs the HTTP call with JSON headers and optional authorization.
-   Non-2xx/3xx responses raise `MailinatorClient::ResponseError`.

## Entities

This Ruby SDK mostly returns parsed response hashes/arrays directly, rather than strongly typed model classes.

-   API responses are returned as Ruby data structures from `HTTParty` (`Hash`/`Array`).
-   Error responses are wrapped in `MailinatorClient::ResponseError` with:
    -   `code` (HTTP status),
    -   `type` (error type from API payload),
    -   exception message from the API response.
-   Request inputs are plain Ruby hashes, typically normalized by `Utils.symbolize_hash_keys`.

---

## Gap Analysis Workflow

Use this workflow whenever you want to audit the SDK against the OpenAPI spec, identify missing or extra coverage, and bring the two into alignment.

### Step 1 — Fetch the OpenAPI Specification

Retrieve the raw YAML from:

```
https://raw.githubusercontent.com/manybrain/mailinatordocs/main/openapi/mailinator-api.yaml
```

> The rendered GitHub page is at https://github.com/manybrain/mailinatordocs/blob/main/openapi/mailinator-api.yaml
> but always read the **raw** URL for machine parsing.

Extract every `paths` entry. For each path, record:
- The HTTP method (`get`, `post`, `put`, `delete`, etc.)
- The full path string (e.g. `/api/v2/domains/{domain}/inboxes/{inbox}`)
- The `operationId`
- The tag (maps to the SDK module directory)
- All query parameters defined under `parameters`

### Step 2 — Catalog the SDK

For each resource file under `lib/mailinator_client/` (`messages.rb`, `domains.rb`, `rules.rb`, etc.):
1. Enumerate every public method that issues `@client.request(...)`.
2. Identify the HTTP method (`:get`, `:post`, `:put`, `:delete`).
3. Extract the `path` template used by that method.
4. Record query parameters populated in `query_params`.
5. Note methods already marked deprecated in comments/docs.

Also map resource files to OpenAPI tags and check if any tag has no SDK wrapper.

### Step 3 — Identify Gaps

Produce a gap report with four sections:

#### A. In the spec but missing from the SDK
List every `operationId` that has no corresponding Ruby method. This is what needs to be **added**.

#### B. In the SDK but not in the spec
List every SDK method whose path+method has no matching entry in the spec.
- If it is already marked deprecated, note that separately.
- If it is not deprecated but absent from the spec, flag it for clarification (it may be undocumented).

#### C. URL path mismatches
Compare the base path used by each SDK method against the spec.
- The spec base URL is `https://api.mailinator.com` and all paths start with `/api/v2/`.
- The SDK **must** use `/api/v2/` not `/v2/`. Flag any method/path using the wrong prefix.

#### D. Query parameter gaps
For each existing SDK method, compare sent query parameters against the spec's declared parameters for that operation. List any missing parameters.

#### Exception — Domain Listing
The OpenAPI operation `GET /api/v2/domains/{domain}/inboxes` (list domain messages) is considered **covered** by `messages.fetch_inbox` when called with `inbox: "*"`. Do not treat this as a missing SDK method in future gap analyses.

### Step 4 — Build a Plan

Before making any changes, write out a plan that includes:

1. **New methods to add** — one method per missing `operationId`, grouped by resource file.
2. **URL fixes** — list every file where the prefix needs to change from `/v2/` to `/api/v2/`.
3. **Query parameter additions** — list every file and which parameters to add.
4. **Deprecated methods** — decide whether to keep and mark as deprecated or remove. Do not remove without confirmation.
5. **Response/entity notes** — list response shape expectations or wrappers needed for consistency.

Present the plan to the user and wait for approval before proceeding.

### Step 5 — Implement

Follow the existing patterns in the codebase:

#### Adding a new method

Use an existing method in the matching resource file as a template.

```ruby
def get_example(params = {})
  params = Utils.symbolize_hash_keys(params)
  query_params = {}
  headers = {}
  body = nil

  raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
  raise ArgumentError.new("id is required") unless params.has_key?(:id)

  path = "/domains/#{params[:domain]}/examples/#{params[:id]}"

  @client.request(
    method: :get,
    path: path,
    query: query_params,
    headers: headers,
    body: body
  )
end
```

Key rules:
- **Always** use `/api/v2/` as the path prefix — never `/v2/`.
- Keep methods in the appropriate resource file (`messages.rb`, `rules.rb`, etc.).
- Validate required params with `ArgumentError`.
- Use snake_case method names and preserve existing naming conventions in the file.

#### Fixing a URL prefix

If any hardcoded URL includes `/v2/`, change it to `/api/v2/`. Prefer resource-relative `path` values (`/domains/...`) and let `Client#request` prepend base URL.

#### Adding a missing query parameter

Add an assignment in the method's query assembly:
```ruby
query_params[:my_param] = params[:myParam] if params.has_key?(:myParam)
```
Then document the optional parameter in the method comment block.

### Step 6 — Verify

After implementing:
1. Run tests: `ruby -I test test/mailinator_client_api_test.rb` (with required env vars).
2. Run lint/static checks if configured for this repo.
3. Manually verify at least one changed method generates the exact spec path and sends expected query params.

### Notes on SDK Conventions

| Convention | Detail |
|---|---|
| Version source | `lib/mailinator_client/version.rb` (`MailinatorClient::VERSION`), referenced by gemspec and user-agent string. |
| Auth header | Set in `Client#request` as `Authorization` when `auth_token` is provided. |
| No-token requests | Supported by instantiating `Client` without `auth_token` (used by some webhook flows). |
| Deprecation marker | Use Ruby/YARD style deprecation comments near method definitions and reflect in README/docs. |
| Entrypoint loading | `lib/mailinator_client.rb` requires resource/support files and delegates module methods to singleton client. |

### Test Expectations

- Integration tests should exercise real HTTP requests to Mailinator endpoints. Do not use request-mocking tools (for example, `WebMock.stub_request`) for endpoint coverage tests.
- Assertions must validate response semantics, not just existence. Prefer checking:
  - expected HTTP success behavior (or explicit failure with returned status code),
  - expected JSON shape (required keys),
  - important field-level values (for example, IDs or arrays) relevant to the endpoint contract.
