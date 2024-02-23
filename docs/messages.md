# Messages Actions

Details on the various actions that can be performed on the Messages resource, including the expected parameters and the potential responses.

##### Contents

*   [FetchInbox](#fetchinbox)
*   [FetchInboxMessage](#fetchinboxmessage)
*   [FetchMessage](#fetchmessage)
*   [FetchSMSMessage](#fetchsmsmessage)
*   [FetchInboxMessageAttachments](#fetchinboxmessageattachments)
*   [FetchMessageAttachments](#fetchmessageattachments)
*   [FetchInboxMessageAttachment](#fetchinboxmessageattachment)
*   [FetchMessageAttachment](#fetchmessageattachment)
*   [FetchMessageLinks](#fetchmessagelinks)
*   [FetchInboxMessageLinks](#fetchinboxmessagelinks)
*   [DeleteAllDomainMessages](#deletealldomainmessages)
*   [DeleteAllInboxMessages](#deleteallinboxmessages)
*   [DeleteMessage](#deletemessage)
*   [PostMessage](#postmessage)
*   [FetchMessageSmtpLog](#fetchmessagesmtplog)
*   [FetchInboxMessageSmtpLog](#fetchinboxmessagesmtplog)
*   [FetchMessageRaw](#fetchmessageraw)
*   [FetchInboxMessageRaw](#fetchinboxmessageraw)
*   [FetchLatestMessages](#fetchlatestmessages)
*   [FetchLatestInboxMessages](#fetchlatestinboxmessages)

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

## FetchInboxMessage

Retrieves a specific message by id for specific inbox

```ruby
result = client.messages.fetch_inbox_message(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>

## FetchMessage

Retrieves a specific message by id

```ruby
result = client.messages.fetch_message(
  domainId: my_domain_id
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


## FetchInboxMessageAttachments

Retrieves a list of attachments for a message for specific inbox

```ruby
result = client.messages.fetch_inbox_message_attachments(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>

## FetchMessageAttachments

Retrieves a list of attachments for a message

```ruby
result = client.messages.fetch_message_attachments(
  domainId: my_domain_id
  messageId: my_message_id)

puts result
```

<br/>


## FetchInboxMessageAttachment

Retrieves a specific attachment for specific inbox

```ruby
result = client.messages.fetch_inbox_message_attachment(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id
  attachmentId: my_attachment_id)

puts result
```

<br/>

## FetchMessageAttachment

Retrieves a specific attachment

```ruby
result = client.messages.fetch_message_attachment(
  domainId: my_domain_id
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
  messageId: my_message_id)

puts result
```

<br/>

## FetchInboxMessageLinks

Retrieves all links found within a given email for specific inbox

```ruby
result = client.messages.fetch_inbox_message_links(
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


## PostMessage

Deliver a JSON message into your private domain

```ruby
result = client.messages.post_message(
  domainId: my_domain_id
  inbox: my_inbox
  messageToPost: my_message_to_post)

puts result
```

<br/>


## FetchMessageSmtpLog

Retrieves all smtp log found within a given email

```ruby
result = client.messages.fetch_message_smtp_log(
  domainId: my_domain_id
  messageId: my_message_id)

puts result
```

<br/>

## FetchInboxMessageSmtpLog

Retrieves all smtp log found within a given email for specific inbox

```ruby
result = client.messages.fetch_inbox_message_smtp_log(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## FetchMessageRaw

Retrieves all raw data found within a given email

```ruby
result = client.messages.fetch_message_raw(
  domainId: my_domain_id
  messageId: my_message_id)

puts result
```

<br/>

## FetchInboxMessageLinks

Retrieves all raw data found within a given email for specific inbox

```ruby
result = client.messages.fetch_inbox_message_raw(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```

<br/>


## FetchLatestMessages

That fetches the latest 5 FULL messages

```ruby
result = client.messages.fetch_latest_messages(
  domainId: my_domain_id
  messageId: my_message_id)

puts result
```

<br/>

## FetchLatestInboxMessages

That fetches the latest 5 FULL messages for specific inbox

```ruby
result = client.messages.fetch_latest_inbox_messages(
  domainId: my_domain_id
  inbox: my_inbox
  messageId: my_message_id)

puts result
```
