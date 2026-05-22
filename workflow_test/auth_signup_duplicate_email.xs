// Negative test for user registration with a duplicate email.
// This ensures the system prevents multiple accounts with the same email.
workflow_test auth_signup_duplicate_email {
  stack {
    // Setup: Create an initial user
    api.call "auth/signup" verb=POST {
      api_group = "Authentication"
      input = {
        name    : "First User"
        email   : "duplicate@example.com"
        password: "Password123!"
      }
    } as $first
  
    // Test: Attempt to sign up again with the same email, which should fail
    expect.to_throw {
      stack {
        api.call "auth/signup" verb=POST {
          api_group = "Authentication"
          input = {
            name    : "Second User"
            email   : "duplicate@example.com"
            password: "Password123!"
          }
        } as $second
      }
    
      exception = "error"
    }
  }

  tags = ["auth", "signup", "negative", "validation"]
}