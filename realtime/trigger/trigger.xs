realtime_trigger trigger {
  channel = "22355457082550|new"

  input {
    enum action {
      values = ["message", "join"]
    }
  
    text channel
    object client {
      schema {
        json extras
        object permissions {
          schema {
            int dbo_id
            text row_id
          }
        }
      }
    }
  
    object options {
      schema {
        bool authenticated
        text channel
      }
    }
  
    json payload
  }

  stack {
  }

  response = $input.payload
  actions = {}
}