# Mailinator Ruby REST API Client

[![Build Status](https://travis-ci.org/manybrain/mailinator-ruby-client.svg?branch=master)](https://travis-ci.org/manybrain/mailinator-ruby-client)  [![Gem Version](https://badge.fury.io/rb/mailinator_client.svg)](https://badge.fury.io/rb/mailinator_client)

The [Mailinator](https://www.mailinator.com/) REST API client provides a simple way to use the comprehensive Mailinator API.

This client works with Ruby 2.1 and higher. It uses [HTTParty](https://github.com/jnunemaker/httparty) under the covers for the actual HTTP communication.

<br/>

## Installation

The latest stable version is available in RubyGems and can be installed using

```bash
gem install mailinator_client
```

<br/>

## API Documentation

### MailinatorClient

MailinatorClient is the wrapping module, but it also acts as a singleton [Client](#mailinatorclient) instance. So if you only need a single client instance, you do not need to instantiate one yourself - the MailinatorClient module will act exactly like an instance of MailinatorClient::Client.

<br/>

### MailinatorClient::Client

A client is a single api instance. By default, it is unauthenticated, but can be given an access token to perform authenticated requests.

#### Initializer

```ruby
MailinatorClient::Client.new(auth_token: nil)
```

The ``Client()`` initializer takes the following arguments:

* auth_token  
  The access token to be used for authentication - by default there is no access token.

#### Resources

Each of the following is a method on the client object, and returns a wrapper for the actions against that particular resource. See each resource documentation file for more information.

* [domains](docs/domains.md)  
  Contains all of the actions that can be performed against the set of [Domains](https://manybrain.github.io/m8rdocs/#domains-api) that the currently authenticated user has access to - such as listing the domains.

* [stats](docs/stats.md)  
  Contains all of the actions that can be performed against the set of [Stats](https://manybrain.github.io/m8rdocs/#stats-api) that the currently authenticated user has access to - such as listing the team stats.

* [rules](docs/rules.md)  
  Contains all of the actions that can be performed against the set of [Rules](https://manybrain.github.io/m8rdocs/#rules-api) that the currently authenticated user has access to - such as listing the rules or creating a new rule.

* [messages](docs/messages.md)  
  Contains all of the actions that can be performed against the set of [Messages](https://manybrain.github.io/m8rdocs/#message-api) that the currently authenticated user has access to - such as listing the messages or injecting a new message.

<br/>

### MailinatorClient::ResponseError

When the Mailinator API returns a unsuccessful response, an instance of ResponseError is thrown.

#### ResponseError Accessors

* code  
  The status code returned from the Mailinator API.

* type  
  The type of error that occurred, such as "Authorization".

* message  
  A more detailed message about the particulars of the error.

<br/>

## Testing

Run integration tests with real API Key.

```ruby
ruby -I test test/mailinator_client_api_test.rb
```

Most of the tests require env variables with valid values. Visit tests source code and review `mailinator_client_api_test.rb` file. The more env variables you set, the more tests are run.

* `MAILINATOR_TEST_API_TOKEN` - API tokens for authentication; basic requirement across many tests;see also https://manybrain.github.io/m8rdocs/#api-authentication
* `MAILINATOR_TEST_INBOX` - some already existing inbox within the private domain
* `MAILINATOR_TEST_PHONE_NUMBER` - associated phone number within the private domain; see also https://manybrain.github.io/m8rdocs/#fetch-an-sms-messages
* `MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID` - existing message id within inbox (see above) within private domain (see above); see also https://manybrain.github.io/m8rdocs/#fetch-message
* `MAILINATOR_TEST_ATTACHMENT_ID` - existing message id within inbox (see above) within private domain (see above); see also https://manybrain.github.io/m8rdocs/#fetch-message
* `MAILINATOR_TEST_DELETE_DOMAIN` - don't use it unless you are 100% sure what you are doing


*****

Copyright (c) 2020 Manybrain, Inc

<https://www.mailinator.com/>
