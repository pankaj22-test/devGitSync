// Middleware to validate an API key in the request
// If successful, return authentication status
// Validates an API key
middleware api_key_validator {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    // Ensure API key is provided
    precondition ($input.api_key != null && $input.api_key != "") {
      error_type = "accessdenied"
      error = "API Key missing"
    }
  
    // Check if the key is valid
    var $is_valid {
      value = $input.api_key == "secret-123"
      mock = {"Valid API Key": true, "Invalid API Key": false}
    }
  
    // Throw error if key is invalid
    precondition ($is_valid) {
      error_type = "accessdenied"
      error = "Invalid API Key"
    }
  }

  response = {
    authenticated: true
    key_prefix   : $input.api_key|substr:0:3
  }

  response_strategy = "merge"
  exception_policy = "rethrow"

  test "Valid API Key" {
    input = {api_key: "secret-123"}
  
    expect.to_equal ($response.authenticated) {
      value = true
    }
  
    expect.to_match ($response.key_prefix) {
      value = "^[a-z]+$"
    }
  }

  test "Invalid API Key" {
    input = {api_key: "wrong-key"}
  
    expect.to_throw
  }

  test "Missing API Key" {
    input = {api_key: null}
  
    expect.to_throw
  }
}