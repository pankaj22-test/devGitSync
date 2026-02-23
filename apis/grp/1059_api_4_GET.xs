query "api/4" verb=GET {
  api_group = "grp"

  input {
  }

  stack {
    var $x1 {
      value = $env.$http_headers
    }
  }

  response = $x1
}