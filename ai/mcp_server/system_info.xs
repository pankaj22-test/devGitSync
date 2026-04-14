// MCP Server for system information
// Provides tools for checking system information
mcp_server system_info {
  canonical = "system-info-server"
  instructions = "Use this server to access system status and health tools."
  tags = ["system", "monitoring"]
  tools = [{name: "get_status"}]
}