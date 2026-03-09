require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class AuthenticatorsApiTest < Minitest::Test
  def test_authenticators_endpoints
    require_env!(
      "MAILINATOR_TEST_API_TOKEN",
      "MAILINATOR_TEST_AUTH_SECRET",
      "MAILINATOR_TEST_AUTH_ID"
    )

    client = integration_client

    response = client.authenticators.instant_totp_2fa_code(totpSecretKey: ENV["MAILINATOR_TEST_AUTH_SECRET"])
    assert response != nil, "Expected instant totp 2fa code response to not be nil"

    response = client.authenticators.get_authenticators()
    assert response != nil, "Expected get authenticators response to not be nil"

    response = client.authenticators.get_authenticators_by_id(id: ENV["MAILINATOR_TEST_AUTH_ID"])
    assert response != nil, "Expected get authenticators by id response to not be nil"

    response = client.authenticators.get_authenticator()
    assert response != nil, "Expected get authenticator response to not be nil"

    response = client.authenticators.get_authenticator_by_id(id: ENV["MAILINATOR_TEST_AUTH_ID"])
    assert response != nil, "Expected get authenticator by id response to not be nil"
  end
end
