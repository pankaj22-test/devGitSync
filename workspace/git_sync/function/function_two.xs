function functionTwo {
  input {
  }

  stack {
    function.run functionOne as $func1
  }

  response = $xanoLinkUUID1
  middleware = {pre: [{name: ""}], post: [{name: ""}]}
}