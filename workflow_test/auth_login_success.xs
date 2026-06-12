// Test for successful user login.
// This verifies that a registered user can obtain an authentication token.
workflow_test auth_login_success {
  stack {
    // Setup: Ensure a test user exists before attempting login
    api.call "" verb=GET {
      api_group = ""
      input = {
        name    : "Login User"
        email   : "login_success@example.com"
        password: "Password123!"
      }
    } as $setup
  
    // Test: Perform login with the created user's credentials
    api.call "" verb=GET {
      api_group = ""
      input = {
        email   : "login_success@example.com"
        password: "Password123!"
      }
    } as $login_res
  
    // Assert that the login was successful and returned a valid token
    expect.to_be_defined ($login_res)
  
    expect.to_not_be_null ($login_res.authToken)
    expect.to_equal ($login_res.authToken) {
      value = $setup.authToken
    }
  }

  tags = ["auth", "login", "success", "smoke-test"]
}