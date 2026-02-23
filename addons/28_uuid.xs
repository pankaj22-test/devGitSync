addon uuid {
  input {
  }

  stack {
    db.query uuid_table {
      return = {type: "list"}
    }
  }
}