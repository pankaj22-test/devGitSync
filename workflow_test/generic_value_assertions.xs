workflow_test generic_value_assertions {
  stack {
    // String assertions
    var $str {
      value = "XanoScript is powerful"
    }
  
    expect.to_start_with ($str) {
      value = "Xano"
    }
  
    expect.to_end_with ($str) {
      value = "powerful"
    }
  
    expect.to_contain ($str) {
      value = "Script"
    }
  
    expect.to_match ($str) {
      value = "^Xano.*"
    }
  
    // Number assertions
    var $num {
      value = 42
    }
  
    expect.to_be_greater_than ($num) {
      value = 40
    }
  
    expect.to_be_less_than ($num) {
      value = 50
    }
  
    expect.to_be_within ($num) {
      min = 40
      max = 45
    }
  
    expect.to_equal ($num) {
      value = 42
    }
  
    // Boolean and Null assertions
    var $true_val {
      value = true
    }
  
    var $null_val {
      value = null
    }
  
    expect.to_be_true ($true_val)
    expect.to_be_null ($null_val)
    expect.to_not_be_null ($true_val)
  
    // Collection assertions
    var $list {
      value = [1, 2, 3]
    }
  
    expect.to_contain ($list) {
      value = 2
    }
  
    // Test empty array
    var $empty_arr {
      value = []
    }
  
    expect.to_be_empty ($empty_arr)
  }

  tags = ["demo", "assertions"]
}