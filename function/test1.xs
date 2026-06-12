function test1 {
  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  response = {Integer: $x1}
  middleware = {pre: [{name: ""}]}
}