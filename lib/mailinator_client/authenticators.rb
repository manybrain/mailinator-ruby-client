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
