# PDQ — Personal Data Quarters

A personal knowledge base system using the gbrain schema: structured markdown notes, Obsidian-style wiki-links, and Claude Code skills for AI-assisted inbox processing.

## Getting Started

### Prerequisites

- [Obsidian](https://obsidian.md) (recommended) or any markdown editor
- [Claude Code](https://claude.ai/code) for AI skills
- Node.js ≥ 18 (for `npx skills add`)
- Git and bash

### 1. Scaffold a new vault

Clone this repo and run `scaffold.sh` pointing at your vault directory:

```bash
git clone https://github.com/<your-username>/santo-domingo.git pdq-source
bash pdq-source/scaffold.sh ~/my-vault
```

This creates the full folder structure, copies templates, and installs dashboard index files. Re-running is safe — templates always refresh, dashboards skip if they already exist.

**Vault structure created:**

```
my-vault/
├── 00 Inbox/          ← Drop files here for processing
├── 10 Ideas/
├── 20 Projects/
├── 30 Domains/
├── 40 Entities/
├── 50 Wiki/
├── 60 Journal/
├── 90 Raw/            ← Archived source files (managed by skills)
└── zy Templates/      ← Note templates
```

### 2. Install the PDQ skills

From inside your new vault, install the skills so Claude Code can use them:

```bash
cd ~/my-vault
npx skills add <your-username>/santo-domingo
```

This installs the skills into `.claude/skills/` inside your vault, making them available whenever you open the vault in Claude Code.

### 3. Open in Claude Code

Open your vault directory in Claude Code:

```bash
claude ~/my-vault
```

Then trigger a skill by typing its name or trigger words in chat.

---

## Skills

### `pdq:ingest-notes`

**Trigger words:** `ingest`, `process inbox`, `process notes`

Processes all files in `00 Inbox/`, analyzes each one, and routes it to the right category. Asks for disambiguation when routing is ambiguous. For each file, it will:

- Propose a target category (Ideas / Projects / Domains / Entities / Wiki)
- Create a new note, enrich an existing one, or reclassify a misplaced note
- Move the source file to `90 Raw/` for archiving
- Update category `_index.md` dashboards

### `pdq:file-processor`

Internal subagent called by `pdq:ingest-notes`. Not invoked directly.

---

## Note Schema

All notes follow the gbrain schema:

- **YAML frontmatter** — canonical facts (`name`, `type`, `status`, dates, tags)
- **Compiled truth section** — current best-known state, updated in place
- **Timeline section** — append-only log of events/changes with dates and source annotations

Source annotations: `[observed]`, `[self-described]`, `[inferred/low|medium|high]`

See `zy Templates/` for full templates per note type.

---

## Development

To contribute skills or templates, clone this repo and work in `.claude/skills/`. Skills are loaded automatically by Claude Code from that directory.
