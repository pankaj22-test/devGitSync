// new descriptio
tool tool1 {
  input {
    text name? filters=trim
  }

  stack {
    function.run tool1 {
      input = {name: $input.name}
    } as $func_1
  }

  response = $func_1
  tags = ["d"]
}