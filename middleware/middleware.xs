middleware Middleware {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    var $x1 {
      value = "new"
    }
  }

  response = {x1: $x1}
  response_strategy = "merge"
  exception_policy = "silent"

  test "Unit-md" {
    input = {vars: {}, type: "pre"}
  
    expect.to_equal ($response.x1) {
      value = "new"
    }
  }
}