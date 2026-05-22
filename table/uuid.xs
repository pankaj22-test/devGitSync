table uuid {
  auth = false

  schema {
    uuid id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    uuid[]? uuid?
    image? image?
    image[]? im?
    int dbtest1_id? {
      table = "dbtest1"
    }
  
    text text? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}