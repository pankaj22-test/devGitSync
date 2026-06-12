query "API/2" verb=GET {
  api_group = "new"

  input {
  }

  stack {
    function.run "" {
      runtime_mode = "async-shared"
    } as $func1
  
    await {
      ids = $func1
      timeout = 10
    } as $x1
  }

  response = $x1
}