// Function to calculate a discounted price
// Applies a percentage discount to a price
function apply_discount {
  input {
    // The original price of the product
    decimal price filters=min:0
  
    // The discount percentage (e.g., 20 for 20%)
    decimal percent? filters=min:0|max:100
  }

  stack {
    // Calculate the discount amount
    var $discount_amount {
      value = $input.price * ($input.percent / 100)
    }
  
    // Subtract the discount from the original price
    var $final_price {
      value = $input.price - $discount_amount
    }
  }

  response = $final_price
}