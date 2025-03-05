# Webhooks Actions

Details on the various actions that can be performed on the Webhooks resource, including the expected parameters and the potential responses.

##### Contents

*   [PrivateWebhook](#privatewebhook)
*   [PrivateInboxWebhook](#privateinboxwebhook)
*   [PrivateCustomServiceWebhook](#privatecustomservicewebhook)
*   [PrivateCustomServiceInboxWebhook](#privatecustomserviceinboxwebhook)

<br/>

## PrivateWebhook

This command will Webhook messages into your Private Domain
The incoming Webhook will arrive in the inbox designated by the "to" field in the incoming request payload.
Webhooks into your Private System do NOT use your regular API Token.
This is because a typical use case is to enter the Webhook URL into 3rd-party systems(i.e.Twilio, Zapier, IFTTT, etc) and you should never give out your API Token.
Check your Team Settings where you can create "Webhook Tokens" designed for this purpose.
    
```ruby
result = client.webhooks.private_webhook()

puts result
```

<br/>

## PrivatePublicInboxWebhook

This command will deliver the message to the :inbox inbox
Incoming Webhooks are delivered to Mailinator inboxes and from that point onward are not notably different than other messages in the system (i.e. emails). 
As normal, Mailinator will list all messages in the Inbox page and via the Inbox API calls. 
If the incoming JSON payload does not contain a "from" or "subject", then dummy values will be inserted in these fields.
You may retrieve such messages via the Web Interface, the API, or the Rule System

```ruby
result = client.webhooks.private_inbox_webhook()

puts result
```

<br/>

## PrivateCustomServiceWebhook

If you have a Twilio account which receives incoming SMS messages. You may direct those messages through this facility to inject those messages into the Mailinator system.
Mailinator intends to apply specific mappings for certain services that commonly publish webhooks.
If you test incoming Messages to SMS numbers via Twilio, you may use this endpoint to correctly map "to", "from", and "subject" of those messages to the Mailinator system.By default, the destination inbox is the Twilio phone number.
    
```ruby
result = client.webhooks.private_custom_service_webhook()

puts result
```

<br/>

## PrivateCustomServiceInboxWebhook

The SMS message will arrive in the Private Mailinator inbox corresponding to the Twilio Phone Number. (only the digits, if a plus sign precedes the number it will be removed) 
If you wish the message to arrive in a different inbox, you may append the destination inbox to the URL.
        
```ruby
result = client.webhooks.private_custom_service_inbox_webhook()

puts result
```
