require "json"
require "net/http"
require "uri"

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
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {number} skip - [Optional] Skip this many emails in your Private Domain
    # *  {number} limit - [Optional] Number of emails to fetch from your Private Domain
    # *  {string} sort - [Optional] Sort results by ascending or descending
    # *  {boolean} decodeSubject - [Optional] true: decode encoded subjects
    # *  {string} cursor - [Optional] Pagination cursor for large result sets (obtained from previous response)
    # *  {boolean} full - [Optional] Return full email content with body/attachments (true) or just metadata (false). Default: false
    # *  {string} delete - [Optional] Auto-delete message after retrieval (e.g., "10s" = 10 seconds, "5m" = 5 minutes)
    #
    # Responses:
    # *  Collection of messages (https://manybrain.github.io/m8rdocs/#fetch-inbox-aka-fetch-message-summaries)
    def fetch_inbox(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { skip: 0, limit: 50, sort: "ascending", decodeSubject: false }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)

      query_params[:skip] = params[:skip] if params.has_key?(:skip)
      query_params[:limit] = params[:limit] if params.has_key?(:limit)
      query_params[:sort] = params[:sort] if params.has_key?(:sort)
      query_params[:decodeSubject] = params[:decodeSubject] if params.has_key?(:decodeSubject)
      query_params[:cursor] = params[:cursor] if params.has_key?(:cursor)
      query_params[:full] = params[:full] if params.has_key?(:full)
      query_params[:delete] = params[:delete] if params.has_key?(:delete)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}"

      response = @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)

      response
    end

    # Retrieves a specific message by id for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    # *  {string} delete - [Optional] Auto-delete message after retrieval (e.g., "10s" = 10 seconds, "5m" = 5 minutes)
    #
    # Responses:
    # *  Message (https://manybrain.github.io/m8rdocs/#fetch-inbox-message)
    def fetch_inbox_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      query_params[:delete] = params[:delete] if params.has_key?(:delete)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}"

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
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    # *  {string} delete - [Optional] Auto-delete message after retrieval (e.g., "10s" = 10 seconds, "5m" = 5 minutes)
    #
    # Responses:
    # *  Message (https://www.mailinator.com/documentation/docs/api/get-domain-message/index.html)
    def fetch_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      query_params[:delete] = params[:delete] if params.has_key?(:delete)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves the summary for a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message summary
    def fetch_message_summary(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/summary"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves text content for a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message text response
    def fetch_message_text(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/text"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves text/plain content for a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message text/plain response
    def fetch_message_textplain(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/textplain"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves text/html content for a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message text/html response
    def fetch_message_texthtml(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/texthtml"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves headers for a specific message by id.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Message headers response
    def fetch_message_headers(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/headers"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Streams all messages from a domain.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {boolean} full - [Optional] Return full email content with body/attachments (true) or just metadata (false). Default: false
    # *  {number} limit - [Optional] Number of messages to fetch
    # *  {number} throttleInterval - [Optional] Throttle interval in milliseconds
    # *  {string} delete - [Optional] Auto-delete message after retrieval (e.g., "10s" = 10 seconds, "5m" = 5 minutes)
    #
    # Responses:
    # *  Message stream response
    def stream_domain_messages(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)

      query_params[:full] = params[:full] if params.has_key?(:full)
      query_params[:limit] = params[:limit] if params.has_key?(:limit)
      query_params[:throttleInterval] = params[:throttleInterval] if params.has_key?(:throttleInterval)
      query_params[:delete] = params[:delete] if params.has_key?(:delete)

      path = "/domains/#{params[:domain]}/stream"

      uri = URI.parse(@client.url + path)
      query = Utils.fix_query_arrays(query_params)
      uri.query = URI.encode_www_form(query) unless query.nil? || query.empty?

      headers["Accept"] = "application/json"
      headers["Content-Type"] = "application/json"
      headers["User-Agent"] = "Mailinator SDK - Ruby V#{MailinatorClient::VERSION}"
      headers["Authorization"] = @client.auth_token if @client.auth_token

      response_body = +""
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.read_timeout = 20

      request = Net::HTTP::Get.new(uri)
      headers.each { |key, value| request[key] = value }

      http.request(request) do |response|
        if response.code.to_i >= 400
          raise ResponseError.new(response.code.to_i, nil, response.body)
        end

        catch(:done) do
          response.read_body do |chunk|
            response_body << chunk
            if response_body.include?("\n\n") || response_body.include?("}\n") || response_body.strip.end_with?("}")
              throw :done
            end
          end
        end
      end

      payload = response_body.strip
      if payload.start_with?("data:")
        payload_line = payload.lines.find { |line| line.start_with?("data:") }
        payload = payload_line.to_s.sub(/^data:\\s*/, "").strip
      end

      parsed = begin
        JSON.parse(payload)
      rescue JSON::ParserError
        cleaned = payload.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
        candidate = cleaned
        if candidate.include?("data:")
          data_line = candidate.lines.find { |line| line.start_with?("data:") }
          candidate = data_line.to_s.sub(/^data:\s*/, "")
        end

        in_string = false
        escape = false
        depth = 0
        start_idx = nil
        end_idx = nil

        candidate.each_char.with_index do |ch, idx|
          if start_idx.nil?
            if ch == "{"
              start_idx = idx
              depth = 1
            end
            next
          end

          if in_string
            if escape
              escape = false
            elsif ch == "\\"
              escape = true
            elsif ch == "\""
              in_string = false
            end
          else
            case ch
            when "\""
              in_string = true
            when "{"
              depth += 1
            when "}"
              depth -= 1
              if depth == 0
                end_idx = idx
                break
              end
            end
          end
        end

        if start_idx && end_idx && end_idx >= start_idx
          JSON.parse(candidate[start_idx..end_idx])
        end
      end

      raise ResponseError.new(500, nil, payload) if parsed.nil?

      return parsed if parsed.is_a?(Hash) && parsed.key?("domain") && parsed.key?("msgs")
      return { "domain" => parsed["domain"], "to" => parsed["to"], "msgs" => [parsed] } if parsed.is_a?(Hash)
      parsed
    end

    # Retrieves a specific SMS message by sms number.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} teamSmsNumber - The Team sms number
    # *  {number} skip - [Optional] Skip this many emails in your Private Domain
    # *  {number} limit - [Optional] Number of emails to fetch from your Private Domain
    # *  {string} sort - [Optional] Sort results by ascending or descending
    # *  {boolean} decode_subject - [Optional] true: decode encoded subjects
    # *  {string} cursor - [Optional] Pagination cursor for large result sets (obtained from previous response)
    # *  {boolean} full - [Optional] Return full email content with body/attachments (true) or just metadata (false). Default: false
    # *  {string} delete - [Optional] Auto-delete message after retrieval (e.g., "10s" = 10 seconds, "5m" = 5 minutes)
    # *  {string} wait - [Optional] Maximum time to wait for new messages (e.g., "30s" = 30 seconds)
    #
    # Responses:
    # *  Collection of messages (https://manybrain.github.io/m8rdocs/#fetch-an-sms-messages)
    def fetch_sms_message(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { skip: 0, limit: 50, sort: "ascending", decode_subject: false }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("team sms number is required") unless params.has_key?(:teamSmsNumber)

      query_params[:skip] = params[:skip] if params.has_key?(:skip)
      query_params[:limit] = params[:limit] if params.has_key?(:limit)
      query_params[:sort] = params[:sort] if params.has_key?(:sort)
      query_params[:decode_subject] = params[:decode_subject] if params.has_key?(:decode_subject)
      query_params[:decode_subject] = params[:decodeSubject] if params.has_key?(:decodeSubject)
      query_params[:cursor] = params[:cursor] if params.has_key?(:cursor)
      query_params[:full] = params[:full] if params.has_key?(:full)
      query_params[:delete] = params[:delete] if params.has_key?(:delete)
      query_params[:wait] = params[:wait] if params.has_key?(:wait)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:teamSmsNumber]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves a list of attachments for a message for specific inbox. Note attachments are expected to be in Email format.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of attachments (https://manybrain.github.io/m8rdocs/#fetch-inbox-message-list-of-attachments)
    def fetch_inbox_message_attachments(params = {})
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

    # Retrieves a list of attachments for a message. Note attachments are expected to be in Email format.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of attachments (https://manybrain.github.io/m8rdocs/#fetch-list-of-attachments)
    def fetch_message_attachments(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/attachments"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves a specific attachment for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    # *  {string} attachmentId - The Attachment id
    #
    # Responses:
    # *  Attachment (https://manybrain.github.io/m8rdocs/#fetch-inbox-message-attachment)
    def fetch_inbox_message_attachment(params = {})
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

    # Retrieves a specific attachment.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    # *  {string} attachmentId - The Attachment id
    #
    # Responses:
    # *  Attachment (https://manybrain.github.io/m8rdocs/#fetch-attachment)
    def fetch_message_attachment(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)
      raise ArgumentError.new("attachment id is required") unless params.has_key?(:attachmentId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/attachments/#{params[:attachmentId]}"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all links full info found within a given email.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of links full (https://manybrain.github.io/m8rdocs/#fetch-links-full)
    def fetch_message_links_full(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/linksfull"

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
    # *  {string} domainId - The Domain name or simply 'private'
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
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/links"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all links found within a given email for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of links (https://manybrain.github.io/m8rdocs/#fetch-inbox-message-links)
    def fetch_inbox_message_links(params = {})
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
    # *  {string} domainId - The Domain name or simply 'private'
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
    # *  {string} domainId - The Domain name or simply 'private'
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
    # *  {string} domainId - The Domain name or simply 'private'
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
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageToPost - The Message object (https://manybrain.github.io/m8rdocs/#inject-a-message-http-post-messages)
    #
    # Responses:
    # *  Status, Id and RulesToFired info (https://manybrain.github.io/m8rdocs/#post-message)
    def post_message(params = {})
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

    # Retrieves all smtp log found within a given email.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of smtp logs (https://manybrain.github.io/m8rdocs/#fetch-message-smtp-log)
    def fetch_message_smtp_log(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/smtplog"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all smtp log found within a given email for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Collection of smtp log (https://manybrain.github.io/m8rdocs/#fetch-inbox-message-smtp-log)
    def fetch_inbox_message_smtp_log(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}/smtplog"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all raw data found within a given email.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Raw Data (https://manybrain.github.io/m8rdocs/#fetch-message-raw)
    def fetch_message_raw(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/messages/#{params[:messageId]}/raw"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # Retrieves all raw data found within a given email for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    # *  {string} messageId - The Message id
    #
    # Responses:
    # *  Raw Data (https://manybrain.github.io/m8rdocs/#fetch-inbox-message-raw)
    def fetch_inbox_message_raw(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)
      raise ArgumentError.new("message id is required") unless params.has_key?(:messageId)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/#{params[:messageId]}/raw"
      
      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # That fetches the latest 5 FULL messages.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    #
    # Responses:
    # *  Collection of latest messages (https://manybrain.github.io/m8rdocs/#fetch-latest-messages)
    def fetch_latest_messages(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)

      path = "/domains/#{params[:domain]}/messages/*"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end

    # That fetches the latest 5 FULL messages for specific inbox.
    #
    # Authentication:
    # The client must be configured with a valid api
    # access token to call this action.
    #
    # Parameters:
    # *  {string} domainId - The Domain name or simply 'private'
    # *  {string} inbox - The Inbox name
    #
    # Responses:
    # *  Collection of latest messages (https://manybrain.github.io/m8rdocs/#fetch-latest-inbox-messages)
    def fetch_latest_inbox_messages(params = {})
      params = Utils.symbolize_hash_keys(params)
      query_params = { }
      headers = {}
      body = nil

      raise ArgumentError.new("domain is required") unless params.has_key?(:domain)
      raise ArgumentError.new("inbox is required") unless params.has_key?(:inbox)

      path = "/domains/#{params[:domain]}/inboxes/#{params[:inbox]}/messages/*"

      @client.request(
        method: :get,
        path: path,
        query: query_params,
        headers: headers,
        body: body)
    end
    
  end
end
