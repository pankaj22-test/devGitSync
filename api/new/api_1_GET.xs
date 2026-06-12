query "api/1" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run test1 {
      input = {Integer: 0, int_list: []}
    } as $func1
  }

  response = $func1
}