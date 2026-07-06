---
name: AGENTS.md
description: Standing instructions for the Food Manager workspace.
scope: workspace
mode: always
knowledge_type: agents.md
enabled: true
guid: -byb-vyM1nBvzsvnkYroUUFBaLg
---

# Workspace Operating Guide (AGENTS.md)

This guide contains agents working in this workspace.

## Workspace Focus
This workspace is dedicated to building and maintaining the **Food Manager** system. It manages food data, user authentication, and utility calculations.

## Active Skills
- **External API Integrator**: Trigger this skill when asked to integrate, connect, or call a third-party service. See `knowledge/skills/external-api/SKILL.md`.
- **Food Manager**: Trigger this skill when managing food data or creating food-related endpoints. See `knowledge/skills/food-manager/SKILL.md`.
- **Database Schema Designer**: Trigger this skill when creating or evolving database tables — designing schemas, adding fields, indexes, relationships, or planning migrations. See `knowledge/skills/database-schema-designer/SKILL.md`.
- **Skill Creator**: Trigger this skill when asked to create a new skill or formalize a workflow. See `knowledge/skills/create-skill/SKILL.md`.

## AI Capabilities
- **Agent1**: Primary AI agent for task orchestration. See `/ai/agent/agent_1.xs`.
- **MCP Server**: Provides external tool capabilities via MCP. See `/ai/mcp_server/mcp.xs`.
- **Tools**: Reusable AI logic. Examples include `tool1` and `tool2` in `/ai/tool/`.

## Reference Docs
- **XanoScript & CLI Reference**: Object syntax and confirmed server quirks. See `knowledge/docs/xanoscript-reference.md`. Consult before authoring `.xs` files.

## General Principles
- **Data Model**: Use the `new1` table for user-related authentication and profiles.
- **Naming**: Food-related logic should live in the `food` API group or be prefixed with `food/` in functions.
- **Security**: 
    - Use `$env` for all secrets and API keys.
    - Apply the `api_key_validator` middleware to protected endpoints that do not use standard auth.
- **Testing**: 
    - **Function Tests**: Every new function must include at least two `test` blocks (one success, one failure/edge case) following the pattern in `function/add_numbers.xs`.
    - **Workflow Tests**: Use workflow tests in `/workflow_test/` for end-to-end API verification. Ensure new authentication logic is covered by tests similar to `auth_signup_success.xs`.
- **Error Handling**: Include basic error handling for all external requests and database operations.
