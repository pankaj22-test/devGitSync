// new descriptio
tool tool1 {
  input {
    text name? filters=trim
  }

  stack {
    var $x1 {
      value = "new"
    }
  }

  response = {x1: $x1}
  tags = ["d"]
}