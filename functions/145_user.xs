function user {
  input {
  }

  stack {
    db.query user {
      return = {type: "list"}
    } as $user1
  }

  response = $user1
}