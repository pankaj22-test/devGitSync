query "new/1" verb=GET {
  api_group = "api/2"

  input {
  }

  stack {
    function.run user {
      runtime_mode = "async-shared"
    } as $func1
  
    !await {
      ids = []|push:$func1
      timeout = 10
    } as $x1
  }

  response = $func1
}