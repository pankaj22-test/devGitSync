addon logs_addon_2 {
  input {
  }

  stack {
    db.query logs {
      return = {type: "list"}
    }
  }
}