tool Tool_2 {
  input {
  }

  stack {
    var $x1 {
      value = "Hello"
    }
  }

  response = $x1
  middleware = {pre: [{name: ""}], post: [{name: ""}]}
}