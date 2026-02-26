require "json"

module MailinatorClient

  # Class containing all the actions for the Authenticators Resource
  class Authenticators

    def initialize(client)
      @client = client
    end

    # Instant TOTP 2FA code
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} totpSecretKey - totp secret key
    #
    # Responses:
    # *  Instant TOTP 2FA Code info (https://manybrain.github.io/m8rdocs/#instant-totp-2fa-code)
    def instant_totp_2fa_code(params = {})
      query_params = {}
      headers = {}
      body = nil

      raise ArgumentError.new("totpSecretKey is required") unless params.has_key?(:totpSecretKey)

      path = "/totp/#{params[:totpSecretKey]}"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Fetch Authenticators
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of passcodes (https://manybrain.github.io/m8rdocs/#fetch-authenticators)
    def get_authenticators()
      query_params = {}
      headers = {}
      body = nil

      path = "/authenticators"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
    # Fetch the TOTP 2FA code from one of your saved Keys
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} id - authenticator id
    #
    # Responses:
    # *  Authenticator (https://manybrain.github.io/m8rdocs/#fetch-authenticators-by-id)
    def get_authenticators_by_id(params = {})
      query_params = {}
      headers = {}
      body = nil

      raise ArgumentError.new("id is required") unless params.has_key?(:id)

      path = "/authenticators/#{params[:id]}"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
    # Fetch Authenticator
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of passcodes (https://manybrain.github.io/m8rdocs/#fetch-authenticator)
    def get_authenticator()
      query_params = {}
      headers = {}
      body = nil

      path = "/authenticator"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Fetch Authenticator By Id
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} id - authenticator id
    #
    # Responses:
    # *  Authenticator (https://manybrain.github.io/m8rdocs/#fetch-authenticator-by-id)
    def get_authenticator_by_id(params = {})
      query_params = {}
      headers = {}
      body = nil

      raise ArgumentError.new("id is required") unless params.has_key?(:id)

      path = "/authenticator/#{params[:id]}"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
  end
end
