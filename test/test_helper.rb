require "rubygems"

gem "minitest"
require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "webmock/minitest"
require_relative "../lib/mailinator_client"

class MiniTest::Test
  def setup
    WebMock.allow_net_connect!
    #WebMock.disable_net_connect!
    #WebMock.allow_net_connect!(net_http_connect_on_start: true)
  end
end
