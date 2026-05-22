// Stores information about food recipes created by users.
table recipe {
  auth = false

  schema {
    int id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    // The name of the recipe.
    text name? filters=trim
  
    // A brief description of the recipe.
    text description? filters=trim
  
    // Detailed cooking instructions for the recipe.
    text instructions? filters=trim
  
    // Estimated preparation time in minutes.
    int prep_time_minutes?
  
    // Estimated cooking time in minutes.
    int cook_time_minutes?
  
    // Number of servings the recipe yields.
    int servings?
  
    // Image of the finished dish.
    image image?
  
    // The user who created this recipe.
    int user? {
      table = "user"
    }
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}