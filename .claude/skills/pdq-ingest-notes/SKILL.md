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
