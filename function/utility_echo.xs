// Simple echo function that returns the input message
// Echoes back the input message
function "utility/echo" {
  input {
    // The message to echo
    // The message to echo back
    text message
  }

  stack {
    // Assign the input message to a result variable
    var $result {
      value = $input.message
    }
  }

  response = $result
}