error_trigger "On Error" {
  input {
    // Which event fired the trigger. "new" fires on first capture and on every snapshot re-capture for non-ignored signatures (rate-limited by the ~5min snapshot dedup window). "regression" fires when a previously-fixed signature re-occurs (the fix didn't hold, or the same bug regressed back). "fixed" fires when a user marks a signature as fixed.
    enum event? {
      values = ["new", "regression", "fixed"]
    }
  
    // The error signature row id. Use to build deep links into the error-logs UI.
    int id?
  
    // Stable hash that identifies this error signature.
    text signature?
  
    // Error code and message captured from the failing run.
    object error? {
      schema {
        // Machine-readable error code.
        text code?
      
        // Human-readable error message.
        text message?
      }
    }
  
    // Where the error originated. Null on 'fixed' events.
    object? caller? {
      schema {
        // Caller kind (api, function, task, middleware, trigger, unknown).
        text type?
      
        // Caller object id.
        int id?
      
        // Caller object name.
        text? name?
      }
    }
  
    // Failing statement. Null on 'fixed' events.
    object? statement? {
      schema {
        // Statement name.
        text name?
      
        // Statement xsid within the function stack.
        text xsid?
      }
    }
  
    // User who marked the error as fixed. Populated only for 'fixed' events.
    object? actor? {
      schema {
        // User id.
        int id?
      
        // User name.
        text? name?
      }
    }
  
    // Occurrence counts for this signature.
    object count? {
      schema {
        // Total occurrences since first seen.
        int total?
      
        // Occurrences in the last hour.
        int last_hour?
      }
    }
  
    // ISO-8601 UTC timestamp of the first occurrence.
    text first_seen?
  
    // ISO-8601 UTC timestamp of the most recent occurrence.
    text last_seen?
  
    // ISO-8601 UTC timestamp the error was marked fixed. Null otherwise.
    text? fixed_at?
  }

  stack {
  }
}