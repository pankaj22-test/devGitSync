workflow_test W1 {
  datasource = "live"

  stack {
    var $x1 {
      value = "test"
    }
  
    api.call "" verb=GET {
      api_group = ""
      headers = $x1|push:"test"
    } as $endpoint1
  
    debug.stop {
      value = $endpoint1
    }
  }
}