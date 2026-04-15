agent_trigger greeter_agent_connection {
  agent = "greeter_agent"

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