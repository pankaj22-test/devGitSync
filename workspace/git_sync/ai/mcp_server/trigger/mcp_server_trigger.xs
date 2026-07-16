mcp_server_trigger mcp_server_trigger {
  mcp_server = "TestMCPServer"

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
    var $toolset {
      value = $input.toolset
    }
  
    var $tools {
      value = $input.tools
    }
  
    var $x1 {
      value = "hello_world"
    }
  }

  response = {toolset: $var.toolset, tools: $tools}
  actions = {connection: true}
}