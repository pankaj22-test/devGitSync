function user {
  input {
  }

  stack {
    db.query user {
      return = {type: "list"}
      addon = [{name: "uuid", as: "_uuid"}]
    } as $user1
  }

  response = $user1
}