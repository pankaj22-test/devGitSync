// Tool to get the current system status
// Returns the current health and status of the system
tool get_status {
  instructions = "Use this tool when a user asks about system health or status."

  input {
  }

  stack {
    var $status {
      value = {health: "ok", uptime: "99.9%", timestamp: now}
    }
  }

  response = $status
}