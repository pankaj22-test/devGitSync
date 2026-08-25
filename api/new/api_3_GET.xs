query "api/3" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    db.truncate name1 {
      reset = true
    }
  }

  response = null
}