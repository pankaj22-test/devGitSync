tool Tool_1 {
  input {
  }

  stack {
    var $x1 {
      value = 10
    }
  }

  response = $x1
  middleware = {pre: [{name: ""}], post: [{name: ""}]}
}