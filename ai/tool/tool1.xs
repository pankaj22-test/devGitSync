tool tool1 {
  input {
    text name? filters=trim
    int age?
  }

  stack {
    var $x1 {
      value = "new"
    }
  
    var $x2 {
      value = "new1"
    }
  }

  response = {x1: $x1, x2: $x2}
}