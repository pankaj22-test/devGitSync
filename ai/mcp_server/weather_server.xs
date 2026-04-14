// MCP Server definition
// Provides weather tools
mcp_server weather_server {
  canonical = "weather-service-v1"
  instructions = "Exposes tools to get weather updates"
  tags = ["weather"]
  tools = [{name: "get_weather"}]
}