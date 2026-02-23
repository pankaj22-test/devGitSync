table db1 {
  auth = false

  schema {
    int id
    timestamp created_at?=now
    text text? filters=trim
    image? image?
    image[]? im?
    attachment? file?
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}