query "api/1" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  response = $x1
}