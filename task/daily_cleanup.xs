// Scheduled task to clean up old logs
// Deletes logs that are older than 30 days
task daily_cleanup {
  stack {
    // Calculate the cutoff timestamp (30 days ago)
    var $cutoff {
      value = now|transform_timestamp:"-30 days"
    }
  
    // Find logs to delete
    db.query logs {
      where = $db.logs.created_at < $cutoff && $db.logs.type != "critical"
      return = {type: "list"}
    } as $old_logs
  
    // Delete each log
    foreach ($old_logs) {
      each as $log {
        db.del logs {
          field_name = "id"
          field_value = $log.id
        }
      }
    }
  
    // Log the cleanup action
    db.add logs {
      data = {
        type    : "system"
        message : "Daily cleanup completed"
        metadata: {deleted_count: $old_logs|count, cutoff: $cutoff}
      }
    }
  }

  schedule = [{starts_on: 2024-01-01 00:00:00+0000, freq: 86400}]
}