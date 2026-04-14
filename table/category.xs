// Table to store product categories
table category {
  auth = false

  schema {
    int id
    text name filters=trim
  }

  index = [{type: "primary", field: [{name: "id"}]}]
}