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

### Phase 1: Initialize

1. Check working directory — confirm we're in the PDQ knowledge base (look for `00 Inbox/`, `10 Ideas/`, etc.)
2. List all `.md` files in `00 Inbox/` (exclude `_index.md`)
3. If no files found:
   - Display "No files in inbox — nothing to process"
   - Exit
4. If files found:
   - Display count and filenames
   - Ask user: "Process all [N] files? (yes/no)"
   - If no: exit
   - If yes: proceed to Phase 2

### Phase 2: Process Each File

For each inbox file in order:

1. **Delegate to File Processor**
   - Invoke `/pdq:file-processor` subagent
   - Pass full file content
   - Subagent returns proposal with:
     - Update types (new/enrich/reclassify)
     - Target locations
     - Disambiguation questions (if any)
     - Options for each question

2. **Handle Disambiguation** (if needed)
   - For each disambiguation question:
     - Present options to user
     - User selects one
   - Record selections

3. **Execute Updates**
   - Based on proposal and selections:
     - Create new notes from templates (Task 5)
     - Enrich existing notes (Task 6)
     - Reclassify content (Task 7)
   - Update `_index.md` in target directory (Task 8)
   - Add timeline entries to updated/created notes (Task 9)
   - Move source file to `.raw/` (Task 10)
   - Confirm updates to user

### Phase 3: Complete

- Display summary:
  - Files processed: [N]
  - New notes created: [list]
  - Existing notes enriched: [list]
  - Reclassifications: [list]
- Reminder: "Changes not committed to git — review and commit manually"

## Note Creation (New Notes)

When proposal includes "New Note" update:

