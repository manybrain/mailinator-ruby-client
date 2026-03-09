require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class StatsApiTest < Minitest::Test
  def test_stats_endpoints
    require_env!("MAILINATOR_TEST_API_TOKEN")

    client = integration_client

    response = client.stats.get_team_info
    assert response != nil, "Expected team info response to not be nil"

    response = client.stats.get_team_stats
    assert response != nil, "Expected team stats response to not be nil"
    assert response["stats"] != nil, "Expected response stats to not be nil"

    response = client.stats.get_team
    assert response != nil, "Expected team response to not be nil"
  end
end
