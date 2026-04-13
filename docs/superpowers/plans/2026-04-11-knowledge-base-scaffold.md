# Knowledge Base Scaffold Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produce a ready-to-use Obsidian vault scaffold — all folders, dashboard notes, and note templates — that implements the personal knowledge base design.

**Architecture:** A shell script creates the folder skeleton. Markdown templates for each note type are written into `zy Templates/`. Dashboard `_index.md` notes for the Projects area are pre-populated with structure. The result can be dropped into any new Obsidian vault.

**Tech Stack:** Bash (folder creation + script), Markdown (note content), Obsidian core Templates plugin (template syntax: `{{title}}`, `{{date}}`)

---

## File Map

| File | Purpose |
|------|---------|
| `scaffold.sh` | Creates all folders and copies templates into place |
| `zy Templates/project-index.md` | Template for a project's `_index.md` hub note |
| `zy Templates/person.md` | Template for a person entity note |
| `zy Templates/team.md` | Template for a team entity note |
| `zy Templates/software.md` | Template for a software entity note |
| `zy Templates/domain.md` | Template for a domain or system component note |
| `zy Templates/wiki-reference.md` | Template for an evergreen reference note |
| `zy Templates/wiki-learning.md` | Template for a book/course/talk learning note |
| `zy Templates/journal-daily.md` | Template for a daily journal entry |
| `10 Projects/Work/_index.md` | Work projects dashboard (pre-populated) |
| `10 Projects/Personal/_index.md` | Personal projects dashboard (pre-populated) |

---

## Task 1: Create the folder skeleton

**Files:**
- Create: `scaffold.sh`

- [ ] **Step 1: Write `scaffold.sh`**

```bash
#!/usr/bin/env bash
# Usage: bash scaffold.sh
# Run from the root of a new Obsidian vault.
set -e

dirs=(
  "00 Inbox"
  "10 Projects/Work"
  "10 Projects/Personal"
  "20 Domains/Technical"
  "20 Domains/Organisational"
  "20 Domains/Systems"
  "30 Entities/People"
  "30 Entities/Teams"
  "30 Entities/Software"
  "40 Wiki/Reference"
  "40 Wiki/Learning/books"
  "40 Wiki/Learning/courses"
  "40 Wiki/Learning/talks"
  "50 Journal"
  "zy Templates"
  "zz Archive/Projects"
  "zz Archive/Domains"
  "zz Archive/Entities"
  "zz Archive/Wiki"
  "zz Archive/Journal"
)

for dir in "${dirs[@]}"; do
  mkdir -p "$dir"
  echo "Created: $dir"
done

echo "Folder skeleton created."
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x scaffold.sh
```

- [ ] **Step 3: Run it from vault root to verify**

```bash
bash scaffold.sh
```

Expected output:
```
Created: 00 Inbox
Created: 10 Projects/Work
Created: 10 Projects/Personal
Created: 20 Domains/Technical
Created: 20 Domains/Organisational
Created: 20 Domains/Systems
Created: 30 Entities/People
Created: 30 Entities/Teams
Created: 30 Entities/Software
Created: 40 Wiki/Reference
Created: 40 Wiki/Learning/books
Created: 40 Wiki/Learning/courses
Created: 40 Wiki/Learning/talks
Created: 50 Journal
Created: zy Templates
Created: zz Archive/Projects
Created: zz Archive/Domains
Created: zz Archive/Entities
Created: zz Archive/Wiki
Created: zz Archive/Journal
Folder skeleton created.
```

- [ ] **Step 4: Verify structure**

```bash
find . -not -path './.git/*' -not -path './.obsidian/*' -type d | sort
```

Expected: all 21 directories listed above present.

- [ ] **Step 5: Commit**

```bash
git add scaffold.sh
git commit -m "feat: add vault scaffold script"
```

---

## Task 2: Project dashboard notes

**Files:**
- Create: `10 Projects/Work/_index.md`
- Create: `10 Projects/Personal/_index.md`

- [ ] **Step 1: Write `10 Projects/Work/_index.md`**

