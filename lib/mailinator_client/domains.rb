require "json"

module MailinatorClient

  # Class containing all the actions for the Domains Resource
  class Domains

    def initialize(client)
      @client = client
    end

    # Fetches a list of all your domains.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of domains (https://manybrain.github.io/m8rdocs/#get-usage-statistica)
    def get_domains()
      query_params = {}
      headers = {}
      body = nil

      path = "/domains"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Fetches a specific domain
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    #
    # Responses:
    # *  Domain (https://manybrain.github.io/m8rdocs/#get-domain)
    def get_domain(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)

      path = "/domains/#{params[:domainId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Create Domain is deprecated in this client.
    # This endpoint creates a private domain attached to your account.
    # Note, the domain must be unique to the system and you must have not reached your maximum number of Private Domains.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name
    #
    # Responses:
    # *  Status (https://manybrain.github.io/m8rdocs/#create-domain)
    def create_domain(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)

      path = "/domains/#{params[:domainId]}"

      @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Delete Domain is deprecated in this client.
    # This endpoint deletes a Private Domain
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    #
    # Responses:
    # *  Status (https://manybrain.github.io/m8rdocs/#delete-domain)
    def delete_domain(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)

      path = "/domains/#{params[:domainId]}"

      @client.request(
        method: :delete,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

  end
end