1. **Load template** from `zy Templates/[template-name].md`
2. **Fill YAML frontmatter:**
   - type: [from proposal]
   - status: nascent (for ideas) / active (for projects) / [appropriate]
   - tags: [extract from inbox file content]
   - created: [today's date YYYY-MM-DD]
   - last_reviewed: [today's date]
3. **Populate content sections:**
   - Concept: [2-3 sentences from inbox file]
   - Problem It Solves / Description: [relevant content]
   - Potential Impact / Goals: [from inbox analysis]
   - Key Assumptions: [identify any assumptions in content]
   - Related Ideas/Projects/Entities: [link to existing notes if mentioned]
   - Rough Approach / Details: [any implementation suggestions from file]
4. **Add timeline entry:**
   - Format: `YYYY-MM-DD | [[source-filename]] — Ingested from inbox`
5. **Save to target location:**
   - Path: [from proposal target]
   - Filename: [from proposal, ensure .md extension]
6. **Create `.raw/` directory if needed** (see Task 10)

## Note Enrichment (Existing Notes)

When proposal includes "Enrich Existing" update:

1. **Load target note** from [proposal target path]
2. **Identify content sections** from proposal (e.g., Key Assumptions, Assessment, Related Ideas)
3. **Extract relevant content** from inbox file
4. **Append to target sections:**
   - If section exists: add new content after existing content
   - If section doesn't exist: create section with content
   - Preserve section formatting and structure
5. **Add timeline entry:**
   - Position: append to bottom of Timeline section
   - Format: `YYYY-MM-DD | [[source-filename]] — [brief description of update]`
   - Example: `2026-04-26 | [[meeting-2026-04-26]] — New insight on permission model from meeting discussion`
6. **Save modified note**
7. **Add backlink** (see Task 11)

## Content Reclassification (Moving Content)

When proposal includes "Reclassify" update:

1. **Identify source location** from proposal (where content currently is)
2. **Identify destination location** from proposal (where it should move to)
3. **Load source note**
4. **Determine content to move:**
   - For Idea → Project: move entire note, keep source as archived
   - For Someday/Maybe → Active: update status field, keep in same directory
   - For loose concept → formal Domain: create new Domain note with content, reference original
5. **Create/update destination:**
   - If moving entire note: copy to destination path
   - If updating status: modify status field in YAML frontmatter
   - If creating new: use appropriate template
6. **Update Timeline:**
   - Add entry showing reclassification: `YYYY-MM-DD | [[source-filename]] — Reclassified from [old location]`
7. **Update source index** (`_index.md` at source location) — remove entry
8. **Update destination index** (`_index.md` at destination) — add entry
9. **Preserve or archive source:**
   - If entire move: move source to `.raw/` at destination
   - If status change: update source note

## Index Updates

After creating/enriching any note, update the `_index.md` file in the target directory.

**For Ideas and Projects (Table Format):**

1. Load `[category]/_index.md` (e.g., `10 Ideas/Work/_index.md`)
2. Current table format:
   ```
   | Idea | Status | Domain | Updated |
   |------|--------|--------|---------|
   | [[idea-name]] | status | domain-tag | YYYY-MM-DD |
   ```
3. **For new note:** Add row with:
   - Name: `[[filename-without-extension]]` (wiki-link)
   - Status: [from YAML frontmatter]
   - Domain: [from tags or project area]
   - Updated: [today's date]
4. **For enriched note:** Update the "Updated" column to today's date
5. Save `_index.md`

**For Domains, Entities, Wiki (Link Format):**

1. Load `[category]/_index.md` (e.g., `30 Domains/_index.md`)
2. Current format (varies by category):
   - Domains: List under subcategory with links `[[domain-name]]`
   - Entities: List of links `[[person-name]]`, `[[team-name]]`
   - Wiki: Organized by topic with links
3. **For new note:** Add link in appropriate section: `[[filename-without-extension]]`
4. **For enriched note:** No change needed
5. Save `_index.md`

**Format Convention:**
- Use Obsidian wiki-links: `[[filename]]` (without .md extension)
- Maintain alphabetical order within sections
- Keep existing spacing and structure

## Timeline Entry Creation

Every updated or created note gets a timeline entry.

**Timeline Format:**

Notes have append-only Timeline section at bottom:

```markdown
## Timeline

2026-04-20 | self-described — Idea conception
2026-04-25 | [[meeting-2026-04-25]] — Matured thinking
```

**Adding Timeline Entry:**

1. Locate Timeline section in target note (usually at bottom)
2. If Timeline section doesn't exist: create it
3. Append new entry with format:
   - Date: `YYYY-MM-DD` (today)
   - Source: `[[source-filename]]` (inbox file without .md extension)
   - Description: [brief description of update type]
4. Examples:
   - New note: `2026-04-26 | [[meeting-2026-04-26]] — Ingested from inbox`
   - Enriched: `2026-04-26 | [[working-notes-2026-04-26]] — New insight on permission model`
   - Reclassified: `2026-04-26 | [[proposal-2026-04-26]] — Reclassified from Ideas to Projects`

**Formatting Rules:**
- Keep entries in chronological order (newest at bottom)
- Maintain consistent spacing (one blank line before Timeline section)
- Use exact date format YYYY-MM-DD
- Use wiki-links for source filenames
- Keep description concise (one line)

## Source File Archival

After all updates are complete, move the original inbox file to `.raw/` at the target location.

**Process:**

1. **Create `.raw/` directory** if it doesn't exist:
   - At target note location: `[category]/[subcategory]/.raw/`
   - Example: `10 Ideas/Work/.raw/` or `20 Projects/Personal/.raw/`
   - Run: `mkdir -p "[target-directory]/.raw/"`

2. **Move inbox file:**
   - Source: `00 Inbox/[filename].md`
   - Destination: `[target-directory]/.raw/[filename].md`
   - Preserve filename exactly
   - Run: `mv 00\ Inbox/[filename].md [target-directory]/.raw/[filename].md`

3. **Verify move:**
   - Source file removed from inbox
   - File exists in `.raw/` directory
   - File integrity preserved (use `wc -l` to verify line count matches)

4. **Add backlink** (see Task 11)

**Example:**

```bash
# Process meeting-2026-04-26.md about new project
mkdir -p "20 Projects/Work/.raw/"
mv "00 Inbox/meeting-2026-04-26.md" "20 Projects/Work/.raw/meeting-2026-04-26.md"

# Verify
ls -la "20 Projects/Work/.raw/meeting-2026-04-26.md"
```

## Checklist

- [ ] Initialize phase complete
- [ ] All files processed
- [ ] All updates executed
- [ ] Summary displayed

## User Interaction Prompts

### Initialization Prompt

```
I found [N] files in the inbox:
- [filename1]
- [filename2]
- ...

Process all files? (yes/no)
```

### Per-File Confirmation

```
Processing: [filename]

Updates proposed:
- [description of each update]

[If disambiguation needed]
Question: [disambiguation question]
A) [option1]
B) [option2]
C) [option3]

Select (A/B/C): [user selects]
```

### Completion Prompt

```
Inbox processing complete.

Summary:
- Files processed: [N]
- New notes created:
  - [name]: [location]
  - ...
- Existing notes enriched:
  - [name]: [updates]
  - ...
- Reclassifications:
  - [old location] → [new location]

Changes are not committed to git. Review and commit manually.
```
