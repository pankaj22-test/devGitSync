query "api/1" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run test1 {
      input = {Integer: 100}
    } as $func1
  }

  response = $func1
}