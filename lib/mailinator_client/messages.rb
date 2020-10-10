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

require "json"

module MailinatorClient

  # Class containing all the actions for the Messages Resource
  class Messages

    def initialize(client)
      @client = client
    end

    # Retrieves a list of messages summaries. You can retreive a list by inbox, inboxes, or entire domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {number} skip - Skip this many emails in your Private Domain
    # *  {number} limit - Number of emails to fetch from your Private Domain
    # *  {string} sort - Sort results by ascending or descending
    # *  {boolean} decodeSubject - true: decode encoded subjects
    #
    # Responses:
    # *  Collection of messages (https://manybrain.github.io/m8rdocs/#fetch-inbox-aka-fetch-message-summaries)
    def fetch_inbox(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { skip: 0, limit: 50, sort: "acending", decodeSubject: false }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)

      query_params[:skip] = params[:skip] if params.has_key?(:skip)
      query_params[:limit] = params[:limit] if params.has_key?(:limit)
      query_params[:sort] = params[:sort] if params.has_key?(:sort)
      query_params[:decodeSubject] = params[:decodeSubject] if params.has_key?(:decodeSubject)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message (https://manybrain.github.io/m8rdocs/#fetch-message)
    def fetch_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves a specific SMS message by sms number.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} teamSmsNumber - The Team sms number
    #
    # Responses:
    # *  Collection of messages (https://manybrain.github.io/m8rdocs/#fetch-an-sms-messages)
    def fetch_sms_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("team sms number is required") unless params.has_key?(:teamSmsNumber)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/#{params[:teamSmsNumber]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves a list of attachments for a message. Note attachments are expected to be in Email format.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of attachments (https://manybrain.github.io/m8rdocs/#fetch-list-of-attachments)
    def fetch_attachments(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}/attachments"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end


    # Retrieves a specific attachment.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    # *  {string} attachmentId - The Attachment id
    #
    # Responses:
    # *  Attachment (https://manybrain.github.io/m8rdocs/#fetch-attachment)
    def fetch_attachment(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)
      raise ArgumentError.new("attachment id is required") unless params.has_key?(:attachmentId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}/attachments/#{params[:attachmentId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all links found within a given email.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of links (https://manybrain.github.io/m8rdocs/#fetch-links)
    def fetch_message_links(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}/links"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Deletes ALL messages from a Private Domain. Caution: This action is irreversible.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    #
    # Responses:
    # *  Status and count of removed messages (https://manybrain.github.io/m8rdocs/#delete-all-messages-by-domain)
    def delete_all_domain_messages(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)

      path = "/domains/#{params[:domain]}/inboxes"

      @client.request(
        method: :delete,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Deletes ALL messages from a specific private inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    #
    # Responses:
    # *  Status and count of removed messages (https://manybrain.github.io/m8rdocs/#delete-all-messages-by-inbox)
    def delete_all_inbox_messages(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}"

      @client.request(
        method: :delete,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Deletes a specific messages.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Status and count of removed messages (https://manybrain.github.io/m8rdocs/#delete-a-message)
    def delete_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}"

      @client.request(
        method: :delete,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Deliver a JSON message into your private domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or the Domain id
    # *  {string} inbox - The Inbox name
    # *  {string} messageToPost - The Message object (https://manybrain.github.io/m8rdocs/#inject-a-message-http-post-messages)
    #
    # Responses:
    # *  Status, Id and RulesToFired info (https://manybrain.github.io/m8rdocs/#fetch-an-sms-messages)
    def inject_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("messageToPost is required") unless params.has_key?(:messageToPost)

      body = params[:messageToPost] if params.has_key?(:messageToPost)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages"

      @client.request(
        method: :post,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

  end
end
