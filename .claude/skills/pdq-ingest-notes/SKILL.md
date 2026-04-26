---
name: pdq:ingest-notes
description: Process inbox files and route to Ideas, Projects, Domains, Entities, or Wiki. Executes changes with user disambiguation on ambiguous routing decisions.
type: skill
trigger_words:
  - ingest
  - process inbox
  - process notes
---

# PDQ Ingest Notes

Process files from `00 Inbox/`, analyze each, and route to appropriate knowledge management categories with intelligent disambiguation.

## Quick Start

Run this skill when you have files in `00 Inbox/` that need processing. The skill will:
1. List all inbox files
2. For each file: invoke File Processor to analyze
3. Ask for disambiguation if routing is ambiguous
4. Execute updates (create/enrich/reclassify)
5. Move source to `.raw/` with backlinks
6. Update index files

## Workflow

[To be filled in Task 2]
