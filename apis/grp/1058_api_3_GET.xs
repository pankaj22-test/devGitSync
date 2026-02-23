query "api/3" verb=GET {
  api_group = "grp"

  input {
  }

  stack {
    function.run user as $func1
  }

  response = $func1
}