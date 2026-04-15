// Middleware to log incoming and outgoing requests
// Logs metadata for every request to the 'logs' table
// Add the request ID to the response headers/body via merge
// Logs request metadata to the database for auditing
middleware request_logger {
  input {
    json vars
    enum type {
      values = ["pre", "post"]
    }
  }

  stack {
    // Generate a unique ID to correlate logs
    security.create_uuid as $request_id
  
    // Only log on 'pre' to capture request details before processing
    conditional {
      if ($input.type == "pre") {
        db.add logs {
          data = {
            type    : "request"
            message : "Incoming " ~ ($input.vars.method ?? "UNKNOWN") ~ " request to " ~ ($input.vars.path ?? "UNKNOWN")
            metadata: {
            headers   : $input.vars.headers
            params    : $input.vars.params
            request_id: $request_id
            ip_address: $env.$remote_ip
            user_id   : $input.vars.auth.id ?? null
          }
          }
        }
      }
    }
  }

  response = {
    _debug: ```
      {
        request_id: $request_id,
        logger: "active"
      }
      ```
  }

  response_strategy = "merge"
  exception_policy = "silent"
}