require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesQueryParamsTest < Minitest::Test
  def test_fetch_inbox_message_accepts_optional_delete
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_INBOX",
      "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
    )

    client = integration_client
    domain_name = ENV["MAILINATOR_TEST_DOMAIN"].to_s.strip
    domain_name = first_domain_name(client) if domain_name.empty?
    message_id = ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]

    response = client.messages.fetch_inbox_message(
      domain: domain_name,
      inbox: ENV["MAILINATOR_TEST_INBOX"],
      messageId: message_id,
      delete: "10m"
    ) rescue begin
      e = $!
      if e.is_a?(MailinatorClient::ResponseError)
        flunk "Expected HTTP 200 for fetch_inbox_message with delete param, got HTTP #{e.code}"
      end
      raise
    end

    assert_kind_of(Hash, response, "Expected JSON object response for fetch_inbox_message")
    assert response["id"] != nil, "Expected message id in fetch_inbox_message response"
    assert_equal(message_id, response["id"], "Expected returned message id to match requested message id")
  end

  def test_fetch_sms_message_supports_inbox_list_query_params
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_PHONE_NUMBER"
    )

    client = integration_client
    domain_name = ENV["MAILINATOR_TEST_DOMAIN"].to_s.strip
    domain_name = first_domain_name(client) if domain_name.empty?

    response = client.messages.fetch_sms_message(
      domain: domain_name,
      teamSmsNumber: ENV["MAILINATOR_TEST_PHONE_NUMBER"],
      skip: 0,
      limit: 10,
      sort: "descending",
      decode_subject: true,
      full: false,
      wait: "20s"
    ) rescue begin
      e = $!
      if e.is_a?(MailinatorClient::ResponseError)
        flunk "Expected HTTP 200 for fetch_sms_message query params flow, got HTTP #{e.code}"
      end
      raise
    end

    assert_kind_of(Hash, response, "Expected JSON object response for fetch_sms_message")
    assert response.key?("msgs"), "Expected msgs key in fetch_sms_message response"
    assert_kind_of(Array, response["msgs"], "Expected msgs to be an array")
  end
end
