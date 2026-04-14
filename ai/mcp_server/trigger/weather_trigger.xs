// MCP Server trigger to handle tool calls
// Handles weather server connections
// Predefined MCP Server Trigger Input
mcp_server_trigger weather_trigger {
  mcp_server = "weather_server"

  input {
    object toolset {
      schema {
        int id
        text name
        text instructions
      }
    }
  
    object[] tools {
      schema {
        int id
        text name
        text instructions
      }
    }
  }

  stack {
    // Log the connection
    debug.log {
      value = "MCP Client connected to: " ~ ($input.toolset.name|to_text)
    }
  
    // Prepare response
    var $result {
      value = {status: "ready", tools_available: $input.tools|count}
    }
  }

  response = $result
  history = false
  actions = {connection: true}
}