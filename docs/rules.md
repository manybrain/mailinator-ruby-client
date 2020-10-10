# Rules Actions

Details on the various actions that can be performed on the Rules resource, including the expected parameters and the potential responses.

##### Contents

*   [CreateRule](#createrule)
*   [EnableRule](#enablerule)
*   [DisableRule](#disablerule)
*   [GetAllRules](#getallrules)
*   [GetRule](#getrule)
*   [DeleteRule](#deleterule)

<br/>

## CreateRule

Creates a Rule

```ruby
result = client.rules.create_rule(
  domainId: my_domain_id,
  ruleToPost: my_rule_to_post
)

puts result
```

<br/>

## EnableRule

Enables an existing Rule

```ruby
result = client.rules.enable_rule(
  domainId: my_domain_id
  ruleId: my_rule_id)

puts result
```

<br/>

## DisableRule

Disables an existing Rule

```ruby
result = client.rules.disable_rule(
  domainId: my_domain_id
  ruleId: my_rule_id)

puts result
```

<br/>

## GetAllRules

Fetches all Rules for a Domain

```ruby
result = client.rules.get_all_rules(domainId: my_domain_id)

puts result
```

<br/>

## GetRule

Fetches a specific rule for a Domain

```ruby
result = client.rules.get_rule(
  domainId: my_domain_id
  ruleId: my_rule_id)

puts result
```

<br/>

## DeleteRule

Deletes a specific rule for a Domain

```ruby
result = client.rules.delete_rule(
  domainId: my_domain_id
  ruleId: my_rule_id)

puts result
```
