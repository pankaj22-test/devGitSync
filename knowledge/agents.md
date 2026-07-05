---
name: AGENTS.md
description: fr
scope: workspace
mode: always
knowledge_type: agents.md
enabled: true
guid: -byb-vyM1nBvzsvnkYroUUFBaLg
---

# Xano Test/Reproduction Workspace

This workspace is a testing and reproduction environment for XanoScript features, functions, and middleware. It contains generic resource names and utility functions with comprehensive workflow tests.

## Data model

| Table | Purpose | Key fields / relationships |
| :--- | :--- | :--- |
| `new1` | Auth table (User-like) | `id`, `name`, `Integer`, `image` |

*Note: `new1` is designated as the authentication table (`auth = true`).*

## APIs

| API group | Auth | Notable endpoints / purpose |
| :--- | :--- | :--- |
| `new` | `new1` token | `api/1` (Auth-protected), `api/2` (Public) |

## Logic

- **Functions:**
    - `add_numbers`: Calculates sum and metadata; includes extensive unit tests.
    - `repro_datasource`: Tests switching between datasources via `db.set_datasource`.
    - `test_1`: Simple function demonstrating middleware usage.
- **Middleware:**
    - `api_key_validator`: Validates an `api_key` against a hardcoded secret (`secret-123`).
    - `Middleware`: Generic middleware used by `test_1`.
- **Workflow Tests:**
    - Includes several `auth_*` tests (signup, login, profile) for validating authentication logic.

## Conventions

- **Naming:** Generic/placeholder naming is common (`new1`, `new`, `test1`).
- **Auth:** Supports both table-based auth (`new1`) and key-based middleware (`api_key_validator`).
- **Testing:** High coverage of `workflow_test` and inline unit tests for functions/middleware.

## Working in this workspace

- Always include unit tests for new functions, following the pattern in `add_numbers`.
- When creating authenticated endpoints, use the `new1` table as the user record.
- Use `api_key_validator` for stacks requiring simple API key protection.
