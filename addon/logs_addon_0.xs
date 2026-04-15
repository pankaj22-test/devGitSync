addon logs_addon_0 {
  input {
  }

  stack {
    db.query logs {
      return = {type: "list"}
    }
  }
}