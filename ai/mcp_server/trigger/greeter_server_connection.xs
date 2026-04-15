mcp_server_trigger greeter_server_connection {
  mcp_server = "greeter_server"

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
  }

  response = null
  actions = {}
}