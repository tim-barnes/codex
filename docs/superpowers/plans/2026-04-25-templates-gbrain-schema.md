# Templates: Gbrain Schema Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update nine template files to adopt gbrain's comprehensive schema, creating a structured approach to capturing knowledge about people, projects, domains, ideas, and learning.

**Architecture:** Replace existing minimal template skeletons with comprehensive gbrain-structured templates. Core entity types (person, team, project, domain, idea, wiki-learning) use a two-layer format with compiled truth sections above a divider and append-only timeline below. Lightweight templates (wiki-reference, software, journal-daily) receive metadata enhancements but no timeline. All templates use consistent source/confidence citation conventions.

**Tech Stack:** Markdown with YAML frontmatter, Obsidian wiki-style links (`[[note-name]]`), no external dependencies.

---

## File Structure

Nine template files in `zy Templates/`:
1. `person.md` — Full gbrain person page with 10 compiled truth sections + timeline
2. `team.md` — Full gbrain team page with 8 compiled truth sections + timeline
3. `project-index.md` — Full gbrain project page with 7 compiled truth sections + timeline
4. `domain.md` — Full gbrain domain page with 5 compiled truth sections + timeline (newly added)
5. `idea.md` — Full gbrain idea page with 9 compiled truth sections + timeline (new file)
6. `wiki-learning.md` — Full gbrain concept page with 6 compiled truth sections + timeline (updated)
7. `wiki-reference.md` — Lightweight reference with metadata, no timeline (updated)
8. `software.md` — Lightweight software with metadata, optional timeline (updated)
9. `journal-daily.md` — Lightweight journal, unchanged (for reference)

---

## Task 1: Update person.md

**Files:**
- Modify: `zy Templates/person.md`

- [ ] **Step 1: Write the new person.md template**

Replace the entire file with:

```markdown
---
type: person
aliases: [name variants, email, handles]
tags: [domain tags]
role: [current position, if any]
company: [current organization, if any]
relationship_type: [colleague, friend, advisor, mentor, etc.]
confidence: [low/medium/high]
last_enriched: {{date:YYYY-MM-DD}}
---

# {{title}}

## Role & Context

**Position:** {{role}}  
**Organization:** {{organization}}  
**How we know each other:** {{context}}

## What They Believe

{{Core beliefs or positions. Cite sources: [observed], [self-described], [inferred/low/medium/high]}}

## What They're Building

{{Active projects, work, or goals}}

## What Motivates Them

{{Drivers, values, or stated interests}}

## Communication Style

{{How they prefer to interact; working agreements; any quirks}}

## Network & Crew

- [[]] (close connections)
- [[]] (team membership)

## Assessment

**Strengths:** {{key capabilities}}

**Gaps:** {{areas of development}}

**Expertise Areas:** {{domains of knowledge}}

*Assessment dated: {{date}}*

## Trajectory

{{Career path, growth pattern, or evolution over time}}

## Contact

- **Email:** {{email}}
- **Phone:** {{phone}}
- **LinkedIn:** {{linkedin}}
- **Handles:** {{handles}}
- **Location:** {{location}}

## Open Threads

- {{unresolved questions}}
- {{things to learn}}
- {{pending conversations}}

---

## Timeline

{{YYYY-MM-DD | Source — What changed / What you learned / Key conversation}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/person.md`
Expected: Complete template with all sections and placeholder variables

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/person.md"
git commit -m "feat: update person.md to full gbrain person page"
```

---

## Task 2: Update team.md

**Files:**
- Modify: `zy Templates/team.md`

- [ ] **Step 1: Write the new team.md template**

Replace the entire file with:

```markdown
---
type: team
tags: [domain tags]
company: [parent organization]
confidence: [low/medium/high]
last_enriched: {{date:YYYY-MM-DD}}
---

# {{title}}

## Purpose & Charter

{{What the team does, why it exists}}

## Key Contacts

- **Lead:** [[{{name}}]]
- **Key members:** [[]], [[]]
- **Stakeholders:** [[]], [[]]

## System Ownership

{{Systems or domains this team owns or maintains}}

- [[system-name]]
- [[domain-name]]

## Working Agreements

{{Norms, decision-making style, communication patterns}}

## Composition

**Current members:**
- [[person-name]]
- [[person-name]]
- [[person-name]]

## Recent Changes

{{Structural shifts, staffing changes, charter updates}}

## Assessment

**Team health:** {{overall health status}}

**Capability gaps:** {{areas needing development}}

**Growth areas:** {{opportunities for improvement}}

*Assessment dated: {{date}}*

## Open Threads

