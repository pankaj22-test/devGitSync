// Test for successful user registration.
// This ensures the signup API creates a user and returns a token.
workflow_test auth_signup_success {
  stack {
    // Call the signup endpoint with valid test credentials
    api.call "auth/signup" verb=POST {
      api_group = "Authentication"
      input = {
        name    : "Signup Success"
        email   : "signup_success@example.com"
        password: "Password123!"
      }
    } as $res
  
    // Assert that the response is defined and contain an auth token
    expect.to_be_defined ($res)
  
    expect.to_not_be_null ($res.authToken)
    expect.to_be_greater_than ($res.authToken|strlen) {
      value = 10
    }
  }

  tags = ["auth", "signup", "success", "smoke-test"]
}