addon dbtest {
  input {
  }

  stack {
    db.query "" {
      return = {type: "list"}
    }
  }
}