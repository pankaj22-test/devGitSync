// Addon to fetch system logs with optional type filtering
// Query logs table with filtering and pagination
addon logs_addon {
  input {
    // Optional filter by log type (e.g., 'system', 'branch', 'request')
    text type?
  
    // Number of logs to return (default 10)
    int limit?=10
  }

  stack {
    db.query logs {
      where = $db.logs.type ==? $input.type
      sort = {created_at: "desc"}
      return = {type: "list", paging: {page: 1, per_page: $input.limit}}
    }
  }

  tags = ["monitoring"]
}