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

This guide contains agents working in this workspace.

## Active Skills
- **External API Integrator**: Trigger this skill when asked to integrate, connect, or call a third-party service. See `knowledge/skills/external-api-integrator/SKILL.md` for the workflow.
- **Food Manager**: Trigger this skill when managing food data or creating food-related endpoints. See `knowledge/skills/food-manager/SKILL.md` for the workflow.
- **Database Schema Designer**: Trigger this skill when creating or evolving database tables — designing schemas, adding fields, indexes, relationships, or planning migrations. See `knowledge/skills/database-schema-designer/SKILL.md` for the workflow.

## Reference Docs
- **XanoScript & CLI Reference**: Object syntax, the rules the parser enforces, confirmed server quirks (int-default-0, CS-1580, version skew), and the CLI push/pull loop. See `knowledge/docs/xanoscript-reference.md`. Consult before authoring `.xs` files or debugging a push failure.

## General Principles
- Always use `$env` for secrets.
- Prefix integration functions with the service name (e.g., `stripe/create_customer`).
- Include basic error handling for all external requests.
