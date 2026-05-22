table dbtest1 {
  auth = false

  schema {
    int id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    text[] text? filters=trim
    text txx? filters=trim
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]

  autocomplete = [{name: "txx"}]
  view = {
    nw: {
      search: $db.id != "2"
      sort  : {id: "asc"}
      id    : "26773ed5-bb63-4fba-ba71-7e580699fb75"
    }
  }
}