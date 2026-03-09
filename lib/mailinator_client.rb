require_relative "mailinator_client/version"
require_relative "mailinator_client/error"
require_relative "mailinator_client/utils"
require_relative "mailinator_client/authenticators"
require_relative "mailinator_client/domains"
require_relative "mailinator_client/stats"
require_relative "mailinator_client/messages"
require_relative "mailinator_client/rules"
require_relative "mailinator_client/webhooks"
require_relative "mailinator_client/client"

module MailinatorClient

  def self.client
    @client ||= Client.new
  end

  def self.method_missing(sym, *args, &block)
    self.client.__send__(sym, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    self.client.respond_to?(method_name, include_private)
  end

end
