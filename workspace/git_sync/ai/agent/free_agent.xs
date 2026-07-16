// Description for Free Agent
agent FreeAgent {
  canonical = "WWirh5vu"
  tags = ["agent", "free"]
  llm = {
    type            : "xano-free"
    system_prompt   : "You are a helpful AI Agent that completes tasks accurately. When you need additional information to complete a task, use the available tools. Always explain your reasoning and provide clear responses."
    max_steps       : 5
    prompt          : "Given a number, calculate it's square and return it"
    temperature     : 0
    search_grounding: false
    thinking_tokens : 0
    include_thoughts: false
    baseURL         : ""
    headers         : ""
    safety_settings : ""
    dynamic_retrival: ""
  }

  tools = [{name: "Tool_1"}, {name: "Tool_2"}]
}