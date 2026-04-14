middleware M1 {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    var $x1 {
      value = "v1mnewupdate"
    }
  }

  response = {x1: $x1}
  response_strategy = "merge"
  exception_policy = "silent"
}