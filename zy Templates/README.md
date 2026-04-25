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
