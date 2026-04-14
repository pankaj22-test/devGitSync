// Database trigger that runs after a user is created
// Logs new user creations
table_trigger on_user_create {
  table = "user"

  input {
    json new
    json old
    enum action {
      values = ["insert", "update", "delete", "truncate"]
    }
  
    text datasource
  }

  stack {
    debug.log {
      value = "New user created: " ~ ($input.new.email|to_text)
    }
  }

  actions = {insert: true}
  history = 100
}