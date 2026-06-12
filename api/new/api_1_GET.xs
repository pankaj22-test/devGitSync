query "api/1" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run test1 {
      input = {Integer: 1..10, int_list: []|push:1..10}
    } as $func1
  }

  response = $func1
}