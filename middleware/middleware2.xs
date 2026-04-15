// new changes
middleware Middleware2 {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    var $x1 {
      value = "1test1dff"
    }
  }

  response = {x111: $x1}
  response_strategy = "merge"
  exception_policy = "silent"
}