query new verb=GET {
  api_group = "api/2"

  input {
  }

  stack {
    var $x1 {
      value = `$chunk|map:($$:binary_user_id)`
    }
  }

  response = $x1
}