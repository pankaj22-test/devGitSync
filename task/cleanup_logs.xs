// Task to clean up old logs
// Run daily at midnight
// Deletes logs older than 30 days
task cleanup_logs {
  stack {
    // Calculate cutoff date
    var $cutoff {
      value = now|transform_timestamp:"-30 days"
    }
  
    // Bulk delete old logs
    db.bulk.delete "" {
      where = $db.audit_log.created_at < $cutoff
    } as $deleted_count
  
    debug.log {
      value = "Deleted " ~ ($deleted_count|to_text) ~ " logs"
    }
  }

  schedule = [{starts_on: 2024-01-01 00:00:00+0000, freq: 86400}]
}