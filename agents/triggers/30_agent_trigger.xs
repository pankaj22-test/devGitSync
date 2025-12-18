agent_trigger agent_trigger {
  agent = "FreeAgent"

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
      value = "nano"
    }
  }

  response = {toolset: $var.toolset, tools: $tools}
  tags = ["agent", "trigger"]
  actions = {connection: true}
}