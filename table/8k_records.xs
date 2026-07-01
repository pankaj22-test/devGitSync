table "8k-records" {
  auth = false

  schema {
    int id
    int Year?
    text Industry_aggregation_NZSIOC?
    text Industry_code_NZSIOC?
    text Industry_name_NZSIOC?
    text Units?
    text Variable_code?
    text Variable_name?
    text Variable_category?
    text Value?
    text Industry_code_ANZSIC06?
  }

  index = [{type: "primary", field: [{name: "id"}]}]
}