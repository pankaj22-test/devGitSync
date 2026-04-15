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
  
    var $x2 {
      value = "test12df"
    }
  }

  response = {x111: $x1, x222: $x2}
  response_strategy = "merge"
  exception_policy = "silent"
}