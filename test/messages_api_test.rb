require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesApiTest < Minitest::Test
  def setup
    super
    @client = integration_client
    @domain_name = first_domain_name(@client)
    @inbox_all = "*"
  end

  def test_post_message_seed
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.post_message(
      domain: @domain_name,
      inbox: @inbox_all,
      messageToPost: {
        subject: "Testing ruby message",
        from: "test_email_ruby@test.com",
        text: "I love Ruby!"
      }
    )

    assert response != nil, "Expected post message response to not be nil"
    assert response["status"] == "ok", "Expected post message response to be ok"
  end

  def test_fetch_inbox_basic
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )

    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
  end

  def test_fetch_inbox_cursor
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )
    cursor = response["cursor"]

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      limit: 1,
      cursor: cursor
    )

    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
  end

  def test_fetch_inbox_full
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      limit: 1,
      full: true
    )

    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
  end

  def test_fetch_inbox_delete
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      limit: 1,
      delete: "1m"
    )

    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
  end

  def test_fetch_inbox_wait
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      limit: 1,
      wait: "1m"
    )

    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
  end

  def test_fetch_message_variants
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )
    message_id = response["msgs"][0]["id"]

    response = @client.messages.fetch_inbox_message(
      domain: @domain_name,
      inbox: @inbox_all,
      messageId: message_id
    )
    assert response != nil, "Expected fetch inbox message response to not be nil"

    response = @client.messages.fetch_message(domain: @domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message response to not be nil"

    response = @client.messages.fetch_message(domain: @domain_name, messageId: message_id, delete: "10s")
    assert response != nil, "Expected fetch message response to not be nil"
  end

  def test_fetch_sms_message
    require_env!("MAILINATOR_TEST_API_TOKEN", "MAILINATOR_TEST_PHONE_NUMBER")

    response = @client.messages.fetch_sms_message(
      domain: @domain_name,
      teamSmsNumber: ENV["MAILINATOR_TEST_PHONE_NUMBER"]
    )

    assert response != nil, "Expected fetch sms message response to not be nil"
  end

  def test_attachment_list_and_download
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_INBOX",
      "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
    )

    response = @client.messages.fetch_inbox_message_attachments(
      domain: @domain_name,
      inbox: ENV["MAILINATOR_TEST_INBOX"],
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]
    )
    assert response != nil, "Expected fetch inbox message attachments response to not be nil"
    attachments = response["attachments"]
    assert attachments != nil, "Expected attachments list in fetch inbox message attachments response"
    assert_kind_of(Array, attachments, "Expected attachments to be an array")
    assert !attachments.empty?, "Expected at least one attachment for MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
    attachment = attachments[0]
    attachment_id = attachment["id"] || attachment["attachmentId"] || attachment["attachment_id"] || attachment["name"] || attachment["filename"]
    assert attachment_id != nil, "Expected attachment to include an id or name field"

    response = @client.messages.fetch_message_attachments(
      domain: @domain_name,
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]
    )
    assert response != nil, "Expected fetch message attachments response to not be nil"

    response = @client.messages.fetch_inbox_message_attachment(
      domain: @domain_name,
      inbox: ENV["MAILINATOR_TEST_INBOX"],
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"],
      attachmentId: attachment_id
    )
    assert response != nil, "Expected fetch inbox message attachment response to not be nil"

    response = @client.messages.fetch_message_attachment(
      domain: @domain_name,
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"],
      attachmentId: attachment_id
    )
    assert response != nil, "Expected fetch message attachment response to not be nil"
  end

  def test_links_and_logs
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )
    message_id = response["msgs"][0]["id"]

    response = @client.messages.fetch_message_links_full(domain: @domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message links full response to not be nil"
    assert response["links"] != nil, "Expected fetch message links links full response to not be nil"

    response = @client.messages.fetch_message_links(domain: @domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message links response to not be nil"
    assert response["links"] != nil, "Expected fetch message links links response to not be nil"

    response = @client.messages.fetch_inbox_message_links(domain: @domain_name, inbox: @inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message links response to not be nil"
    assert response["links"] != nil, "Expected fetch inbox message links links response to not be nil"

    response = @client.messages.fetch_message_smtp_log(domain: @domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message smtp log response to not be nil"

    response = @client.messages.fetch_inbox_message_smtp_log(domain: @domain_name, inbox: @inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message smtp log response to not be nil"
  end

  def test_raw_message_variants
    require_env!("MAILINATOR_TEST_API_TOKEN")

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )
    message_id = response["msgs"][0]["id"]

    response = @client.messages.fetch_message_raw(domain: @domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message raw response to not be nil"

    response = @client.messages.fetch_inbox_message_raw(domain: @domain_name, inbox: @inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message raw response to not be nil"
  end

  def test_delete_domain_flows
    require_env!("MAILINATOR_TEST_API_TOKEN")

    delete_domain = ENV["MAILINATOR_TEST_DELETE_DOMAIN"]
    if delete_domain.to_s.strip.empty?
      warn "Skipping delete-domain checks: MAILINATOR_TEST_DELETE_DOMAIN is not set"
      return
    end

    response = @client.messages.fetch_inbox(
      domain: @domain_name,
      inbox: @inbox_all,
      skip: 0,
      limit: 1,
      sort: "ascending",
      decodeSubject: false
    )
    message_id = response["msgs"][0]["id"]

    response = @client.messages.delete_message(domain: delete_domain, inbox: ENV["MAILINATOR_TEST_INBOX"], messageId: message_id)
    assert response != nil, "Expected delete message response to not be nil"
    assert response["status"] == "ok", "Expected delete message response to be ok"

    response = @client.messages.delete_all_inbox_messages(domain: delete_domain, inbox: ENV["MAILINATOR_TEST_INBOX"])
    assert response != nil, "Expected delete all inbox messages response to not be nil"
    assert response["status"] == "ok", "Expected delete all inbox messages response to be ok"

    response = @client.messages.delete_all_domain_messages(domain: delete_domain)
    assert response != nil, "Expected delete all domain messages response to not be nil"
    assert response["status"] == "ok", "Expected delete all domain messages response to be ok"
  end
end
