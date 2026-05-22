// Negative test for accessing protected routes without authorization.
// This ensures that endpoints requiring authentication are properly secured.
workflow_test auth_profile_unauthorized {
  stack {
    // Test: Access a protected route without providing any Authorization header
    expect.to_throw {
      stack {
        api.call "" verb=GET {
          api_group = ""
        } as $res
      }
    
      exception = "error"
    }
  
    // Test: Access a protected route providing an invalid Authorization token
    expect.to_throw {
      stack {
        api.call "" verb=GET {
          api_group = ""
          headers = ["Authorization: Bearer invalid_token"]
        } as $res
      }
    
      exception = "error"
    }
  }

  tags = ["auth", "profile", "negative", "security"]
}