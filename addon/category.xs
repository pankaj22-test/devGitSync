addon category {
  input {
  }

  stack {
    db.query category {
      return = {type: "list"}
    }
  }
}