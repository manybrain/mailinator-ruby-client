require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesTextApiTest < Minitest::Test
  def test_fetch_message_text_endpoint
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
    )

    client = integration_client
    domain_name = ENV["MAILINATOR_TEST_DOMAIN"].to_s.strip
    domain_name = first_domain_name(client) if domain_name.empty?

    response = client.messages.fetch_message_text(
      domain: domain_name,
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]
    )

    assert_kind_of(Hash, response, "Expected fetch message text response to be JSON object")
    assert response["text"] != nil, "Expected response.text to not be nil"
  end
end
