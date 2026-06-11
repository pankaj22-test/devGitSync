addon category {
  input {
  }

  stack {
    db.query READONLY_FUNCTION_STACK_TEST {
      return = {type: "list"}
    }
  }
}