// Stores system events and log entries
table logs {
  auth = false

  schema {
    int id
    timestamp created_at?=now
  
    // The category of the log (e.g., 'system', 'branch', 'request')
    text type
  
    // The log message content
    text message
  
    // Additional context for the log entry
    json metadata
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "type"}]}
  ]
}