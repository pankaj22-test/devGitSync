// Negative test for user login with an incorrect password.
// This ensures that invalid credentials do not grant access.
workflow_test auth_login_invalid_password {
  stack {
    // Setup: Create a test user with a known password
    api.call "" verb=GET {
      api_group = ""
      input = {
        name    : "Wrong Pass User"
        email   : "wrong_pass@example.com"
        password: "CorrectPassword123"
      }
    } as $signup
  
    // Test: Attempt to login with the correct email but a wrong password
    expect.to_throw {
      stack {
        api.call "" verb=GET {
          api_group = ""
          input = {
            email   : "wrong_pass@example.com"
            password: "WrongPassword"
          }
        } as $login
      }
    
      exception = "error"
    }
  }

  tags = ["auth", "login", "negative", "security"]
}