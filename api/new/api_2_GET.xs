query "api/2" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run "" as $func1
  }

  response = $func1
}