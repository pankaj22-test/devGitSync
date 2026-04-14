// Middleware to check if a request is authorized
// Ensures the request has a valid auth token
middleware auth_check {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    // Example: Check if user is authenticated via $auth
    conditional {
      if ($auth.id == null) {
        // Stop execution if not authenticated
        throw {
          name = "Unauthorized"
          value = "You must be logged in to access this resource"
        }
      }
    }
  }

  response = {authenticated: true}
  response_strategy = "merge"
  exception_policy = "rethrow"
}