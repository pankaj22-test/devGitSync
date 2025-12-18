task print_current_time {
  stack {
    var $x1 {
      value = now
    }
  
    debug.log {
      value = $x1
    }
  }

  schedule = [{starts_on: 2025-11-04 00:18:41+0000, freq: 10}]
  tags = ["task"]
  middleware = {
    pre : [{name: "preMiddleware"}]
    post: [{name: "postMiddleware"}]
  }
}