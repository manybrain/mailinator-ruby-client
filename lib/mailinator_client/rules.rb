require "json"

module MailinatorClient

  # Class containing all the actions for the Rules Resource
  class Rules

    def initialize(client)
      @client = client
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Creates a Rule. Note that in the examples, ":domain_id" can be one of your private domains.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} ruleToPost - The Rule object (https://manybrain.github.io/m8rdocs/#create-rule)
    #
    # Responses:
    # *  Rule (https://manybrain.github.io/m8rdocs/#create-rule)
    def create_rule(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)
      raise ArgumentError.new("ruleToPost is required") unless params.has_key?(:ruleToPost)

      body = params[:ruleToPost] if params.has_key?(:ruleToPost)

      path = "/domains/#{params[:domainId]}/rules"

      @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Enables an existing Rule
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} ruleId - The Rule id
    #
    # Responses:
    # *  Status (https://manybrain.github.io/m8rdocs/#enable-rule)
    def enable_rule(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)
      raise ArgumentError.new("rule id is required") unless params.has_key?(:ruleId)

      path = "/domains/#{params[:domainId]}/rules/#{params[:ruleId]}/enable"

      @client.request(
        method: :put,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Disables an existing Rule
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} ruleId - The Rule id
    #
    # Responses:
    # *  Status (https://manybrain.github.io/m8rdocs/#disable-rule)
    def disable_rule(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)
      raise ArgumentError.new("rule id is required") unless params.has_key?(:ruleId)

      path = "/domains/#{params[:domainId]}/rules/#{params[:ruleId]}/disable"

      @client.request(
        method: :put,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Fetches all Rules for a Domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    #
    # Responses:
    # *  Collection of rules (https://manybrain.github.io/m8rdocs/#get-all-rules)
    def get_all_rules(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)

      path = "/domains/#{params[:domainId]}/rules"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Fetches a specific rule for a Domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} ruleId - The Domain name or the Rule id
    #
    # Responses:
    # *  Rule (https://manybrain.github.io/m8rdocs/#get-rule)
    def get_rule(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)
      raise ArgumentError.new("rule id is required") unless params.has_key?(:ruleId)

      path = "/domains/#{params[:domainId]}/rules/#{params[:ruleId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # @deprecated Rules endpoints are deprecated in this client.
    # Deletes a specific rule for a Domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} ruleId - The Rule id
    #
    # Responses:
    # *  Status (https://manybrain.github.io/m8rdocs/#delete-rule)
    def delete_rule(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain id is required") unless params.has_key?(:domainId)
      raise ArgumentError.new("rule id is required") unless params.has_key?(:ruleId)

      path = "/domains/#{params[:domainId]}/rules/#{params[:ruleId]}"

      @client.request(
        method: :delete,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

  end
end
