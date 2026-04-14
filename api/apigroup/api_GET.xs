query api verb=GET {
  api_group = "apigroup"

  input {
  }

  stack {
    var $x1 {
      value = "apiv1newupdate"
    }
  }

  response = $x1
}