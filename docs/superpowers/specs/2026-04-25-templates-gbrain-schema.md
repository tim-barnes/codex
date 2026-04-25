# Templates: Gbrain Schema Integration

**Date:** 2026-04-25  
**Project:** Caracas (Personal Knowledge Base)  
**Approach:** Layered Hybrid with Gbrain Structure  

---

## Purpose

Update all template files (nine total) to adopt gbrain's comprehensive schema for metadata, structure, and conventions. The goal is completeness: each template type includes all relevant gbrain fields and structural patterns appropriate to its entity type.

---

## Guiding Principles

- **Layered hybrid approach**: Keep existing folder structure and template names. Layer gbrain structure on top where it applies.
- **Two-layer format for core entities**: Core entity types (people, projects, teams, domains, concepts) use compiled truth above a divider with append-only timeline below.
- **Source and confidence tracking**: All claims cite source type and confidence level where relevant.
- **Lightweight tools stay simple**: Journal and reference templates remain lean—they are not persistent entities and don't need full gbrain structure.

---

## Template Specifications

### 1. person.md — Full Gbrain Person Page

**Purpose**: Capture compiled knowledge about a person above the line; append-only relationship history below.

**Frontmatter:**
```yaml
type: person
aliases: [name variants, email, handles]
tags: [domain tags]
role: [current position, if any]
company: [current organization, if any]
relationship_type: [colleague, friend, advisor, mentor, etc.]
confidence: [low/medium/high]
last_enriched: [ISO date]
```

**Compiled Truth Sections:**
- **Role & Context** — Current position, organization, and how you know them
- **What They Believe** — Core beliefs or positions (cite sources: [observed], [self-described], [inferred/confidence])
- **What They're Building** — Active projects, work, or goals
- **What Motivates Them** — Drivers, values, or stated interests
- **Communication Style** — How they prefer to interact; working agreements
- **Network & Crew** — Key connections, team membership, close relationships
- **Assessment** — Strengths, gaps, areas of expertise (date the assessment; update when understanding shifts)
- **Trajectory** — Career path, growth pattern, or evolution over time
- **Contact** — Email, phone, LinkedIn, handles, location
- **Open Threads** — Unresolved questions, things to learn, pending conversations

**Timeline** (below `---`):
```
## Timeline

YYYY-MM-DD | Source — [What changed / What you learned / Key conversation]
```
Append-only entries in reverse chronological order. Examples: new role, significant conversation, updated assessment.

---

### 2. team.md — Full Gbrain Team Page

**Purpose**: Operational knowledge about a team's charter, ownership, and composition.

**Frontmatter:**
```yaml
type: team
tags: [domain tags]
company: [parent organization]
confidence: [low/medium/high]
last_enriched: [ISO date]
```

**Compiled Truth Sections:**
- **Purpose & Charter** — What the team does, why it exists
- **Key Contacts** — Team lead, key members, stakeholders
- **System Ownership** — Systems or domains this team owns or maintains
- **Working Agreements** — Norms, decision-making style, communication patterns
- **Composition** — Current members (link to people notes)
- **Recent Changes** — Structural shifts, staffing changes, charter updates
- **Assessment** — Team health, capability gaps, growth areas (date this)
- **Open Threads** — Staffing questions, process improvements, capability gaps

**Timeline**:
```
## Timeline

YYYY-MM-DD | Source — [Staffing change / Charter update / Key decision]
```

---

### 3. project-index.md — Full Gbrain Project Page

**Purpose**: Project status, goals, and the web of people, domains, and systems it touches.

**Frontmatter:**
```yaml
type: project
status: [active/paused/completed/archived]
started: [ISO date]
owner: [person or team]
tags: [domain tags]
confidence: [low/medium/high]
```

**Compiled Truth Sections:**
- **Goal** — One sentence: what does done look like?
- **State** — Current phase, progress, confidence in timeline
- **Key Outcomes & Metrics** — How success is measured
- **People & Teams** — Who is involved (links to people/team notes)
- **Domains & Systems Touched** — Which domains or systems this affects (links)
- **Open Threads** — Blockers, pending decisions, unresolved dependencies
- **See Also** — Related projects, background context, decision history

**Timeline**:
```
## Timeline

YYYY-MM-DD | Source — [Decision made / Milestone reached / Status shift / Blocker resolved]
```

---

### 4. domain.md — Full Gbrain Domain Page with Timeline

**Purpose**: Evergreen notes on a knowledge domain with timeline of decisions and discoveries.

**Frontmatter:**
```yaml
type: domain
domain_type: [technical/organisational/systems]
tags: [subtopics or related concepts]
confidence: [low/medium/high]
last_enriched: [ISO date]
```

