table new1 {
  auth = true

  schema {
    int id
    timestamp created_at?=now {
      visibility = "private"
    }
  
    text name? filters=trim
    int Integer?
    image? image?
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]

  view = {
    new: {
      search: $db.Integer >= "4" || $db.id != "3"
      sort  : {id: "asc"}
      id    : "05913ce6-af59-44ae-a0e4-6ea611a15d10"
    }
  }
}