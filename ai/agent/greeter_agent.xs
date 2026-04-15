// An agent that greets people
agent greeter_agent {
  canonical = "greeter-agent-v1"
  llm = {
    type            : "xano-free"
    system_prompt   : "You are a friendly greeter. Your job is to greet users by name using the available tool."
    max_steps       : 3
    prompt          : "{{ $args.message }}"
    temperature     : 0.7
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