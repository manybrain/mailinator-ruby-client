# The MIT License (MIT)
#
# Copyright (c) 2024 Manybrain, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require "json"

module MailinatorClient

  # Class containing all the actions for the Stats Resource
  class Stats

    def initialize(client)
      @client = client
    end

    # Retrieves stats of team
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Collection of team stats (https://manybrain.github.io/m8rdocs/#get-all-domains)
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

    # Retrieves team info
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Responses:
    # *  Team info (https://manybrain.github.io/m8rdocs/#stats-api)
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
