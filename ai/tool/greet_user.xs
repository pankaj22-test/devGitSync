// Greet a user by name
tool greet_user {
  instructions = "Use this tool to provide a friendly greeting to a user when you know their name."

  input {
    // The name of the person to greet
    text name filters=trim
  }

  stack {
    var $greeting {
      value = "Hello, " ~ $input.name ~ "! Nice to meet you."
    }
  }

  response = $greeting
}