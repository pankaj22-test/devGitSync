// Prevents deletion of critical logs
// Ensures critical logs cannot be deleted
table_trigger protect_critical_logs {
  table = "logs"

  input {
    json new
    json old
    enum action {
      values = ["insert", "update", "delete", "truncate"]
    }
  
    text datasource
  }

  stack {
    // Check if the log being deleted is 'critical'
    conditional {
      if ($input.old.type == "critical") {
        throw {
          name = "CriticalLogDeletionError"
          value = "Critical logs cannot be deleted"
        }
      }
    }
  }

  actions = {delete: true, truncate: true}
}