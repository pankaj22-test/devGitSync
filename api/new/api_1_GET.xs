query "api/1" verb=GET {
  api_group = "new"
  auth = ""

  input {
  }

  stack {
    var $x1 {
      value = "test1"
    }
  
    foreach ($x1) {
      each as $item {
        conditional {
          if () {
            var $x2 {
              value = ""
            }
          }
        }
      }
    }
  }

  response = $x1
}