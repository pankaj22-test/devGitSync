agent agent1 {
  canonical = "48sMWLe8"
  llm = {
    type            : "xano-free"
    system_prompt   : "You are a helpful AI Agent that completes tasks accurately. When you need additional information to complete a task, use the available tools. Always explain your reasoning and provide clear responses."
    max_steps       : 5
    prompt          : ""
    temperature     : 0
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