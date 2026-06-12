function test1 {
  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  response = {x1: $x1}
  middleware = {pre: [{name: ""}]}
}