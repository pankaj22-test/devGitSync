// Calculates percentage growth between two numbers
// Calculates the percentage increase or decrease between a previous and current value
function "utils/calculate_growth" {
  input {
    // The starting value
    decimal previous
  
    // The new value
    decimal current
  }

  stack {
    // Avoid division by zero
    conditional {
      if ($input.previous == 0) {
        var $growth {
          value = 0
        }
      }
    
      else {
        var $growth {
          value = (($input.current - $input.previous) / $input.previous) * 100
        }
      }
    }
  }

  response = $growth
}