# Domains Actions

Details on the various actions that can be performed on the Domains resource, including the expected parameters and the potential responses.

##### Contents

*   [GetDomains](#getdomains)
*   [GetDomain](#getdomain)

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
