require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesApiTest < Minitest::Test
  def test_messages_endpoints
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_INBOX",
      "MAILINATOR_TEST_PHONE_NUMBER",
      "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID",
      "MAILINATOR_TEST_ATTACHMENT_ID"
    )

    client = integration_client
    domain_name = first_domain_name(client)
    inbox_all = "*"

    message_to_post = {
      subject: "Testing ruby message",
      from: "test_email_ruby@test.com",
      text: "I love Ruby!"
    }
    response = client.messages.post_message(domain: domain_name, inbox: inbox_all, messageToPost: message_to_post)
    assert response != nil, "Expected post message response to not be nil"
    assert response["status"] == "ok", "Expected post message response to be ok"

    response = client.messages.fetch_inbox(domain: domain_name, inbox: inbox_all, skip: 0, limit: 1, sort: "ascending", decodeSubject: false)
    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
    message = response["msgs"][0]
    message_id = message["id"]

    response = client.messages.fetch_inbox(domain: domain_name, inbox: inbox_all, limit: 1, cursor: response["cursor"])
    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"

    response = client.messages.fetch_inbox(domain: domain_name, inbox: inbox_all, limit: 1, full: true)
    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"

    response = client.messages.fetch_inbox(domain: domain_name, inbox: inbox_all, limit: 1, delete: "1m")
    assert response != nil, "Expected fetch inbox response to not be nil"
    assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"

    begin
      response = client.messages.fetch_inbox(domain: domain_name, inbox: inbox_all, limit: 1, wait: "1m")
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
    rescue MailinatorClient::ResponseError => e
      if e.code >= 500
        warn "Skipping wait query assertion due to server-side error (HTTP #{e.code})"
      else
        raise
      end
    end

    response = client.messages.fetch_inbox_message(domain: domain_name, inbox: inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message response to not be nil"

    response = client.messages.fetch_message(domain: domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message response to not be nil"

    response = client.messages.fetch_message(domain: domain_name, messageId: message_id, delete: "10s")
    assert response != nil, "Expected fetch message response to not be nil"

    response = client.messages.fetch_sms_message(domain: domain_name, teamSmsNumber: ENV["MAILINATOR_TEST_PHONE_NUMBER"])
    assert response != nil, "Expected fetch sms message response to not be nil"

    response = client.messages.fetch_inbox_message_attachments(
      domain: domain_name,
      inbox: ENV["MAILINATOR_TEST_INBOX"],
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]
    )
    assert response != nil, "Expected fetch inbox message attachments response to not be nil"

    response = client.messages.fetch_message_attachments(domain: domain_name, messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"])
    assert response != nil, "Expected fetch message attachments response to not be nil"

    response = client.messages.fetch_inbox_message_attachment(
      domain: domain_name,
      inbox: ENV["MAILINATOR_TEST_INBOX"],
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"],
      attachmentId: ENV["MAILINATOR_TEST_ATTACHMENT_ID"]
    )
    assert response != nil, "Expected fetch inbox message attachment response to not be nil"

    response = client.messages.fetch_message_attachment(
      domain: domain_name,
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"],
      attachmentId: ENV["MAILINATOR_TEST_ATTACHMENT_ID"]
    )
    assert response != nil, "Expected fetch message attachment response to not be nil"

    response = client.messages.fetch_message_links_full(domain: domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message links full response to not be nil"
    assert response["links"] != nil, "Expected fetch message links links full response to not be nil"

    response = client.messages.fetch_message_links(domain: domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message links response to not be nil"
    assert response["links"] != nil, "Expected fetch message links links response to not be nil"

    response = client.messages.fetch_inbox_message_links(domain: domain_name, inbox: inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message links response to not be nil"
    assert response["links"] != nil, "Expected fetch inbox message links links response to not be nil"

    response = client.messages.fetch_message_smtp_log(domain: domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message smtp log response to not be nil"

    response = client.messages.fetch_inbox_message_smtp_log(domain: domain_name, inbox: inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message smtp log response to not be nil"

    response = client.messages.fetch_message_raw(domain: domain_name, messageId: message_id)
    assert response != nil, "Expected fetch message raw response to not be nil"

    response = client.messages.fetch_inbox_message_raw(domain: domain_name, inbox: inbox_all, messageId: message_id)
    assert response != nil, "Expected fetch inbox message raw response to not be nil"

    warn "Skipping legacy non-spec endpoints: messages.fetch_latest_messages / messages.fetch_latest_inbox_messages"

    delete_domain = ENV["MAILINATOR_TEST_DELETE_DOMAIN"]
    if delete_domain.to_s.strip.empty?
      warn "Skipping delete-domain checks: MAILINATOR_TEST_DELETE_DOMAIN is not set"
    else
      response = client.messages.delete_message(domain: delete_domain, inbox: ENV["MAILINATOR_TEST_INBOX"], messageId: message_id)
      assert response != nil, "Expected delete message response to not be nil"
      assert response["status"] == "ok", "Expected delete message response to be ok"

      response = client.messages.delete_all_inbox_messages(domain: delete_domain, inbox: ENV["MAILINATOR_TEST_INBOX"])
      assert response != nil, "Expected delete all inbox messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all inbox messages response to be ok"

      response = client.messages.delete_all_domain_messages(domain: delete_domain)
      assert response != nil, "Expected delete all domain messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all domain messages response to be ok"
    end
  end
end
