function test1 {
  input {
  }

  stack {
    var $x1 {
      value = 1..10
    }
  }

  response = $x1
}