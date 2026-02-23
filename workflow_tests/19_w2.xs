workflow_test W2 {
  stack {
    api.call "new/1" verb=GET {
      api_group = "api/2"
    } as $endpoint1
  
    debug.stop {
      value = $endpoint1
    }
  }
}