// Table to store comments on blog posts
table comment {
  auth = false

  schema {
    // Unique identifier for the comment
    int id
  
    // When the comment was created
    timestamp created_at?=now
  
    // Reference to the post being commented on
    // The post this comment belongs to
    int post_id {
      table = "post"
    }
  
    // Reference to the user who wrote the comment
    // The author of the comment
    int user_id {
      table = "user"
    }
  
    // The content of the comment
    text content filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "post_id"}]}
    {type: "btree", field: [{name: "user_id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}