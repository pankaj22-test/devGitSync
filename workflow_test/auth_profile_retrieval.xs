// Test for retrieving the authenticated user's profile.
// This ensures that the token can be used to access protected resources.
workflow_test auth_profile_retrieval {
  stack {
    // Setup: Register a user and capture their authentication token
    api.call "" verb=GET {
      api_group = ""
      input = {
        name    : "Profile User"
        email   : "profile_test@example.com"
        password: "Password123!"
      }
    } as $signup
  
    // Test: Access the 'me' endpoint using the token in the Authorization header
    api.call "" verb=GET {
      api_group = ""
      headers = ["Authorization: Bearer " + $signup.authToken]
    } as $me_res
  
    // Assert that the returned profile correctly matches the user's details
    expect.to_be_defined ($me_res)
  
    expect.to_equal ($me_res.email) {
      value = "profile_test@example.com"
    }
  
    expect.to_equal ($me_res.name) {
      value = "Profile User"
    }
  }

  tags = ["auth", "profile", "success", "smoke-test"]
}