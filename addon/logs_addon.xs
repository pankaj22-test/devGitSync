// f
addon logs_addon {
  input {
  }

  stack {
    db.query logs {
      return = {type: "list"}
    }
  }

  tags = ["monitoring"]
}