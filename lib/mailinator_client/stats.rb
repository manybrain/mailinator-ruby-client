require "json"

module MailinatorClient

  # Class containing all the actions for the Stats Resource
  class Stats

    def initialize(client)
      @client = client
    end

    # Retrieves info of team
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of team info (https://manybrain.github.io/m8rdocs/#stats-api)
    def get_team_info()
      query_params = { }
      headers = {}
      body = nil

      path = "/teaminfo"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves stats of team
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of team stats (https://manybrain.github.io/m8rdocs/#stats-api)
    def get_team_stats()
      query_params = { }
      headers = {}
      body = nil

      path = "/team/stats"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves team stats
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Team stats (https://manybrain.github.io/m8rdocs/#stats-api)
    def get_team(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      path = "/team"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

  end
end
