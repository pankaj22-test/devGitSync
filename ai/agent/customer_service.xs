// AI Agent for customer service tasks
// 
agent customer_service {
  canonical = "customer-service-agent-001"
  llm = {
    type         : "anthropic"
    system_prompt: "You are a helpful customer service assistant. You can help users with their account questions."
    max_steps    : 3
    prompt       : "{{ $args.message }}"
    api_key      : ""
    model        : "claude-sonnet-4-6"
    temperature  : 1
    reasoning    : true
    baseURL      : ""
    headers      : ""
  }

  tools = []
}