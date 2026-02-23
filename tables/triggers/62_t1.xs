table_trigger t1 {
  table = "db1"

  input {
    json new
    json old
    enum action {
      values = ["insert", "update", "delete", "truncate"]
    }
  
    text datasource
  }

  stack {
    var $x1 {
      value = "test1"
    }
  }

  actions = {insert: true, update: true}
}