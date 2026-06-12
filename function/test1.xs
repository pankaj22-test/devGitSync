function test1 {
  input {
  }

  stack {
    var $x1 {
      value = 1..10
    }
  }

  response = {Integer: $input.Integer}
  middleware = {pre: [{name: ""}]}
}