query action1 verb=POST {
  api_group = "new"

  input {
    object object? {
      schema {
        text text? filters=trim
        text text1? filters=trim
      }
    }
  }

  stack {
    action.call "" {
      package = ""
      input = {object: {text: $input.text, text1: $input.text1}}
    } as $action1
  }

  response = $action1
}