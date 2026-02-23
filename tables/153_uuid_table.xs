table uuid_table {
  auth = false

  schema {
    uuid id
    timestamp created_at?=now
    uuid[]? uuid_list?
    uuid? uuid?
    text[] TEXT? filters=trim
    text test? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}