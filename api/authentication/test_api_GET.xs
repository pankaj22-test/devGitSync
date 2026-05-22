query "test/api" verb=GET {
  api_group = "Authentication"

  input {
  }

  stack {
    action.call "" {
      package = ""
      input = {object: {text: "new", text1: "nr"}}
      registry = {objectt: ""}
    } as $action1
  }

  response = $action1

  test newunit {
    expect.to_equal ($response.text) {
      value = "new"
    }
  
    expect.to_equal ($response.text1) {
      value = "nr"
    }
  }
}