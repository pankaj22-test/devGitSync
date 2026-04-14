// AI Agent for customer service tasks
// A helpful customer service assistant
agent customer_service {
  canonical = "customer-service-agent-001"
  llm = {
    type            : "xano-free"
    system_prompt   : "You are a helpful customer service assistant. You can help users with their account questions."
    max_steps       : 3
    prompt          : "{{ $args.message }}"
    temperature     : 1
    search_grounding: false
    thinking_tokens : 0
    include_thoughts: false
    baseURL         : ""
    headers         : ""
    safety_settings : ""
    dynamic_retrival: ""
  }

  tools = []
}