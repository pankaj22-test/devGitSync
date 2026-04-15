function tool1 {
  input {
    text name? filters=trim
  }

  stack {
    var $x1 {
      value = "new"
    }
  }

  response = {x1: $x1}
}