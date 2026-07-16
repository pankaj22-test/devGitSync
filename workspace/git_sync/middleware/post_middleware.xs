middleware postMiddleware {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    var $x1 {
      value = 10
    }
  }

  response = {x1: $x1}
  response_strategy = "merge"
  exception_policy = "silent"
}