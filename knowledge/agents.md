---
name: AGENTS.md
description: This guide contains standing instructions for all agents working in this workspace.
scope: workspace
mode: auto
knowledge_type: agents.md
enabled: true
guid: -byb-vyM1nBvzsvnkYroUUFBaLg
---

# Workspace Operating Guide (AGENTS.md)

This guide contains standing instructions for all agents working in this workspace.

## Active Skills
- **External API Integrator**: Trigger this skill when asked to integrate, connect, or call a third-party service. See `knowledge/skills/external-api-integrator/SKILL.md` for the workflow.

## General Principles
- Always use `$env` for secrets.
- Prefix integration functions with the service name (e.g., `stripe/create_customer`).
- Include basic error handling for all external requests.
