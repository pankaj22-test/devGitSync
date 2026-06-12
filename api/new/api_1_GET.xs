query "api/1" verb=GET {
  api_group = "new"
  auth = "new1"

  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  response = $x1
}