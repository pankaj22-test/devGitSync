middleware M2 {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    var $x1 {
      value = "1test1df"
    }
  }

  response = {x111: $x1}
  response_strategy = "merge"
  exception_policy = "silent"
}