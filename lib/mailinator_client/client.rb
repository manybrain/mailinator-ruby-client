require "httparty"

module MailinatorClient
  require_relative 'version'
  # Mailinator API
  #
  # User API for accessing Mailinator data
  class Client
    #attr_reader :auth_token, :url

    def initialize(options = {})
      @auth_token = options.fetch(:auth_token, nil)
      @url        = "https://api.mailinator.com/api/v2"
    end

    def authenticators
      @authenticators ||= Authenticators.new(self)
    end

    def domains
      @domains ||= Domains.new(self)
    end

    def stats
      @stats ||= Stats.new(self)
    end

    def messages
      @messages ||= Messages.new(self)
    end

    def rules
      @rules ||= Rules.new(self)
    end

    def webhooks
      @webhooks ||= Webhooks.new(self)
    end

    def request(options = {})
      headers = options.fetch(:headers, {})
      method  = options.fetch(:method, :get)

      headers["Accept"]         = "application/json"
      headers["Content-Type"]   = "application/json"
      headers["User-Agent"]   = "Mailinator SDK - Ruby V#{MailinatorClient::VERSION}"
      headers["Authorization"]  = @auth_token if @auth_token
      path = @url + options.fetch(:path, "")

      response = HTTParty.send(method, path,
        query: Utils.fix_query_arrays(options[:query]),
        body: options[:body] && options[:body].to_json(),
        headers: headers,
        timeout: 125
      )

      result = response.parsed_response
      if response.code >= 400
        raise ResponseError.new(response.code, result, response.body)
      end
      
      result
    end
  end
end
