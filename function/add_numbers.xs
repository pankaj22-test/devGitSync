// Adds two numbers and provides metadata about the result
// Return the result and some metadata
// Adds two numbers and performs various assertions
function add_numbers {
  input {
    // The first number
    decimal a
  
    // The second number
    decimal b
  }

  stack {
    // Calculate the sum
    var $sum {
      value = $input.a + $input.b
    }
  
    // Check if the sum is positive
    var $is_positive {
      value = $sum > 0
    }
  }

  response = {
    sum        : $sum
    is_positive: $is_positive
    items      : [$input.a, $input.b]
    extra      : null
  }

  test "Addition of positive numbers" {
    input = {a: 10, b: 20}
  
    expect.to_equal ($response.sum) {
      value = 30
    }
  
    expect.to_be_true ($response.is_positive)
    expect.to_be_greater_than ($response.sum) {
      value = 25
    }
  
    expect.to_contain ($response.items) {
      value = 10
    }
  }

  test "Addition of negative numbers" {
    input = {a: -10, b: -5}
  
    expect.to_equal ($response.sum) {
      value = -15
    }
  
    expect.to_be_false ($response.is_positive)
    expect.to_be_less_than ($response.sum) {
      value = 0
    }
  }

  test "Zero result" {
    input = {a: 5, b: -5}
  
    expect.to_equal ($response.sum) {
      value = 0
    }
  
    expect.to_be_false ($response.is_positive)
    expect.to_be_null ($response.extra)
  }

  test Unit_func {
    input = {a: 1, b: 3}
  
    expect.to_equal ($response.sum) {
      value = 4
    }
  
    expect.to_equal ($response.is_positive) {
      value = false
    }
  
    expect.to_equal ($response.items) {
      value = "[1,3]"|json_decode
    }
  
    expect.to_equal ($response.extra) {
      value = null
    }
  }
}