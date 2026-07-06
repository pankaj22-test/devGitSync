---
name: external-api
description: Help the user integrate third-party APIs (e.g., Stripe, Twilio, SendGrid) by researching, configuring, and scaffolding the request logic.
scope: workspace
mode: auto
knowledge_type: skill
enabled: true
guid: vEp_BzZkf_GHvHGeWoNpB9n5uFQ
---

# Skill: External API Integrator

Help the user integrate third-party APIs (e.g., Stripe, Twilio, SendGrid) by researching, configuring, and scaffolding the request logic.

## Trigger Phrases
- "Integrate [Service Name]"
- "Add [Service] API"
- "Connect to [Service]"
- "How do I call the [Service] endpoint?"

## Workflow

### 1. Research & Discovery
- Ask the user for the documentation link if not provided.
- Identify the Base URL, Authentication Method (Bearer, API Key, Basic), and Required Headers.
- Identify the payload format (JSON, Form Data, etc.).

### 2. Environment Setup
- Identify necessary secrets (e.g., `STRIPE_SECRET_KEY`).
- Check if they are already in `$env`.
- If not, instruct the user to add them in the Xano UI under Settings > Environment Variables.

### 3. Scaffolding the Request
- Create a reusable function in `/function/integrations/{service}/{action}.xs`.
- Use `http.request` for the call.
- Implement standard error handling (checking `response.status`).
- Use `$env` for all sensitive credentials.

### 4. Implementation Details
- **Inputs**: Define clear inputs for the function.
- **Headers**: Set `Content-Type: application/json` and `Authorization`.
- **Response**: Return the parsed body and the status code for easy debugging.

## Success Criteria
- A functional `.xs` file is created that successfully makes the request.
- All secrets are handled via `$env`.
- The user is provided with clear next steps for testing.
