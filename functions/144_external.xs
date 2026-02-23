function external {
  input {
  }

  stack {
    db.query user {
      return = {type: "list"}
    } as $promoted_updates|set:"promotion_id":$promotion_id
  }

  response = $x1
}