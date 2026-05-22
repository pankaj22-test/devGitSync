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

  view = {
    new: {
      search: $db.id <= "5"
      sort  : {id: "asc"}
      id    : "eb6f3b7b-fb65-4ded-979f-0994e3b6250d"
    }
  }
}