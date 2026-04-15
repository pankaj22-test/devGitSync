addon logs_addon {
  input {
    text name? filters=trim
  }

  stack {
    db.query logs {
      join = {logs_2: {table: "logs"}}
      where = $input.name == "w"
      return = {type: "list"}
    }
  }
}