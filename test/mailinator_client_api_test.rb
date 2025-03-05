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
      @webhookTokenPrivateDomain= "MAILINATOR_TEST_WEBHOOKTOKEN_PRIVATEDOMAIN"
      @webhookTokenCustomService = "MAILINATOR_TEST_WEBHOOKTOKEN_CUSTOMSERVICE"
      @authSecret = "MAILINATOR_TEST_AUTH_SECRET"
      @authId = "MAILINATOR_TEST_AUTH_ID"
      @webhookInbox = "MAILINATOR_TEST_WEBHOOK_INBOX"
      @webhookCustomService = "MAILINATOR_TEST_WEBHOOK_CUSTOMSERVICE"
    end

    it "should correctly do manipulation with mailinator data" do

      client = MailinatorClient::Client.new(auth_token: @auth_token)

      response = client.authenticators.instant_totp_2fa_code(totpSecretKey: @authSecret)
      assert response != nil, "Expected instant totp 2fa code response to not be nil"
      
      response = client.authenticators.get_authenticators()
      assert response != nil, "Expected get authenticators response to not be nil"
      
      response = client.authenticators.get_authenticators_by_id(id: @authId)
      assert response != nil, "Expected get authenticators by id response to not be nil"
      
      response = client.authenticators.get_authenticator()
      assert response != nil, "Expected get authenticator response to not be nil"
      
      response = client.authenticators.get_authenticator_by_id(id: @authId)
      assert response != nil, "Expected get authenticator by id response to not be nil"

      response = client.domains.get_domains
      assert response != nil, "Expected get domains response to not be nil"
      assert response["domains"] != nil, "Expected response domains to not be nil"
      @domain = response["domains"][0]
      @domainId = @domain["_id"]
      @domainName = @domain["name"]
      
      response = client.domains.get_domain(domainId:@domainName)
      assert response != nil, "Expected get domain response to not be nil"

      @domainNameToAdd = "testruby.testinator.com"

      response = client.domains.create_domain(domainId:@domainNameToAdd)
      assert response != nil, "Expected create domain response to not be nil"
      #assert response["status"] == "ok", "Expected create domain response to be ok"

      response = client.domains.delete_domain(domainId:@domainNameToAdd)
      assert response != nil, "Expected delete domain response to not be nil"
      #assert response["status"] == "ok", "Expected delete domain response to be ok"
      
      random_string = SecureRandom.hex(4)
      ruleToPost = {
        name:        "RuleName_RubyTest_#{random_string}",
        priority:    15,
        description: "Description_RubyTest_#{random_string}",
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

      response = client.rules.create_rule(domainId:@domainName, ruleToPost: ruleToPost)
      assert response != nil, "Expected get create rule response to not be nil"
      assert response["_id"] != nil, "Expected response rule id to not be nil"

      response = client.rules.get_all_rules(domainId:@domainName)
      assert response != nil, "Expected get all rules response to not be nil"
      assert response["rules"] != nil, "Expected response rules to not be nil"
      @rule = response["rules"][0]
      @ruleId = @rule["_id"]

      response = client.rules.enable_rule(domainId:@domainName, ruleId: @ruleId)
      assert response != nil, "Expected enable rule response to not be nil"
      assert response["status"] == "ok", "Expected enable rule response to be ok"

      response = client.rules.disable_rule(domainId:@domainName, ruleId: @ruleId)
      assert response != nil, "Expected disable rule response to not be nil"
      assert response["status"] == "ok", "Expected disable rule response to be ok"

      response = client.rules.get_rule(domainId:@domainName, ruleId: @ruleId)
      assert response != nil, "Expected disable rule response to not be nil"
      assert response["_id"] != nil, "Expected get rule response id to not be nil"

      response = client.rules.delete_rule(domainId:@deleteDomain, ruleId: @ruleId)
      assert response != nil, "Expected delete rule response to not be nil"
      assert response["status"] == "ok", "Expected delete rule response to be ok"

      messageToPost = {
        subject:"Testing ruby message",
        from:"test_email_ruby@test.com", 
        text:"I love Ruby!"
      }
      response = client.messages.post_message(domain:@domainName, inbox: @inboxAll, messageToPost: messageToPost)
      assert response != nil, "Expected post message response to not be nil"
      assert response["status"] == "ok", "Expected post message response to be ok"

      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, skip: 0, limit: 1, sort: "ascending", decodeSubject: false)
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
      @message = response["msgs"][0]
      @messageId = @message["id"]

      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, limit: 1, cursor: response["cursor"])
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"

      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, limit: 1, full: true)
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"

      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, limit: 1, delete: "1m")
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
      
      response = client.messages.fetch_inbox(domain:@domainName, inbox: @inboxAll, limit: 1, wait: "1m")
      assert response != nil, "Expected fetch inbox response to not be nil"
      assert response["msgs"] != nil, "Expected response fetch inbox messages to not be nil"
      
      response = client.messages.fetch_inbox_message(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch inbox message response to not be nil"

      response = client.messages.fetch_message(domain:@domainName, messageId: @messageId)
      assert response != nil, "Expected fetch message response to not be nil"
      
      response = client.messages.fetch_message(domain:@domainName, messageId: @messageId, delete: "10s")
      assert response != nil, "Expected fetch message response to not be nil"

      response = client.messages.fetch_sms_message(domain:@domainName, teamSmsNumber: @teamSMSNumber)
      assert response != nil, "Expected fetch sms message response to not be nil"

      response = client.messages.fetch_inbox_message_attachments(domain:@domainName, inbox: @inbox, messageId: @messageIdWithAttachment)
      assert response != nil, "Expected fetch inbox message attachments response to not be nil"

      response = client.messages.fetch_message_attachments(domain:@domainName, messageId: @messageIdWithAttachment)
      assert response != nil, "Expected fetch message attachments response to not be nil"

      response = client.messages.fetch_inbox_message_attachment(domain:@domainName, inbox: @inbox, messageId: @messageIdWithAttachment, attachmentId: @attachmentId)
      assert response != nil, "Expected fetch inbox message attachment response to not be nil"

      response = client.messages.fetch_message_attachment(domain:@domainName, messageId: @messageIdWithAttachment, attachmentId: @attachmentId)
      assert response != nil, "Expected fetch message attachment response to not be nil"

      response = client.messages.fetch_message_links_full(domain:@domainName, messageId: @messageId)
      assert response != nil, "Expected fetch message links full response to not be nil"
      assert response["links"] != nil, "Expected fetch message links links full response to not be nil"

      response = client.messages.fetch_message_links(domain:@domainName, messageId: @messageId)
      assert response != nil, "Expected fetch message links response to not be nil"
      assert response["links"] != nil, "Expected fetch message links links response to not be nil"
      
      response = client.messages.fetch_inbox_message_links(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch inbox message links response to not be nil"
      assert response["links"] != nil, "Expected fetch inbox message links links response to not be nil"

      response = client.messages.fetch_message_smtp_log(domain:@domainName, messageId: @messageId)
      assert response != nil, "Expected fetch message smtp log response to not be nil"
      
      response = client.messages.fetch_inbox_message_smtp_log(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch inbox message smtp log response to not be nil"
      
      response = client.messages.fetch_message_raw(domain:@domainName, messageId: @messageId)
      assert response != nil, "Expected fetch message raw response to not be nil"
      
      response = client.messages.fetch_inbox_message_raw(domain:@domainName, inbox: @inboxAll, messageId: @messageId)
      assert response != nil, "Expected fetch inbox message raw response to not be nil"
      
      response = client.messages.fetch_latest_messages(domain:@domainName)
      assert response != nil, "Expected fetch latest messages response to not be nil"
      
      response = client.messages.fetch_latest_inbox_messages(domain:@domainName, inbox: @inboxAll)
      assert response != nil, "Expected fetch latest inbox message response to not be nil"
      
      response = client.messages.delete_message(domain:@deleteDomain, inbox: @inbox, messageId: @messageId)
      assert response != nil, "Expected delete message response to not be nil"
      assert response["status"] == "ok", "Expected delete message response to be ok"

      response = client.messages.delete_all_inbox_messages(domain:@deleteDomain, inbox: @inbox)
      assert response != nil, "Expected delete all inbox messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all inbox messages response to be ok"

      response = client.messages.delete_all_domain_messages(domain:@deleteDomain)
      assert response != nil, "Expected delete all domain messages response to not be nil"
      assert response["status"] == "ok", "Expected delete all domain messages response to be ok"

      response = client.stats.get_team_info
      assert response != nil, "Expected response to not be nil"
      assert response != nil, "Expected response team info to not be nil"

      response = client.stats.get_team_stats
      assert response != nil, "Expected response to not be nil"
      assert response["stats"] != nil, "Expected response stats to not be nil"

      response = client.stats.get_team
      assert response != nil, "Expected response to not be nil"

      webhook = {
        from:"MyMailinatorRubyTest",
        subject:"testing message",
        text:"hello world",
        to:"jack"
      }

      clientWithoutAuthToken = MailinatorClient::Client.new()
      
      response = clientWithoutAuthToken.webhooks.private_webhook(whToken: @webhookTokenPrivateDomain, webhook:webhook)
      assert response != nil, "Expected private webhook status response to not be nil"
      assert response["status"] == "ok", "Expected private webhook response to be ok"

      response = clientWithoutAuthToken.webhooks.private_inbox_webhook(whToken: @webhookTokenPrivateDomain, inbox: @webhookInbox, webhook:webhook)
      assert response != nil, "Expected private inbox webhook response to not be nil"
      assert response["status"] == "ok", "Expected private inbox webhook response to be ok"

      response = clientWithoutAuthToken.webhooks.private_custom_service_webhook(whToken: @webhookTokenPrivateDomain, customService: @webhookCustomService, webhook:webhook)
      #assert response != nil, "Expected private custom service webhook response to not be nil"
      
      response = clientWithoutAuthToken.webhooks.private_custom_service_inbox_webhook(whToken: @webhookTokenPrivateDomain, customService: @webhookCustomService, inbox: @webhookInbox, webhook:webhook)
      #assert response != nil, "Expected private custom service inbox webhook response to not be nil"
      
    end
  end
end
