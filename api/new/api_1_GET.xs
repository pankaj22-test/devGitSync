query "api/1" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run add_numbers {
      input = {a: 1..20, b: 1..10}
    } as $func1
  }

  response = $func1
}