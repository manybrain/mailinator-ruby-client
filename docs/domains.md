# Domains Actions

Details on the various actions that can be performed on the Domains resource, including the expected parameters and the potential responses.

##### Contents

*   [GetDomains](#getdomains)
*   [GetDomain](#getdomain)
*   [CreateDomain](#createdomain)
*   [DeleteDomain](#deletedomain)

<br/>

## GetDomains

Fetches a list of all your domains

```ruby
result = client.domains.get_domains()

puts result
```

<br/>

## GetDomain

Fetches a specific domain

```ruby
result = client.domains.get_domain(domainId: my_domain_id)

puts result
```

<br/>

## CreateDomain

This endpoint creates a private domain attached to your account. Note, the domain must be unique to the system and you must have not reached your maximum number of Private Domains.

```ruby
result = client.domains.create_domain(domainId: my_domain_id)

puts result
```

<br/>

## DeleteDomain

This endpoint deletes a Private Domain

```ruby
result = client.domains.delete_domain(domainId: my_domain_id)

puts result
```