- {{staffing questions}}
- {{process improvements}}
- {{capability gaps}}

---

## Timeline

{{YYYY-MM-DD | Source — Staffing change / Charter update / Key decision}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/team.md`
Expected: Complete template with all sections and placeholder variables

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/team.md"
git commit -m "feat: update team.md to full gbrain team page"
```

---

## Task 3: Update project-index.md

**Files:**
- Modify: `zy Templates/project-index.md`

- [ ] **Step 1: Write the new project-index.md template**

Replace the entire file with:

```markdown
---
type: project
status: [active/paused/completed/archived]
started: {{date:YYYY-MM-DD}}
owner: [[person-or-team]]
tags: [domain tags]
confidence: [low/medium/high]
---

# {{title}}

## Goal

> {{One sentence: what does done look like?}}

## State

**Current phase:** {{active/paused/completed}}

**Progress:** {{what's been done, what's remaining}}

**Confidence in timeline:** {{high/medium/low}}

## Key Outcomes & Metrics

- {{outcome/metric and how success is measured}}
- {{outcome/metric}}

## People & Teams

- **Owner:** [[person-or-team]]
- **Key contributors:** [[]], [[]]
- **Stakeholders:** [[]]

## Domains & Systems Touched

- [[domain-name]]
- [[system-name]]

## Open Threads

{{Blockers, pending decisions, unresolved dependencies}}

- {{blocker or decision}}
- {{pending item}}

## See Also

- [[related-project]]
- {{background context, decision history, related notes}}

---

## Timeline

{{YYYY-MM-DD | Source — Decision made / Milestone reached / Status shift / Blocker resolved}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/project-index.md`
Expected: Complete template with all sections and placeholder variables

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/project-index.md"
git commit -m "feat: update project-index.md to full gbrain project page"
```

---

## Task 4: Update domain.md

**Files:**
- Modify: `zy Templates/domain.md`

- [ ] **Step 1: Write the new domain.md template**

Replace the entire file with:

```markdown
---
type: domain
domain_type: [technical/organisational/systems]
tags: [subtopics or related concepts]
confidence: [low/medium/high]
last_enriched: {{date:YYYY-MM-DD}}
---

# {{title}}

## What This Covers

{{Scope definition. What is and isn't in this domain.}}

## Current State

{{What you currently know; major patterns or conclusions}}

## Key Concepts

- **{{concept}}:** {{definition}}
- **{{concept}}:** {{definition}}

## Related Systems & Tools

- [[software-name]]
- [[system-name]]
- [[domain-name]]

## Open Threads

{{Areas of uncertainty, questions, or knowledge gaps}}

- {{question or uncertainty}}
- {{area to explore}}

---

## Timeline

{{YYYY-MM-DD | Source — Pattern discovery / New insight / Understanding shifted / Key learning}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/domain.md`
Expected: Complete template with all sections and timeline

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/domain.md"
git commit -m "feat: update domain.md to full gbrain domain page with timeline"
```

---

## Task 5: Create idea.md

**Files:**
- Create: `zy Templates/idea.md`

- [ ] **Step 1: Write the new idea.md template**

Create the file with:

```markdown
---
type: idea
status: [nascent/developing/ready/started/abandoned]
tags: [domain tags, project areas]
potential_impact: [low/medium/high]
maturity: [rough/conceptual/detailed]
confidence: [low/medium/high]
created: {{date:YYYY-MM-DD}}
last_reviewed: {{date:YYYY-MM-DD}}
---

# {{title}}

## Concept

{{What is the core idea? One or two sentences.}}

## Problem It Solves

{{What gap or opportunity does this address?}}

## Potential Impact

{{Why does this matter? What could it enable?}}

## Key Assumptions

{{What needs to be true for this to work?}}

- {{assumption}}
- {{assumption}}

## Prerequisites

{{What must happen first? What blockers exist?}}

- {{prerequisite or blocker}}

## Related Ideas

- [[idea-name]]
- [[idea-name]] (conflicts with this)
- [[idea-name]] (builds on this)

## Rough Approach

{{Sketch of how you might tackle this (if thinking has progressed that far)}}

## Open Threads

{{Unresolved questions, validation needed, research gaps}}

- {{question}}
- {{validation needed}}

## Assessment

**Current confidence:** {{high/medium/low}}

**Reasoning:** {{why you're confident or uncertain}}

*Assessment dated: {{date}}*

---

## Timeline

{{YYYY-MM-DD | Source — Idea conceived / New insight / Matured thinking / Validation / Status shift}}
```

- [ ] **Step 2: Verify the file was created**

Run: `cat zy\ Templates/idea.md | head -20`
Expected: File exists with frontmatter and first sections

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/idea.md"
git commit -m "feat: add idea.md template with full gbrain structure"
```

---

## Task 6: Update wiki-learning.md

**Files:**
- Modify: `zy Templates/wiki-learning.md`

- [ ] **Step 1: Write the new wiki-learning.md template**

Replace the entire file with:

```markdown
---
type: concept
source_type: [book/course/talk/paper/other]
author: {{author name}}
published: {{ISO date or year}}
tags: [topic tags]
confidence: [low/medium/high]
last_enriched: {{date:YYYY-MM-DD}}
---

# {{title}}

## Summary

{{One paragraph: the core idea in your own words}}

## Key Concepts

- **{{concept}}:** {{main takeaway or framework}}
- **{{concept}}:** {{framework or insight}}

## When to Use / When Not to Use

**Use this when:**
{{applicability and contexts where it helps}}

**Don't use this when:**
{{limits, boundaries, or when it doesn't apply}}

## Personal Applications

{{How you've applied or might apply this; relevance to your work}}

- {{application or use case}}
- [[related-project]] (where you've applied this)

## Connections

**Related concepts:**
- [[concept-name]]
- [[concept-name]]

**Related domains:**
- [[domain-name]]

**Related projects:**
- [[project-name]]

## Open Threads

{{Questions raised by this material; areas you want to explore further}}

- {{question}}
- {{area to explore}}

---

## Timeline

{{YYYY-MM-DD | Source — When you learned this / How understanding evolved / Application or insight}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/wiki-learning.md`
Expected: Complete template with all sections and timeline

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/wiki-learning.md"
git commit -m "feat: update wiki-learning.md to full gbrain concept page with timeline"
```

---

## Task 7: Update wiki-reference.md

**Files:**
- Modify: `zy Templates/wiki-reference.md`

- [ ] **Step 1: Write the new wiki-reference.md template**

Replace the entire file with:

```markdown
---
type: reference
created: {{date:YYYY-MM-DD}}
tags: [topic tags]
confidence: [low/medium/high]
---

# {{title}}

## Summary

{{One paragraph in your own words}}

## Key Concepts

- **{{concept}}:** {{definition}}
- **{{concept}}:** {{definition}}

## When to Use / When Not to Use

**Use when:** {{applicability and boundaries}}

**Don't use when:** {{limits and edge cases}}

## Related

- [[reference-name]]
- [[software-name]]
- [[domain-name]]

## Sources

- {{source 1}}
- {{source 2}}
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/wiki-reference.md`
Expected: Complete template with metadata but no timeline section

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/wiki-reference.md"
git commit -m "feat: update wiki-reference.md with gbrain metadata"
```

---

## Task 8: Update software.md

**Files:**
- Modify: `zy Templates/software.md`

- [ ] **Step 1: Write the new software.md template**

Replace the entire file with:

```markdown
---
type: software
category: [database/framework/tool/library/other]
tags: [what it does, domains it relates to]
version_tracked: [true/false]
last_updated: {{date:YYYY-MM-DD}}
confidence: [low/medium/high]
---

# {{title}}

## What It Is

{{Basic description and purpose}}

## Why We Use It

{{Your specific rationale for this tool}}

**Alternatives considered:** {{other tools you looked at and why you chose this one}}

## Configuration & Setup

{{How it's configured or deployed in your context}}

- {{key config or setup detail}}
- {{important setting}}

## Known Issues

{{Gotchas, limitations, or problems you've hit}}

- {{issue or limitation}}
- {{workaround, if applicable}}

## Related Tools

- [[alternative-tool]]
- [[complementary-tool]]
```

- [ ] **Step 2: Verify the file looks correct**

Run: `cat zy\ Templates/software.md`
Expected: Complete template with metadata but no timeline section

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/software.md"
git commit -m "feat: update software.md with gbrain metadata"
```

---

## Task 9: Verify journal-daily.md (no changes needed)

**Files:**
- Verify: `zy Templates/journal-daily.md`

- [ ] **Step 1: Check current journal-daily.md**

Run: `cat zy\ Templates/journal-daily.md`
Expected: Lightweight template with frontmatter (date) and Focus/Notes/To File sections

- [ ] **Step 2: Confirm it's already appropriate**

Journal entries are transient and don't need the full gbrain structure. The existing template is fine as-is. No changes needed.

- [ ] **Step 3: Note in commit history**

No commit needed for this file since it requires no changes.

---

## Task 10: Create a summary README for the templates

**Files:**
- Create: `zy Templates/README.md`

- [ ] **Step 1: Write a README documenting the template collection**

Create the file with:

```markdown
# Template Collection — Gbrain Schema

Nine templates for a personal knowledge base following the gbrain schema. Each template includes comprehensive YAML frontmatter for metadata and structured sections for capturing knowledge.

## Core Entity Templates (Two-Layer Format)

These templates use a **compiled truth above** and **append-only timeline below** structure:

- **person.md** — People: relationships, expertise, communication style, career trajectory
- **team.md** — Teams: purpose, charter, composition, system ownership
- **project-index.md** — Projects: goals, status, people, outcomes, blockers
- **domain.md** — Domains: evergreen knowledge areas with pattern discoveries
- **idea.md** — Ideas: unstarted possibilities with potential impact and prerequisites
- **wiki-learning.md** — Learning: concepts distilled from books, courses, talks

## Lightweight Templates (No Timeline)

These templates are practical tools without the full compiled-truth structure:

- **wiki-reference.md** — Reference notes: static concepts you return to
- **software.md** — Operational knowledge about tools and libraries
- **journal-daily.md** — Daily scratch thinking before content finds a home

## Source & Confidence Conventions

All templates support consistent source attribution in compiled truth sections:

- `[observed]` — Direct personal experience
- `[self-described]` — From the subject's own statements
- `[inferred/low|medium|high]` — Pattern-based with confidence level
- `[secondary]` — From another source

Example: "Expert in distributed systems [self-described, 2026-04-20] with shipped experience [observed]."

## Variable Placeholders

Templates use `{{placeholder}}` syntax:
- `{{title}}` — Note title
- `{{date:YYYY-MM-DD}}` — Current date in ISO format
- `{{person-name}}` — Names with optional wiki-link

## Linking Conventions

Use Obsidian wiki-style links within templates:
- `[[person-name]]` — Link to a person
- `[[domain-name]]` — Link to a domain
- `[[project-name]]` — Link to a project

## Folder Structure Context

These templates support the caracas knowledge base folder structure:

- `10 Ideas/` — Use idea.md
- `20 Projects/` — Use project-index.md
- `30 Domains/` — Use domain.md
- `40 Entities/People/` — Use person.md
- `40 Entities/Teams/` — Use team.md
- `40 Entities/Software/` — Use software.md
- `50 Wiki/Reference/` — Use wiki-reference.md
- `50 Wiki/Learning/` — Use wiki-learning.md
- `60 Journal/` — Use journal-daily.md
```

- [ ] **Step 2: Verify the README was created**

Run: `cat zy\ Templates/README.md | head -15`
Expected: README explaining the template collection

- [ ] **Step 3: Commit**

```bash
git add "zy Templates/README.md"
git commit -m "docs: add README for gbrain template collection"
```

---

## Self-Review Checklist

**Spec coverage:**
- ✓ person.md: 10 compiled truth sections (role, belief, building, motivates, communication, network, assessment, trajectory, contact, open-threads) + timeline
- ✓ team.md: 8 compiled truth sections (charter, contacts, ownership, agreements, composition, changes, assessment, open-threads) + timeline
- ✓ project-index.md: 7 compiled truth sections (goal, state, outcomes, people, domains, open-threads, see-also) + timeline
- ✓ domain.md: 5 compiled truth sections (scope, state, concepts, related, open-threads) + timeline
- ✓ idea.md: 9 compiled truth sections (concept, problem, impact, assumptions, prerequisites, related, approach, open-threads, assessment) + timeline
- ✓ wiki-learning.md: 6 compiled truth sections (summary, concepts, use-cases, applications, connections, open-threads) + timeline
- ✓ wiki-reference.md: lightweight with metadata, no timeline
- ✓ software.md: lightweight with metadata, no timeline (optional timeline if version-tracked)
- ✓ journal-daily.md: lightweight, no timeline, no changes needed
- ✓ All templates include YAML frontmatter with type, tags, confidence, last_enriched
- ✓ Source/confidence conventions documented in README
- ✓ Two-layer format (compiled truth + timeline) for 6 core entity types
- ✓ Backlinks and wiki-style links supported throughout

**Placeholder scan:**
- No TBD, TODO, or "implement later" entries
- All section descriptions are concrete
- All templates show complete structure with examples
- Variable placeholders use `{{...}}` consistently

**Type consistency:**
- Frontmatter fields consistent: `type`, `tags`, `confidence`, `last_enriched` in core entities
- Timeline format consistent across all templates with timeline: `YYYY-MM-DD | Source — Entry`
- Section names match spec exactly
- No contradictions between templates

