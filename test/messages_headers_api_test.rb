require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesHeadersApiTest < Minitest::Test
  def test_fetch_message_headers_endpoint
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
    )

    client = integration_client
    domain_name = ENV["MAILINATOR_TEST_DOMAIN"].to_s.strip
    domain_name = first_domain_name(client) if domain_name.empty?

    response = client.messages.fetch_message_headers(
      domain: domain_name,
      messageId: ENV["MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"]
    ) rescue begin
      e = $!
      if e.is_a?(MailinatorClient::ResponseError)
        flunk "Expected HTTP 200 from message headers endpoint, got HTTP #{e.code}"
      end
      raise
    end

    assert_kind_of(Hash, response, "Expected message headers response to be a JSON object")
    assert_equal(["headers"], response.keys.sort, "Expected only the headers property")
    assert response["headers"].is_a?(Hash), "Expected headers to be a JSON object"
    assert response["headers"]["subject"] != nil, "Expected headers.subject to not be nil"
  end
end
