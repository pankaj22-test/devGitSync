// Table to store blog posts
table post {
  auth = false

  schema {
    // Unique identifier for the post
    int id
  
    // When the post was created
    timestamp created_at?=now
  
    // Title of the post
    text title filters=trim
  
    // Content of the post (HTML or Markdown)
    text content
  
    // Reference to the author of the post
    // The author of the post
    int user_id {
      table = "user"
    }
  
    // Reference to the category this post belongs to
    // The category of the post
    int category_id {
      table = "READONLY_FUNCTION_STACK_TEST_DATA_add_more_testing_nname_READONLY_FUNCTION_STACK_TEST_DATA_add_more_testing_nname"
    }
  
    // Whether the post is published and visible to users
    bool is_published?
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "user_id"}]}
    {type: "btree", field: [{name: "category_id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}