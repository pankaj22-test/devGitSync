// Trigger for the customer service agent
// Handles initialization for the customer service agent
agent_trigger customer_service_handler {
  agent = "customer_service"

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
    db.add logs {
      data = {
        type    : "agent"
        message : "Agent connected: " ~ $input.toolset.name
        metadata: {
        toolset        : $input.toolset
        tools_available: $input.tools|count
      }
      }
    }
  }

  response = {status: "initialized", tools: $input.tools|count}
  actions = {connection: true}
}