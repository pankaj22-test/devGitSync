addon logs_addon_1 {
  input {
  }

  stack {
    db.query logs {
      return = {type: "list"}
    }
  }
}