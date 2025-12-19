workflow_test workflow_test {
  stack {
    api.call test verb=GET {
      api_group = "first"
    } as $endpoint1
  
    function.call functionOne as $function1
    expect.to_be_defined ($endpoint1)
    expect.to_be_defined ($function1)
  }
}