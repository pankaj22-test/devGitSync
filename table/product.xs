// Table to store product information
table product {
  auth = false

  schema {
    int id
    text name filters=trim
  
    // The price column includes a 'min:0' filter as requested
    decimal price filters=min:0
  
    int category_id {
      table = "category"
    }
  
    timestamp created_at?=now
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "category_id"}]}
  ]

  view = {
    new: {
      search: $db.id >= "10"
      sort  : {id: "asc"}
      id    : "ae14c1fd-fdab-46b3-bf05-1971e52a0910"
    }
  }
}