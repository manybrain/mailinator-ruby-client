require File.expand_path(File.dirname(__FILE__) + "/test_helper")
require "timeout"

class MessagesStreamDomainApiTest < Minitest::Test
  def test_stream_domain_messages_endpoint
    require_env!("MAILINATOR_TEST_API_TOKEN")

    client = integration_client
    domain_name = "private"

    response = nil
    # This test requires a real email to arrive while the stream is open.
    stream_thread = Thread.new do
      client.messages.stream_domain_messages(
        domain: domain_name,
        limit: 1,
        throttleInterval: 1000,
        delete: "1m"
      )
    end

    response = Timeout.timeout(20) do
      stream_thread.value
    end rescue begin
      e = $!
      if e.is_a?(Timeout::Error)
        flunk "Expected stream domain messages to return within timeout"
      end
      if e.is_a?(MailinatorClient::ResponseError)
        flunk "Expected HTTP 200 from stream domain messages endpoint, got HTTP #{e.code}"
      end
      raise
    end

    assert_kind_of(Hash, response, "Expected stream response to be a JSON object")
    assert response.key?("domain"), "Expected response to include domain"
    assert response.key?("to"), "Expected response to include to"
    assert response.key?("msgs"), "Expected response to include msgs"
  end
end
