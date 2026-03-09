require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MessagesQueryParamsTest < Minitest::Test
  def test_fetch_inbox_message_accepts_optional_delete
    client = MailinatorClient::Client.new(auth_token: "test-token")
    request = stub_request(:get, "https://api.mailinator.com/api/v2/domains/private.example/inboxes/inbox/messages/msg-123")
      .with(query: { "delete" => "10s" })
      .to_return(status: 200, body: "{}", headers: { "Content-Type" => "application/json" })

    response = client.messages.fetch_inbox_message(
      domain: "private.example",
      inbox: "inbox",
      messageId: "msg-123",
      delete: "10s"
    )

    assert_equal({}, response)
    assert_requested(request, times: 1)
  end

  def test_fetch_sms_message_supports_inbox_list_query_params
    client = MailinatorClient::Client.new(auth_token: "test-token")
    request = stub_request(:get, "https://api.mailinator.com/api/v2/domains/private.example/inboxes/15555550123")
      .with(
        query: {
          "skip" => "5",
          "limit" => "10",
          "sort" => "descending",
          "decode_subject" => "true",
          "cursor" => "cursor-1",
          "full" => "true",
          "delete" => "30s",
          "wait" => "20s"
        }
      )
      .to_return(status: 200, body: "{\"msgs\":[]}", headers: { "Content-Type" => "application/json" })

    response = client.messages.fetch_sms_message(
      domain: "private.example",
      teamSmsNumber: "15555550123",
      skip: 5,
      limit: 10,
      sort: "descending",
      decode_subject: true,
      cursor: "cursor-1",
      full: true,
      delete: "30s",
      wait: "20s"
    )

    assert_equal({ "msgs" => [] }, response)
    assert_requested(request, times: 1)
  end
end
