# Authenticators Actions

Details on the various actions that can be performed on the Authenticators resource, including the expected parameters and the potential responses.

##### Contents

*   [InstantTOTP2FACode](#instanttotp2facode)
*   [GetAuthenticators](#getauthenticators)
*   [GetAuthenticatorsById](#getauthenticatorsbyid)
*   [GetAuthenticator](#getauthenticator)
*   [GetAuthenticatorById](#getauthenticatorbyid)

<br/>

## InstantTOTP2FACode

Instant TOTP 2FA code

```ruby
result = client.authenticators.instant_totp_2fa_code()

puts result
```

<br/>

## GetAuthenticators

Fetch Authenticators

```ruby
result = client.authenticators.get_authenticators()

puts result
```

<br/>

## GetAuthenticatorsById

Fetch the TOTP 2FA code from one of your saved Keys

```ruby
result = client.authenticators.get_authenticators_by_id()

puts result
```

<br/>

## GetAuthenticator

Fetch Authenticator

```ruby
result = client.authenticators.get_authenticator()

puts result
```

<br/>

## GetAuthenticatorById

Fetch Authenticator By Id

```ruby
result = client.authenticators.get_authenticator_by_id()

puts result
```
