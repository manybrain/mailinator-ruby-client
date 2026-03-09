require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class WebhooksApiTest < Minitest::Test
  def test_webhooks_endpoints
    require_env!(
      "MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN",
      "MAILINATOR_TEST_WEBHOOK_INBOX",
      "MAILINATOR_TEST_WEBHOOK_CUSTOMSERVICE"
    )

    webhook = {
      from: "MyMailinatorRubyTest",
      subject: "testing message",
      text: "hello world",
      to: "jack"
    }

    client_without_auth = MailinatorClient::Client.new

    response = client_without_auth.webhooks.private_webhook(
      whToken: ENV["MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN"],
      webhook: webhook
    )
    assert response != nil, "Expected private webhook status response to not be nil"
    assert response["status"] == "ok", "Expected private webhook response to be ok"

    response = client_without_auth.webhooks.private_inbox_webhook(
      whToken: ENV["MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN"],
      inbox: ENV["MAILINATOR_TEST_WEBHOOK_INBOX"],
      webhook: webhook
    )
    assert response != nil, "Expected private inbox webhook response to not be nil"
    assert response["status"] == "ok", "Expected private inbox webhook response to be ok"

    # Known bug: currently uses private-domain token, not custom-service token.
    client_without_auth.webhooks.private_custom_service_webhook(
      whToken: ENV["MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN"],
      customService: ENV["MAILINATOR_TEST_WEBHOOK_CUSTOMSERVICE"],
      webhook: webhook
    )

    client_without_auth.webhooks.private_custom_service_inbox_webhook(
      whToken: ENV["MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN"],
      customService: ENV["MAILINATOR_TEST_WEBHOOK_CUSTOMSERVICE"],
      inbox: ENV["MAILINATOR_TEST_WEBHOOK_INBOX"],
      webhook: webhook
    )
  end
end
