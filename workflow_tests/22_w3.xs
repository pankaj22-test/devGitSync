workflow_test W3 {
  stack {
    var $x1 {
      value = 34
    }
  
    expect.to_equal ($x1) {
      value = 34
    }
  }
}