```markdown
# Work Projects

## Active

| Project | Status | Domains | Updated |
|---------|--------|---------|---------|
| | | | |

## Paused

| Project | Status | Last active |
|---------|--------|-------------|
| | | |

---

*Move completed projects to `zz Archive/Projects/Work/`.*
```

- [ ] **Step 2: Write `10 Projects/Personal/_index.md`**

```markdown
# Personal Projects

## Active

| Project | Status | Domains | Updated |
|---------|--------|---------|---------|
| | | | |

## Paused

| Project | Status | Last active |
|---------|--------|-------------|
| | | |

---

*Move completed projects to `zz Archive/Projects/Personal/`.*
```

- [ ] **Step 3: Verify files exist and render correctly**

Open both files in Obsidian and confirm the tables display without errors.

- [ ] **Step 4: Commit**

```bash
git add "10 Projects/Work/_index.md" "10 Projects/Personal/_index.md"
git commit -m "feat: add project dashboard notes"
```

---

## Task 3: Project index template

**Files:**
- Create: `zy Templates/project-index.md`

- [ ] **Step 1: Write `zy Templates/project-index.md`**

```markdown
---
status: active
started: {{date:YYYY-MM-DD}}
---

# {{title}}

## Goal

> One sentence: what does done look like?

## Status

**Current:** 

**Next action:** 

## Domains & Systems

- 

## People & Teams

- 

## Wiki

- 

## Notes

```

- [ ] **Step 2: Verify in Obsidian**

Use the core Templates plugin to insert this template into a new note. Confirm `{{title}}` resolves to the note name and `{{date:YYYY-MM-DD}}` resolves to today's date.

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/project-index.md"
git commit -m "feat: add project index template"
```

---

## Task 4: Entity templates (person, team, software)

**Files:**
- Create: `zy Templates/person.md`
- Create: `zy Templates/team.md`
- Create: `zy Templates/software.md`

- [ ] **Step 1: Write `zy Templates/person.md`**

```markdown
---
type: person
---

# {{title}}

**Role:** 
**Organisation:** 
**Teams:** 

## Working relationship

## 1:1 notes

## Career & context

```

- [ ] **Step 2: Write `zy Templates/team.md`**

```markdown
---
type: team
---

# {{title}}

**Organisation:** 
**Members:** 
**Systems owned:** 

## Responsibilities

## How to work with this team

## Working agreements

```

- [ ] **Step 3: Write `zy Templates/software.md`**

```markdown
---
type: software
---

# {{title}}

**Version:** 
**Used in:** 

## What it does (in our context)

## Configuration & setup

## Operational notes

## Known issues

## Links

- [[]] (relevant Wiki reference note)

```

- [ ] **Step 4: Verify templates insert correctly in Obsidian**

Create three scratch notes, insert each template, confirm `{{title}}` resolves in each.

- [ ] **Step 5: Commit**

```bash
git add "zy Templates/person.md" "zy Templates/team.md" "zy Templates/software.md"
git commit -m "feat: add entity templates (person, team, software)"
```

---

## Task 5: Domain and system component template

**Files:**
- Create: `zy Templates/domain.md`

- [ ] **Step 1: Write `zy Templates/domain.md`**

```markdown
---
type: domain
---

# {{title}}

## What this covers

## Current state

## Active projects in this area

*(Backlinks will appear here automatically)*

## Key resources

- [[]] (relevant Wiki reference)
- [[]] (relevant software entity)

```

- [ ] **Step 2: Verify template inserts correctly**

Create a scratch note under `20 Domains/Technical/`, insert the template, confirm it renders.

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/domain.md"
git commit -m "feat: add domain/system template"
```

---

## Task 6: Wiki templates (reference and learning)

**Files:**
- Create: `zy Templates/wiki-reference.md`
- Create: `zy Templates/wiki-learning.md`

- [ ] **Step 1: Write `zy Templates/wiki-reference.md`**

```markdown
---
type: reference
updated: {{date:YYYY-MM-DD}}
---

# {{title}}

## Summary

> One paragraph in your own words.

## Key concepts

## When to use / when not to use

## Related

- [[]] (related reference note)
- [[]] (related software entity)

## Sources

```

