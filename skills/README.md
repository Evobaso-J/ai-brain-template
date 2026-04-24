# skills/

Per-repo sub-skills. Each skill lives in its own subdirectory with a `SKILL.md` file using Anthropic's Agent Skills frontmatter format (`name`, `description`, optional `version`). Claude Code discovers them automatically when the repo is on its search path.

Examples of what belongs here: personal CLI helpers, domain translators, workflow macros, slash-command shortcuts.

Personal skills are not distributed with this template — add your own.

## Layout

```
skills/
  <skill-name>/
    SKILL.md          # frontmatter + prompt body
    ...               # optional scripts, data, sub-files
```

## Minimal SKILL.md

```markdown
---
name: my-skill
description: One-line hook describing when this skill should activate.
---

# my-skill

Prompt body. Invoked when the description matches the user's request or the user types the slash command.
```
