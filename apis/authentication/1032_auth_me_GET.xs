// Get the user record belonging to the authentication token
query "auth/me" verb=GET {
  api_group = "Authentication"
  auth = "user"

  input {
  }

  stack {
    db.query user {
      return = {type: "list"}
    } as $user1
  }

  response = $user1
}