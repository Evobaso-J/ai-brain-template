# AI Brain — Personal Context OS

A personal second brain for software engineers. Gives AI agents structured, token-efficient
context through progressive disclosure.

## Architecture

Two routing files, three-level loading:

- `SKILL.md` — master manifest. Activation triggers, module tree, workflows, guidelines.
- `AGENT.md` — behavioral rules, file conventions, request → action decision table.

Loading levels:

- **L1** `SKILL.md` — always loaded; routes to the right module
- **L2** `MODULE.md` — domain instructions, loaded on demand
- **L3** `.jsonl` / `.yaml` — structured data, loaded only when needed

## Modules

| Module         | Purpose                                             |
| -------------- | --------------------------------------------------- |
| `identity/`    | Voice, brand, values — who you are professionally   |
| `content/`     | Ideas, drafts, published posts (blog, threads, talks) |
| `knowledge/`   | Bookmarks, learning tracks, research notes          |
| `network/`     | Contacts, relationships, meeting history            |
| `operations/`  | Tasks, goals, decisions, metrics                    |
| `engineering/` | Active projects, tech stack                         |
| `agents/`      | Automation scripts                                  |
| `skills/`      | Per-repo sub-skills (optional)                      |

## Design Principles

- **Append-only** — JSONL files never overwritten; history preserved
- **Just-in-time loading** — only the relevant module per task
- **Voice-first** — `identity/voice.md` read before any external content
- **Cross-module references** — knowledge → content, network → operations

## Quick start

One command — creates your own private versioned copy from this template, clones it, runs setup:

```bash
NAME=ai-brain && gh repo create "$NAME" --template Evobaso-J/ai-brain-template --private --clone && cd "$NAME" && bash setup.sh
```

Requires the [GitHub CLI](https://cli.github.com) (`gh auth login` if first time). Change `NAME` to whatever you want to call your brain.

Prefer the UI? Click **Use this template → Create a new repository** at the top of [this repo](https://github.com/Evobaso-J/ai-brain-template), clone your new repo, then `bash setup.sh`.

## Setup

If you already have a clone and just need to run the setup:

```bash
cd ai-brain
bash setup.sh
```

This will:

1. Install [Claude Code](https://claude.ai/download) if not already present
2. Configure `~/.claude/CLAUDE.md` (global only) so Claude discovers ai-brain from any terminal and reads `SKILL.md` first
3. Grant read/write permissions to the repo in `~/.claude/settings.json`
4. Set up automatic git sync (macOS via launchd, Linux via systemd)

## Sync

The repo auto-syncs on every edit:

| Trigger | What happens |
| --------------- | ----------------------------------------------- |
| File edit (30s debounce) | `git pull --rebase --autostash` → commit → push |

Single daemon (`watch_and_push.sh`) via launchd (macOS) or systemd (Linux). Logs: `agents/scripts/sync.log`.

### Prerequisites

- **macOS**: `brew install fswatch`
- **Linux**: `sudo apt install inotify-tools` (or `sudo dnf install inotify-tools`)

## Usage

Open any Claude session and start with a natural prompt. The routing is automatic via `SKILL.md`.

## Getting Started

After setup, start filling in your data:

1. **Identity first** — fill in `identity/voice.md`, `identity/brand.md`, `identity/values.yaml`, and `identity/bio-variants.md`
2. **Add your stack** — append your tools and languages to `engineering/stack.jsonl`
3. **Start capturing** — bookmarks, contacts, tasks, and ideas go into their respective modules
4. **Use naturally** — just talk to Claude. The routing in `SKILL.md` handles the rest.

## License

MIT
