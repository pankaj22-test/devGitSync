query test verb=GET {
  api_group = "first"

  input {
  }

  stack {
    db.query xanoLinkSequential {
      return = {type: "list"}
    } as $xanoLinkSequential1
  
    function.run functionOne as $func1
    action.call "" {
      input = {
        prompt          : "Give me weather outlook for Sydney"
        max_tokens      : ""
        assistant_prompt: "As an enthusiastic assistant, provide clear and understandable responses."
      }
    
      registry = {claude_api_key: ""}
    } as $action1
  }

  response = $xanoLinkSequential1

  test defined {
    expect.to_be_defined ($response)
  }
}