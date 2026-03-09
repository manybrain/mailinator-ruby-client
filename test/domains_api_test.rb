require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class DomainsApiTest < Minitest::Test
  def test_domains_endpoints
    require_env!("MAILINATOR_TEST_API_TOKEN")

    client = integration_client
    domain_name = first_domain_name(client)

    response = client.domains.get_domain(domainId: domain_name)
    assert response != nil, "Expected get domain response to not be nil"

    skip("Skipping deprecated endpoints: domains.create_domain / domains.delete_domain")
  end
end
