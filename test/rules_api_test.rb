require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class RulesApiTest < Minitest::Test
  def test_rules_endpoints
    skip("Skipping deprecated endpoints: rules.*")
  end
end
