// Middleware to log incoming requests
// Logs metadata for every incoming request
middleware request_logger {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    // Generate a unique ID for the request
    security.create_uuid as $request_id
  
    // Only log on 'pre' to capture request start
    conditional {
      if ($input.type == "pre") {
        db.add logs {
          data = {
            type    : "request"
            message : "Incoming " ~ $input.vars.method ~ " request to " ~ $input.vars.path
            metadata: {
            headers   : $input.vars.headers
            params    : $input.vars.params
            request_id: $request_id
          }
          }
        }
      }
    }
  }

  response = {logger_status: "active", request_id: $request_id}
  response_strategy = "merge"
  exception_policy = "silent"
}