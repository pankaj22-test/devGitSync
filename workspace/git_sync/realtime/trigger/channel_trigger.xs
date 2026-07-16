realtime_trigger channel_trigger {
  channel = "47286766384427|test1"

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
    var $x1 {
      value = 123456
    }
  }

  response = $input.payload
  actions = {}
}