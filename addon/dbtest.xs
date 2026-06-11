addon dbtest {
  input {
  }

  stack {
    db.query dbtest1 {
      return = {type: "list"}
    }
  }
}