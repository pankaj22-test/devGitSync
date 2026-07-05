---
name: food-manager
description: Instructions for managing food data, including hardcoded lists and potential table migrations.
scope: workspace
mode: auto
knowledge_type: skill
enabled: true
guid: Bnm8oplb1lglImKcCamLoZ03b7s
---

# Skill: Food Manager

This skill helps manage food-related data within the workspace.

## Trigger Phrases
- "Manage food"
- "Update food list"
- "Create food endpoint"
- "Food data"

## Workflow

### 1. Data Source Selection
- Determine if the food data should be hardcoded (for simple lists) or stored in a database table (for dynamic management).
- If a table is needed, ensure it follows the schema: `name (text)`, `type (text)`, `calories (int)`.

### 2. API Implementation
- Use the `food` API group.
- Implement standard CRUD operations if a table is used.
- For hardcoded data, ensure the response is a well-structured JSON array.

### 3. Standards
- Always include `description` and `input {}` blocks in queries.
- Use meaningful variable names like `$food_list`.
- Provide clear comments explaining the food items.

## Success Criteria
- Food endpoints are organized under the `food` API group.
- Data is returned in a consistent format.
- Documentation is updated if hardcoded lists change.
