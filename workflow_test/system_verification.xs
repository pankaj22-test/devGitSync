// End-to-end verification of system components
workflow_test system_verification {
  stack {
    // 1. Test the growth calculation function
    function.call "utils/calculate_growth" {
      input = {previous: 100, current: 150}
    } as $growth_result
  
    expect.to_equal ($growth_result) {
      value = 50
    }
  
    // 2. Test the request logger middleware
    middleware.call request_logger {
      input = {
        vars: ```
          {
            headers: {},
            params: { foo: "bar" },
            method: "GET",
            path: "/test"
          }
          ```
        type: "pre"
      }
    } as $middleware_result
  
    expect.to_be_defined ($middleware_result.request_id)
    expect.to_equal ($middleware_result.logger_status) {
      value = "active"
    }
  
    // 3. Test the daily cleanup task (triggering it manually)
    task.call daily_cleanup as $task_result
  
    // The task itself logs to the table, but the call return is usually the last value or similar
    // We mainly check it doesn't throw
  
    // 4. Test a trigger call (e.g., workspace trigger)
    trigger.call branch_logger {
      input = {
        to_branch  : { id: 1, label: "main" }
        from_branch: { id: 2, label: "dev" }
        action     : "branch_merge"
      }
    } as $trigger_result
  
    // 5. Test the database trigger by attempting a deletion
    // First add a critical log
    db.add logs {
      data = {
        type    : "critical"
        message : "This log should be protected"
        metadata: {}
      }
    } as $critical_log
  
    // Assert that deleting it throws
    expect.to_throw {
      stack {
        db.del logs {
          field_name = "id"
          field_value = $critical_log.id
        }
      }
    
      exception = "CriticalLogDeletionError"
    }
  }

  tags = ["smoke", "system"]
}