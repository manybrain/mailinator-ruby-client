require "rubygems"

gem "minitest"
require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "webmock/minitest"
require_relative "../lib/mailinator_client"

# Lightweight .env loader to support local integration test runs without extra gems.
env_file = File.expand_path("../.env", __dir__)
if File.exist?(env_file)
  File.foreach(env_file) do |line|
    line = line.strip
    next if line.empty? || line.start_with?("#")
    key, value = line.split("=", 2)
    next if key.nil? || key.empty?
    next if ENV.key?(key)
    ENV[key] = value.to_s
  end
end

class Minitest::Test
  def setup
    WebMock.allow_net_connect!
    #WebMock.disable_net_connect!
    #WebMock.allow_net_connect!(net_http_connect_on_start: true)
  end

  def require_env!(*keys)
    missing = keys.flatten.select { |k| ENV[k].to_s.strip.empty? }
    skip("Missing required env vars: #{missing.join(', ')}") unless missing.empty?
  end

  def integration_client
    MailinatorClient::Client.new(auth_token: ENV["MAILINATOR_TEST_API_TOKEN"])
  end

  def first_domain_name(client = integration_client)
    response = client.domains.get_domains
    assert response != nil, "Expected get domains response to not be nil"
    assert response["domains"] != nil, "Expected response domains to not be nil"
    assert !response["domains"].empty?, "Expected at least one domain in response"
    response["domains"][0]["name"]
  end
end
