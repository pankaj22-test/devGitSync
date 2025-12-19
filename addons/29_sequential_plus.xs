addon sequential_plus {
  input {
  }

  stack {
    db.query xanoLinkSequential {
      return = {type: "list"}
    }
  }
}