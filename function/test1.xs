function test1 {
  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  response = {Integer: $input.Integer}
  middleware = {pre: [{name: ""}]}
}