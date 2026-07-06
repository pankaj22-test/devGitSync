---
name: create-skill-copy
description: Author, test, and save new skills to formalize recurring workflows or specialized expertise.
scope: workspace
mode: auto
knowledge_type: skill
enabled: true
guid: Qlzokp_aEEMEFFuWD6IdI84gbsY
---

# Skill: Skill Creator

This skill guides the agent and user through the process of defining and saving a new skill to the workspace.

## Trigger Phrases
- "Create a new skill"
- "Teach you how to [workflow]"
- "Help me build a skill for [X]"
- "Automate this process into a skill"

## Workflow

### 1. Intent Capture
- Ask the user: "What should the agent be able to do once this skill exists, when should it trigger (exact phrases/situations), and what does a good result look like?"

### 2. Draft & Iterate
- Create a new directory under `/knowledge/skills/{name}/`.
- Draft `SKILL.md` using the standard header and sections (Trigger Phrases, Workflow, Success Criteria).
- Ensure the workflow is "lean"—focusing on reasoning and decision-making rather than just a list of steps.

### 3. Integration
- Update `/knowledge/AGENTS.md` to include the new skill in the "Active Skills" list.
- Provide the user with 2-3 test prompts to verify the skill in a fresh thread.

## Standards
- **File Path**: Always `/knowledge/skills/{name}/SKILL.md`.
- **Reference Docs**: Link to relevant docs in `/knowledge/docs/` if they exist.
- **Principle**: Skills should not duplicate instructions found in `AGENTS.md`.

## Success Criteria
- A new `SKILL.md` file exists and is correctly formatted.
- `AGENTS.md` is updated to include the new skill.
- The user has verified the skill works as intended.
