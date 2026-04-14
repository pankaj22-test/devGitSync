// Trigger for the system_info MCP server
// Handles connection events for the system_info MCP server
mcp_server_trigger system_info_handler {
  mcp_server = "system_info"

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
    // Log the MCP server connection
    db.add logs {
      data = {
        type    : "mcp"
        message : "MCP Server connected: " ~ $input.toolset.name
        metadata: {server: $input.toolset, tools: $input.tools}
      }
    }
  }

  response = {status: "ready", server: $input.toolset.name}
  actions = {connection: true}
}