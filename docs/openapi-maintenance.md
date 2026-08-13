# OpenAPI Maintenance

This document describes the Ruby client's architecture and the workflow for auditing it against the Mailinator OpenAPI specification.

**OpenAPI specification:** [raw YAML](https://raw.githubusercontent.com/manybrain/mailinatordocs/main/openapi/mailinator-api.yaml) ([GitHub view](https://github.com/manybrain/mailinatordocs/blob/main/openapi/mailinator-api.yaml))

## Codebase Structure

The structure under `lib/mailinator_client/` reflects Mailinator API resource groups.

- `lib/mailinator_client.rb` loads all components and delegates module-level calls to a singleton `Client`.
- `lib/mailinator_client/client.rb` implements shared HTTP request behavior.
- `authenticators.rb`, `domains.rb`, `messages.rb`, `rules.rb`, `stats.rb`, and `webhooks.rb` contain resource wrappers.
- `utils.rb` normalizes input and query structures.
- `error.rb` defines `ResponseError`.
- `version.rb` defines gem version metadata used in user-agent headers.

## Request and Response Conventions

The client uses resource wrappers rather than per-operation request classes. Each resource method generally:

1. Accepts a params hash and normalizes its keys with `Utils.symbolize_hash_keys`.
2. Validates required keys with `ArgumentError`.
3. Constructs a resource-relative `path`, `query`, and optional `body`.
4. Calls `@client.request(...)`.

`Client#request` joins resource-relative paths such as `/domains/example.com/inboxes/test` to the base URL `https://api.mailinator.com/api/v2`. Resource methods must not include `/api/v2` or `/v2` in their paths.

Requests use HTTParty with JSON headers and optional authorization. Responses with status codes of 400 or higher raise `MailinatorClient::ResponseError`, which exposes the HTTP `code`, API error `type`, and response message.

The SDK generally returns parsed Hash and Array values rather than typed model objects.

## Gap Analysis Workflow

Use this workflow to identify differences between the OpenAPI specification and SDK coverage.

### 1. Read the OpenAPI Specification

Retrieve and parse the raw YAML linked above. For every `paths` entry, record:

- HTTP method
- Full specification path
- `operationId`
- Tag
- Path and query parameters
- Request and response schemas relevant to implementation and tests

### 2. Catalog the SDK

For each resource wrapper under `lib/mailinator_client/`:

1. Enumerate every public method that calls `@client.request(...)`.
2. Record its HTTP method and resource-relative path template.
3. Record the query parameters it sends.
4. Note methods marked as deprecated.
5. Map the resource file to the corresponding OpenAPI tag.

### 3. Report Gaps

Report these categories:

#### Operations missing from the SDK

List specification operations with no corresponding Ruby method.

#### SDK operations missing from the specification

List SDK methods whose resolved path and HTTP method have no specification entry. Note deprecated methods separately; flag other methods for clarification.

#### URL construction mismatches

The specification paths begin with `/api/v2/`, while SDK resource methods use paths relative to the client's `/api/v2` base URL. Flag:

- A client base URL that does not end in `/api/v2`.
- Resource paths containing `/api/v2` or `/v2`, which would duplicate or bypass the client base path.
- Resolved SDK URLs that do not match the specification path.

#### Parameter gaps

For each matched operation, compare the SDK's path and query parameters with those declared by the specification.

#### Domain-listing exception

Treat `GET /api/v2/domains/{domain}/inboxes` as covered by `messages.fetch_inbox` with `inbox: "*"`. Do not report it as a missing SDK method.

### 4. Propose a Plan

Before changing code, present a plan containing:

1. New methods, grouped by resource file.
2. URL-construction fixes.
3. Parameter additions.
4. Deprecated or undocumented methods, without removing them unless explicitly approved.
5. Response-shape expectations grounded in the specification.

Wait for approval before implementing SDK coverage changes.

### 5. Implement

Follow the patterns already present in the matching resource wrapper:

```ruby
def get_example(params = {})
  params = Utils.symbolize_hash_keys(params)
  query_params = {}
  headers = {}
  body = nil

  raise ArgumentError, "domain is required" unless params.has_key?(:domain)
  raise ArgumentError, "id is required" unless params.has_key?(:id)

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

Keep methods in the appropriate resource file, use snake_case method names, preserve the parameter naming conventions of that file, and document optional parameters.

## Verification

Run the complete suite:

```sh
bundle exec rake test
```

Run a focused test when appropriate:

```sh
bundle exec ruby -Itest test/messages_query_params_test.rb
```

Integration tests load local values from `.env` and skip when their required variables are missing. For each changed operation, verify that the resolved URL and query parameters exactly match the specification. Assertions must test response semantics and only fields guaranteed by the specification.

## Additional Conventions

| Convention | Detail |
|---|---|
| Version source | `MailinatorClient::VERSION` in `lib/mailinator_client/version.rb`, referenced by the gemspec and user-agent string |
| Authorization | `Client#request` adds the `Authorization` header when an auth token is provided |
| No-token requests | Supported for flows such as some webhook operations |
| Deprecation | Use Ruby/YARD comments and reflect the status in user-facing documentation |
| Entrypoint | `lib/mailinator_client.rb` requires resource and support files and delegates to the singleton client |
