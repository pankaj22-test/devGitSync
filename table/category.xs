// Table to store blog categories
table category {
  auth = false

  schema {
    // Unique identifier for the category
    int id
  
    // When the category was created
    timestamp created_at?=now
  
    // Name of the category (e.g., Technology, Lifestyle)
    text name filters=trim
  
    // The food associated with this category
    text food? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree|unique", field: [{name: "name"}]}
    {type: "btree", field: [{name: "food"}]}
  ]
}