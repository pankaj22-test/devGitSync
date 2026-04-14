// Endpoint to list products with their category and calculated discount
// Lists all products, including category details and an optional discount calculation
query products verb=GET {
  api_group = "Store"

  input {
    // Optional discount percentage to apply to all products in the response
    decimal discount_percent? filters=min:0|max:100
  }

  stack {
    // Query the product table and attach the category addon
    db.query product {
      return = {type: "list"}
      addon = [
        {
          name : "product_category"
          input: {category_id: $output.category_id}
          as   : "items.category"
        }
      ]
    } as $products
  
    // Iterate through the products to calculate the discounted price for each
    foreach ($products.items) {
      each as $item {
        // Run the custom discount function
        function.run apply_discount {
          input = {price: $item.price, percent: $input.discount_percent}
        } as $discounted_price
      
        // Add the calculated price to the product object
        var.update $item.discounted_price {
          value = $discounted_price
        }
      }
    }
  }

  response = $products
}