- [ ] **Step 2: Write `zy Templates/wiki-learning.md`**

```markdown
---
type: learning
source: 
author: 
completed: 
---

# {{title}}

## What I wanted to learn

## Key takeaways

## Notes

## Distilled into

*(Link to Reference notes once insights are extracted)*

```

- [ ] **Step 3: Verify both templates insert correctly**

Create a scratch note under `40 Wiki/Reference/` and one under `40 Wiki/Learning/books/`, insert each template, confirm they render without errors.

- [ ] **Step 4: Commit**

```bash
git add "zy Templates/wiki-reference.md" "zy Templates/wiki-learning.md"
git commit -m "feat: add wiki reference and learning templates"
```

---

## Task 7: Daily journal template

**Files:**
- Create: `zy Templates/journal-daily.md`

- [ ] **Step 1: Write `zy Templates/journal-daily.md`**

```markdown
---
type: journal
date: {{date:YYYY-MM-DD}}
---

# {{date:YYYY-MM-DD}}

## Focus

## Notes

## To file

*(Links to notes that should be moved to their permanent home)*

```

- [ ] **Step 2: Verify template inserts correctly**

Create a note in `50 Journal/` named today's date, insert the template, confirm `{{date:YYYY-MM-DD}}` resolves correctly in both the frontmatter and heading.

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/journal-daily.md"
git commit -m "feat: add daily journal template"
```

---

## Task 8: Update scaffold script to copy templates

Add template-copy steps to `scaffold.sh` so the complete vault (folders + templates + dashboards) can be set up from a single script run.

**Files:**
- Modify: `scaffold.sh`

- [ ] **Step 1: Update `scaffold.sh` to copy all template and dashboard files**

Replace the contents of `scaffold.sh` with:

```bash
#!/usr/bin/env bash
# Usage: bash scaffold.sh
# Run from the root of a new Obsidian vault.
# Expects to be run from the directory containing this script.
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dirs=(
  "00 Inbox"
  "10 Projects/Work"
  "10 Projects/Personal"
  "20 Domains/Technical"
  "20 Domains/Organisational"
  "20 Domains/Systems"
  "30 Entities/People"
  "30 Entities/Teams"
  "30 Entities/Software"
  "40 Wiki/Reference"
  "40 Wiki/Learning/books"
  "40 Wiki/Learning/courses"
  "40 Wiki/Learning/talks"
  "50 Journal"
  "zy Templates"
  "zz Archive/Projects"
  "zz Archive/Domains"
  "zz Archive/Entities"
  "zz Archive/Wiki"
  "zz Archive/Journal"
)

for dir in "${dirs[@]}"; do
  mkdir -p "$dir"
  echo "Created: $dir"
done

templates=(
  "project-index.md"
  "person.md"
  "team.md"
  "software.md"
  "domain.md"
  "wiki-reference.md"
  "wiki-learning.md"
  "journal-daily.md"
)

for tmpl in "${templates[@]}"; do
  cp "$SCRIPT_DIR/zy Templates/$tmpl" "zy Templates/$tmpl"
  echo "Copied template: $tmpl"
done

cp "$SCRIPT_DIR/10 Projects/Work/_index.md" "10 Projects/Work/_index.md"
cp "$SCRIPT_DIR/10 Projects/Personal/_index.md" "10 Projects/Personal/_index.md"
echo "Copied dashboard notes."

echo ""
echo "Vault scaffold complete."
```

- [ ] **Step 2: Test the script in a temp directory**

```bash
mkdir /tmp/test-vault && cd /tmp/test-vault
bash /path/to/scaffold.sh
find . -type f | sort
```

Expected output includes all template files and dashboard notes in their correct locations.

- [ ] **Step 3: Clean up temp directory**

```bash
rm -rf /tmp/test-vault
```

- [ ] **Step 4: Commit**

```bash
git add scaffold.sh
git commit -m "feat: scaffold script copies templates and dashboards"
```
