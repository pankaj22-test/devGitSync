workflow_test W1 {
  stack {
    var $x1 {
      value = "headerstest"
    }
  
    api.call "api/1" verb=GET {
      api_group = "grp"
      headers = []|push:$x1
    } as $endpoint1
  
    debug.stop {
      value = $x1
    }
  }
}