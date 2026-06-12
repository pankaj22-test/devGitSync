function test1 {
  input {
    int Integer?
  }

  stack {
    !var $x1 {
      value = 1..10
    }
  }

  response = {Integer: $input.Integer, !int_list: $input.int_list}
}