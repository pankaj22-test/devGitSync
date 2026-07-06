// Returns a list of food items
// Get a list of hardcoded food items
query list verb=GET {
  api_group = "food"

  input {
  }

  stack {
    // Define a hardcoded list of food
    var $food_list {
      value = [
        { name: "Apple", type: "Fruit", calories: 95 }
        { name: "Pizza", type: "Fast Food", calories: 285 }
        { name: "Salmon", type: "Protein", calories: 208 }
        { name: "Broccoli", type: "Vegetable", calories: 31 }
      ]
    }
  }

  response = $food_list
}