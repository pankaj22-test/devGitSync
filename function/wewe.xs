function wewe {
  input {
  }

  stack {
    var $x1 {
      value = $env.$datasource
    }
  }

  response = $x1
}