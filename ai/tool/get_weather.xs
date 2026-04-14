// AI Tool to get weather information
// Get current weather for a city
tool get_weather {
  instructions = "Use this tool to find current weather conditions for a specific city."

  input {
    // The city name
    text city
  }

  stack {
    // Mocking weather data
    var $weather {
      value = {city: $input.city, temp: 72, conditions: "Sunny"}
    }
  }

  response = $weather
}