**Compiled Truth Sections:**
- **What This Covers** — Scope definition (what is and isn't in this domain)
- **Current State** — What you currently know; major patterns or conclusions
- **Key Concepts** — Core ideas or terms in this domain
- **Related Systems & Tools** — Links to software entities or other domains
- **Open Threads** — Areas of uncertainty, questions, or knowledge gaps

**Timeline**:
```
## Timeline

YYYY-MM-DD | Source — [Pattern discovery / New insight / Understanding shifted / Key learning]
```

---

### 5. wiki-learning.md — Full Gbrain Concept Page (Learning as Concept Distillation)

**Purpose**: Treat learning materials as the source for concept distillation. Capture what you learned; track how understanding evolved.

**Frontmatter:**
```yaml
type: concept
source_type: [book/course/talk/paper/other]
author: [author name]
published: [ISO date or year]
tags: [topic tags]
confidence: [low/medium/high]
last_enriched: [ISO date]
```

**Compiled Truth Sections:**
- **Summary** — One paragraph: the core idea in your own words
- **Key Concepts** — Main takeaways or frameworks from the source
- **When to Use / When Not to Use** — Applicability, limits, contexts where it helps or doesn't
- **Personal Applications** — How you've applied or might apply this; relevance to your work
- **Connections** — Links to other concepts, domains, projects, or people this relates to
- **Open Threads** — Questions raised by this material; areas you want to explore further

**Timeline**:
```
## Timeline

YYYY-MM-DD | Source — [When you learned this / How understanding evolved / Application or insight]
```

---

### 6. idea.md — Full Gbrain Idea Page

**Purpose**: Capture unstarted possibilities with their potential impact, prerequisites, and how thinking evolves.

**Frontmatter:**
```yaml
type: idea
status: [nascent/developing/ready/started/abandoned]
tags: [domain tags, project areas]
potential_impact: [low/medium/high]
maturity: [rough/conceptual/detailed]
confidence: [low/medium/high]
created: [ISO date]
last_reviewed: [ISO date]
```

**Compiled Truth Sections:**
- **Concept** — What is the core idea? One or two sentences.
- **Problem It Solves** — What gap or opportunity does this address?
- **Potential Impact** — Why does this matter? What could it enable?
- **Key Assumptions** — What needs to be true for this to work?
- **Prerequisites** — What must happen first? What blockers exist?
- **Related Ideas** — Other ideas this connects to, builds on, or conflicts with
- **Rough Approach** — Sketch of how you might tackle this (if thinking has progressed that far)
- **Open Threads** — Unresolved questions, validation needed, research gaps
- **Assessment** — Your current confidence level and reasoning (date this)

**Timeline**:
```
## Timeline

YYYY-MM-DD | Source — [Idea conceived / New insight / Matured thinking / Validation / Status shift]
```
Append-only entries tracking how the idea evolved, what you learned, and confidence shifts.

---

### 7. wiki-reference.md — Lightweight Concept Note (No Timeline)

**Purpose**: Static reference notes for concepts you return to frequently.

**Frontmatter:**
```yaml
type: reference
created: [ISO date]
tags: [topic tags]
confidence: [low/medium/high]
```

**Sections:**
- **Summary** — One paragraph in your own words
- **Key Concepts** — Core ideas and their definitions
- **When to Use / When Not to Use** — Applicability and boundaries
- **Related** — Links to other references, software, or domains
- **Sources** — Where the information came from

*No timeline — reference concepts are static summaries, not changing knowledge.*

---

### 8. software.md — Minimal Enhancement (No Timeline by Default)

**Purpose**: Operational knowledge about tools and libraries in your specific context.

**Frontmatter:**
```yaml
type: software
category: [database/framework/tool/library/other]
tags: [what it does, domains it relates to]
version_tracked: [true/false]
last_updated: [ISO date]
confidence: [low/medium/high]
```

**Sections:**
- **What It Is** — Basic description and purpose
- **Why We Use It** — Your specific rationale for this tool (alternatives you considered)
- **Configuration & Setup** — How it's configured or deployed in your context
- **Known Issues** — Gotchas, limitations, or problems you've hit
- **Related Tools** — Links to alternative or complementary software

*Timeline added only if `version_tracked: true`; then track major version migrations or breaking changes.*

---

### 9. journal-daily.md — Lightweight Scratch Notes (No Timeline)

**Purpose**: Daily or weekly scratch thinking; a staging area before content finds a permanent home.

**Frontmatter:**
```yaml
type: journal
date: [ISO date]
```

**Sections:**
- **Focus** — What you're thinking about or working on
- **Notes** — Observations, ideas, decisions-in-progress
- **To File** — Links to notes that should move to their permanent home

*No timeline — journal entries are transient and not meant to persist as permanent knowledge.*

---

## Source and Confidence Conventions

### Source Types (use in compiled truth sections)

- `[observed]` — Direct personal experience or witness
- `[self-described]` — From the subject's own statements (email, conversation, etc.)
- `[inferred]` — Pattern-based; include confidence: `[inferred/low]`, `[inferred/medium]`, `[inferred/high]`
- `[secondary]` — From another source, document, or reference

### Example Usage

```markdown
## What They Believe

Advocates for API-first architecture [self-described, 2026-04-20].
Has shipped five production systems [observed].
Likely interested in system design [inferred/medium, based on talks given].
```

---

## Transition Notes

### Existing Content

These templates are for *new notes going forward*. Existing notes in the vault are unaffected and don't require migration. Over time, as you update old notes, you can adopt the new template structure incrementally.

### Implementation Notes

- File locations remain unchanged (templates stay in `zy Templates/`).
- New `idea.md` template added to the collection.
- Folder structure (10 Ideas, 20 Projects, 30 Domains, 40 Entities, 50 Wiki, 60 Journal) remains unchanged.
- Templates use `{{placeholder}}` syntax for variable fields (title, date, etc.).
- Backlinks and wiki-style links (`[[note-name]]`) are encouraged in all templates where relevant.

---

## What Success Looks Like

✓ Nine templates cover all entity types: person, team, project, domain, idea, wiki-learning, wiki-reference, software, journal  
✓ Core entities (people, projects, teams, domains, ideas, concepts) have two-layer format with compiled truth and append-only timeline  
✓ Source and confidence tracking conventions are consistent across templates  
✓ Lightweight templates (journal, reference, software) remain simple and practical  
✓ Existing folder structure and note organization continue to work unchanged  
