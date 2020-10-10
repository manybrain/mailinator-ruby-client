# The MIT License (MIT)
#
# Copyright (c) 2020 Manybrain, Inc.
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

require "httparty"

module MailinatorClient
  # Mailinator API
  #
  # User API for accessing Mailinator data
  class Client
    #attr_reader :auth_token, :url

    def initialize(options = {})
      @auth_token = options.fetch(:auth_token, nil)
      @url        = "https://mailinator.com/api/v2"
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

    def request(options = {})
      headers = options.fetch(:headers, {})
      method  = options.fetch(:method, :get)

      headers["Accept"]         = "application/json"
      headers["Content-Type"]   = "application/json"
      headers["Authorization"]  = @auth_token if @auth_token
      path = @url + options.fetch(:path, "")

      response = HTTParty.send(method, path,
        query: Utils.fix_query_arrays(options[:query]),
        body: options[:body] && options[:body].to_json(),
        headers: headers)

      result = response.parsed_response
      if response.code >= 400
        raise ResponseError.new(response.code, result)
      end
      
      result
    end
  end
end
