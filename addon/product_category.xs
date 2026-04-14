// Addon to fetch category details for a product
addon product_category {
  input {
    // ID of the category to fetch
    int category_id
  }

  stack {
    db.query category {
      where = $db.category.id == $input.category_id
      return = {type: "single"}
    }
  }
}