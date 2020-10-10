require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class MailinatorClientApiTest < MiniTest::Test

  describe "test api functionality" do
    before do
      @auth_token = "MAILINATOR_TEST_API_TOKEN"
      @inboxAll = "*"
      @inbox = "MAILINATOR_TEST_INBOX"
      @teamSMSNumber = "MAILINATOR_TEST_PHONE_NUMBER"
      @messageIdWithAttachment = "MAILINATOR_TEST_MESSAGE_WITH_ATTACHMENT_ID"
      @attachmentId = "MAILINATOR_TEST_ATTACHMENT_ID"
      @deleteDomain = "MAILINATOR_TEST_DELETE_DOMAIN"
    end

    it "should correctly do manipulation with mailinator data" do

      client = MailinatorClient::Client.new(auth_token: @auth_token)

      response = client.domains.get_domains
      assert response != nil, "Expected get domains response to not be nil"
      assert response["domains"] != nil, "Expected response domains to not be nil"
      @domain = response["domains"][0]
      @domainId = @domain["_id"]
      @domainName = @domain["name"]
      
      response = client.domains.get_domain(domainId:@domainId)
      assert response != nil, "Expected get domain response to not be nil"

      ruleToPost = {
        name:        "RuleName",
        priority:    15,
        description: "Description",
        conditions: [
          {
            operation: "PREFIX",
            condition_data: {
              field: "to",
              value: "raul"
            }
          }
        ],
        enabled: true,
        match:   "ANY",
        actions: [
          {
            action: "WEBHOOK",
            action_data: {
              url: "https://www.google.com"
            }
          }
        ]
      }

      response = client.rules.create_rule(domainId:@domainId, ruleToPost: ruleToPost)
      assert response != nil, "Expected get create rule response to not be nil"
      assert response["_id"] != nil, "Expected response rule id to not be nil"

      response = client.rules.get_all_rules(domainId:@domainId)
      assert response != nil, "Expected get all rules response to not be nil"
      assert response["rules"] != nil, "Expected response rules to not be nil"
      @rule = response["rules"][0]
      @ruleId = @rule["_id"]

      response = client.rules.enable_rule(domainId:@domainId, ruleId: @ruleId)
      assert response != nil, "Expected enable rule response to not be nil"
      assert response["status"] == "ok", "Expected enable rule response to be ok"

      response = client.rules.disable_rule(domainId:@domainId, ruleId: @ruleId)
      assert response != nil, "Expected disable rule response to not be nil"
      assert response["status"] == "ok", "Expected disable rule response to be ok"

      response = client.rules.get_rule(domainId:@domainId, ruleId: @ruleId)
      assert response != nil, "Expected disable rule response to not be nil"
      assert response["_id"] != nil, "Expected get rule response to not be nil"

      response = client.rules.delete_rule(domainId:@deleteDomain, ruleId: @ruleId)
      assert response != nil, "Expected delete rule response to not be nil"
      assert response["status"] == "ok", "Expected delete rule response to be ok"

      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, skip: 0, limit: 50, sort: "ascending", decodeSubject: false)
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
      @message = response["msgs"][0]
      @messageId = @message["id"]

      response = client.messages.fetch_message(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch message response to not be nil"

      response = client.messages.fetch_sms_message(domain:@domainName, inbox: @inboxAll, teamSmsNumber: @teamSMSNumber)
      assert response != nil, "Expected fetch sms message response to not be nil"

      response = client.messages.fetch_attachments(domain:@domainName, inbox: @inbox, messageId: @messageIdWithAttachment)
      assert response != nil, "Expected fetch attachments response to not be nil"

      response = client.messages.fetch_attachment(domain:@domainName, inbox: @inbox, messageId: @messageIdWithAttachment, attachmentId: @attachmentId)
      assert response != nil, "Expected fetch attachment response to not be nil"

      response = client.messages.fetch_message_links(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch message links response to not be nil"
      assert response["links"] != nil, "Expected fetch message links links response to not be nil"

      response = client.messages.delete_message(domain:@deleteDomain, inbox: @inbox, messageId: @messageId)
      assert response != nil, "Expected delete message response to not be nil"
      assert response["status"] == "ok", "Expected delete message response to be ok"

      response = client.messages.delete_all_inbox_messages(domain:@deleteDomain, inbox: @inbox)
      assert response != nil, "Expected delete all inbox messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all inbox messages response to be ok"

      response = client.messages.delete_all_domain_messages(domain:@deleteDomain)
      assert response != nil, "Expected delete all domain messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all domain messages response to be ok"

      messageToPost = {
        subject:"Testing ruby message",
        from:"test_email_ruby@test.com", 
        text:"I love Ruby!"
      }
      response = client.messages.inject_message(domain:@domainName, inbox: @inboxAll, messageToPost: messageToPost)
      assert response != nil, "Expected inject message response to not be nil"
      assert response["status"] == "ok", "Expected inject message response to be ok"

      response = client.stats.get_team_stats
      assert response != nil, "Expected response to not be nil"
      assert response["stats"] != nil, "Expected response stats to not be nil"

      response = client.stats.get_team
      assert response != nil, "Expected response to not be nil"
    end
  end
end
