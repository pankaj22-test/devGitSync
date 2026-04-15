// Fetches a product by ID and logs the lookup event.
// Fetches a product and logs the access
function "product_service/lookup_and_log" {
  input {
    // The ID of the product to look up.
    int product_id
  }

  stack {
    // 1. Fetch the product
    db.get product {
      field_name = "id"
      field_value = $input.product_id
    } as $product
  
    // 2. Log the access
    conditional {
      if ($product != null) {
        db.add logs {
          data = {
            type    : "request"
            message : "Product lookup successful"
            metadata: {
            product_id  : $input.product_id
            product_name: $product.name
          }
          }
        }
      }
    
      else {
        db.add logs {
          data = {
            type    : "request"
            message : "Product lookup failed - product not found"
            metadata: {product_id: $input.product_id}
          }
        }
      }
    }
  }

  response = $product
}