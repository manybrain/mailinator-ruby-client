# Messages Actions

Details on the various actions that can be performed on the Messages resource, including the expected parameters and the potential responses.

##### Contents

*   [FetchInbox](#fetchinbox)
*   [FetchMessage](#fetchmessage)
*   [FetchSMSMessage](#fetchsmsmessage)
*   [FetchAttachments](#fetchattachments)
*   [FetchAttachment](#fetchattachment)
*   [FetchMessageLinks](#fetchmessagelinks)
*   [DeleteAllDomainMessages](#deletealldomainmessages)
*   [DeleteAllInboxMessages](#deleteallinboxmessages)
*   [DeleteMessage](#deletemessage)
*   [InjectMessage](#injectmessage)

<br/>

## FetchInbox

Retrieves a list of messages summaries

```ruby
result = client.messages.fetch_inbox(
  domainId: my_domain_id
  inbox: my_inbox
  skip: my_skip
  limit: my_limit
  sort: my_sort
  decodeSubject: my_decode_subject)

puts result
```

<br/>

## FetchMessage

Retrieves a specific message by id

```ruby
result = client.messages.fetch_inbox(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## FetchSMSMessage

Retrieves a specific SMS message by sms number

```ruby
result = client.messages.fetch_sms_message(
  domainId: my_domain_id
  inbox: my_inbox
  teamSmsNumber: my_team_sms_number)

puts result
```

<br/>


## FetchAttachments

Retrieves a list of attachments for a message

```ruby
result = client.messages.fetch_attachments(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## FetchAttachment

Retrieves a specific attachment

```ruby
result = client.messages.fetch_attachment(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id
  attachmentId: my_attachment_id)

puts result
```

<br/>


## FetchMessageLinks

Retrieves all links found within a given email

```ruby
result = client.messages.fetch_message_links(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## DeleteAllDomainMessages

Deletes ALL messages from a Private Domain

```ruby
result = client.messages.delete_all_domain_messages(
  domainId: my_domain_id)

puts result
```

<br/>


## DeleteAllInboxMessages

Deletes ALL messages from a specific private inbox

```ruby
result = client.messages.delete_all_inbox_messages(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## DeleteMessage

Deletes a specific messages

```ruby
result = client.messages.delete_message(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## InjectMessage

Deliver a JSON message into your private domain

```ruby
result = client.messages.inject_message(
  domainId: my_domain_id
  inbox: my_inbox
  messageToPost: my_message_to_post)

puts result
```
