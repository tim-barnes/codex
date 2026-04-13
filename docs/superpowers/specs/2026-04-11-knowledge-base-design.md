# Personal Knowledge Base — Folder Structure Design

**Date:** 2026-04-11
**Tool:** Obsidian
**Audience:** Principal software developer

---

## Purpose

A portable folder structure template for a personal knowledge base that supports both browsing (folder navigation) and linking (backlinks, graph view) equally. Designed for a principal engineer whose work spans technical and organisational concerns, multiple systems, and ongoing relationships with people and teams.

---

## Guiding Principles

- **Inbox first.** Everything new lands in `00 Inbox/` before being filed. No exceptions.
- **One home per note.** A note lives in exactly one folder. Many-to-many relationships are expressed through links, not duplication or nesting.
- **Projects link to Domains and Entities; they don't own them.** A project note references the domains, systems, people, and teams it touches. Those nodes live elsewhere and accumulate backlinks over time.
- **Archive preserves, it doesn't delete.** Completed or abandoned material moves to `zz Archive/` so links remain valid.

---

## Folder Structure

```
00 Inbox/

10 Projects/
  Work/
    _index.md
    <project-name>/
      _index.md
      meetings/
      decisions/
      spikes/
  Personal/
    _index.md
    <project-name>/
      _index.md

20 Domains/
  Technical/
  Organisational/
  Systems/
    <system-name>/

30 Entities/
  People/
  Teams/
  Software/

40 Wiki/
  Reference/
  Learning/
    books/
    courses/
    talks/

50 Journal/

zz Archive/
  Projects/
  Domains/
  Entities/
  Wiki/
  Journal/
```

---

## Section Notes

### 00 Inbox

Landing area for all uncategorised new material. New notes are created here by default. A regular triage habit (weekly recommended) moves notes to their permanent home. No subfolders — if Inbox needs organising, it has grown too large.

### 10 Projects

Contains all active project work, split into `Work/` and `Personal/` to keep the two contexts visually separated without enforcing strict cross-referencing rules.

Each project lives in its own named subfolder. The `_index.md` is the project hub: it holds status, goals, and outbound links to relevant Domains, Systems, Entities, and Wiki notes. Subfolders (`meetings/`, `decisions/`, `spikes/`) are optional — add them when note volume warrants it.

`Work/_index.md` and `Personal/_index.md` serve as dashboards listing active projects with status summaries, useful as a weekly review entry point.

### 20 Domains

Evergreen area notes describing the broader contexts that projects operate within. Three sub-areas:

- **Technical/** — engineering disciplines and concerns (backend, data engineering, infrastructure, security, etc.)
- **Organisational/** — non-technical concerns (team health, engineering strategy, stakeholder management, career)
- **Systems/** — named systems with one subfolder per system. Each system contains component-level notes. Work systems and personal project systems coexist as separate named subfolders.

The many-to-many relationship between projects and domains is handled entirely through links. A project's `_index.md` links to the relevant domain or component notes. Obsidian's backlinks pane on any domain note then shows every project that touches it — no manual maintenance required.

### 30 Entities

Named things that exist independently of any single project.

- **People/** — CRM-style notes: relationship context, 1:1 notes, working style, career trajectory. Links to teams and projects.
- **Teams/** — operational notes: responsibilities, key contacts, working agreements, system ownership. Links to members and systems.
- **Software/** — tool and library notes capturing operational knowledge specific to your context (configuration decisions, version notes, known issues). Distinct from Wiki reference notes: `Software/postgresql.md` is "how we run Postgres here"; a Wiki note on databases is "how relational databases work."

### 40 Wiki

Personal knowledge base for research and reference.

- **Reference/** — evergreen concept notes synthesised in your own words. Built up over time and returned to. Links to Software entities and Domains where relevant.
- **Learning/** — in-progress and completed study material from books, courses, and talks. Once distilled, key insights migrate into `Reference/` notes; the source note stays as provenance.

### 50 Journal

Daily or weekly entries for scratch thinking, observations, and decisions-in-progress. Kept flat and date-named (`YYYY-MM-DD.md`) for easy chronological browsing. Not a permanent home for any content — good journal entries eventually spawn notes elsewhere.

### zz Archive

A mirror of the top-level structure (`Projects/`, `Domains/`, `Entities/`, `Wiki/`, `Journal/`). Completed or abandoned material moves here rather than being deleted, preserving link integrity throughout the vault.

---

## Linking Conventions

| From | To | Purpose |
|------|-----|---------|
| `Projects/<name>/_index.md` | `Domains/` notes | Declare which domains/systems the project touches |
| `Projects/<name>/_index.md` | `Entities/People/` + `Entities/Teams/` | Declare who is involved |
| `Entities/People/<name>.md` | `Entities/Teams/` | Team membership |
| `Entities/Teams/<name>.md` | `Domains/Systems/` | System ownership |
| `Wiki/Learning/` notes | `Wiki/Reference/` notes | Distilled insights |
| `Wiki/Reference/` notes | `Entities/Software/` | Concept → tool grounding |

---

## What Goes Where — Quick Reference

| Note type                           | Home                            |
| ----------------------------------- | ------------------------------- |
| Unprocessed new note                | `00 Inbox/`                     |
| Project meeting notes               | `10 Projects/<name>/meetings/`  |
| Project architectural decision      | `10 Projects/<name>/decisions/` |
| Notes on a technical discipline     | `20 Domains/Technical/`         |
| Notes on a named system component   | `20 Domains/Systems/<system>/`  |
| Notes on a person                   | `30 Entities/People/`           |
| Notes on a team                     | `30 Entities/Teams/`            |
| Operational notes on a tool/library | `30 Entities/Software/`         |
| Evergreen concept note              | `40 Wiki/Reference/`            |
| Book / course / talk notes          | `40 Wiki/Learning/`             |
| Daily scratch                       | `50 Journal/`                   |
| Completed project                   | `zz Archive/Projects/`          |
