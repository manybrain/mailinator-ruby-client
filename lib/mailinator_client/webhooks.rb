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

  # Class containing all the actions for the Webhooks Resource
  class Webhooks

    def initialize(client)
      @client = client
    end

    # This command will Webhook messages into your Private Domain
    # The incoming Webhook will arrive in the inbox designated by the "to" field in the incoming request payload.
    # Webhooks into your Private System do NOT use your regular API Token.
    # This is because a typical use case is to enter the Webhook URL into 3rd-party systems(i.e.Twilio, Zapier, IFTTT, etc) and you should never give out your API Token.
    # Check your Team Settings where you can create "Webhook Tokens" designed for this purpose.
    #
    # Parameters:
    # *  {string} whToken - webhook token
    # *  {string} webhook - The Webhook object
    #
    # Responses:
    # *  PrivateWebhookResponse (https://manybrain.github.io/m8rdocs/#private-webhook)
    def private_webhook(params = {})
      query_params = { whtoken: "" }
      headers = {}
      body = nil

      raise ArgumentError.new("whToken is required") unless params.has_key?(:whToken)
      raise ArgumentError.new("webhook is required") unless params.has_key?(:webhook)
      
      query_params[:whtoken] = params[:whToken] if params.has_key?(:whToken)

      path = "/domains/private/webhook"
      
      response = @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
    # This command will deliver the message to the :inbox inbox
    # Incoming Webhooks are delivered to Mailinator inboxes and from that point onward are not notably different than other messages in the system (i.e. emails). 
    # As normal, Mailinator will list all messages in the Inbox page and via the Inbox API calls. 
    # If the incoming JSON payload does not contain a "from" or "subject", then dummy values will be inserted in these fields.
    # You may retrieve such messages via the Web Interface, the API, or the Rule System
    #
    # Parameters:
    # *  {string} whToken - webhook token
    # *  {string} inbox - inbox
    # *  {string} webhook - The Webhook object
    #
    # Responses:
    # *  PrivateWebhookResponse (https://manybrain.github.io/m8rdocs/#private-inbox-webhook)
    def private_inbox_webhook(params = {})
      query_params = { whtoken: "" }
      headers = {}
      body = nil

      raise ArgumentError.new("whToken is required") unless params.has_key?(:whToken)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("webhook is required") unless params.has_key?(:webhook)

      body = params[:webhook] if params.has_key?(:webhook)

      query_params[:whtoken] = params[:whToken] if params.has_key?(:whToken)

      path = "/domains/private/webhook/#{params[:inbox]}"

      response = @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
    # If you have a Twilio account which receives incoming SMS messages. You may direct those messages through this facility to inject those messages into the Mailinator system.
    # Mailinator intends to apply specific mappings for certain services that commonly publish webhooks.
    # If you test incoming Messages to SMS numbers via Twilio, you may use this endpoint to correctly map "to", "from", and "subject" of those messages to the Mailinator system.By default, the destination inbox is the Twilio phone number.
    #
    # Parameters:
    # *  {string} whToken - webhook token
    # *  {string} customService - custom service name
    # *  {string} webhook - The Webhook object
    #
    # Responses:
    # *  PrivateWebhookResponse (https://manybrain.github.io/m8rdocs/#private-custom-service-webhook)
    def private_custom_service_webhook(params = {})
      query_params = { whtoken: "" }
      headers = {}
      body = nil

      raise ArgumentError.new("whToken is required") unless params.has_key?(:whToken)
      raise ArgumentError.new("customService is required") unless params.has_key?(:customService)
      raise ArgumentError.new("webhook is required") unless params.has_key?(:webhook)

      body = params[:webhook] if params.has_key?(:webhook)
      
      query_params[:whtoken] = params[:whToken] if params.has_key?(:whToken)

      path = "/domains/private/#{params[:customService]}"

      response = @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # The SMS message will arrive in the Private Mailinator inbox corresponding to the Twilio Phone Number. (only the digits, if a plus sign precedes the number it will be removed) 
    # If you wish the message to arrive in a different inbox, you may append the destination inbox to the URL.
    #
    # Parameters:
    # *  {string} whToken - webhook token
    # *  {string} inbox - inbox
    # *  {string} customService - custom service name
    # *  {string} webhook - The Webhook object
    #
    # Responses:
    # *  PrivateWebhookResponse (https://manybrain.github.io/m8rdocs/#private-custom-service-inbox-webhook)
    def private_custom_service_inbox_webhook(params = {})
      query_params = { whtoken: "" }
      headers = {}
      body = nil

      raise ArgumentError.new("whToken is required") unless params.has_key?(:whToken)
      raise ArgumentError.new("customService is required") unless params.has_key?(:customService)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("webhook is required") unless params.has_key?(:webhook)

      body = params[:webhook] if params.has_key?(:webhook)
      
      query_params[:whtoken] = params[:whToken] if params.has_key?(:whToken)

      path = "/domains/private/#{params[:customService]}/#{params[:inbox]}"

      response = @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
  end
end
