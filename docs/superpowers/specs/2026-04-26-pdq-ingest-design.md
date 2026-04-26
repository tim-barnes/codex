# Design: `/pdq:ingest` Skill

**Date:** 2026-04-26  
**Status:** Approved  
**Author:** Tim Barnes

## Purpose

The `/pdq:ingest` skill intelligently processes files from the `00 Inbox/`, analyzing each to determine what updates should be made to managed content (Ideas, Projects, Domains, Entities, Wiki), executing changes with user input on ambiguous decisions.

## Context

PDQ is a personal knowledge management system built on the gbrain schema with the following directory structure:

- `00 Inbox/` — Incoming notes (meeting notes, working notes, external summaries)
- `10 Ideas/` — Unstarted possibilities
- `20 Projects/` — Active work organized by Work/Personal
- `30 Domains/` — Evergreen knowledge areas (Technical, Organisational, Systems)
- `40 Entities/` — People, Teams, Software
- `50 Wiki/` — Learning materials and reference notes
- `60 Journal/` — Daily scratch thinking

Each content type has templates in `zy Templates/` with YAML frontmatter, compiled truth sections, and append-only timelines.

## Design Principles

1. **Source Preservation** — Original inbox files are archived in `.raw/` subdirectories with Obsidian-style backlinks
2. **Interactive Routing** — Ask user when routing is ambiguous; always provide multiple-choice options
3. **Complete Updates** — Every update includes timeline entries and `_index.md` modifications
4. **No Automation Surprises** — Execute changes directly but never modify git; require explicit processing
5. **Incremental Feedback** — Process files one at a time with immediate confirmation

## Architecture

### Components

**1. Main Skill (`/pdq:ingest`)**
- Orchestrates the full batch processing workflow
- Manages file iteration, user prompts, and execution
- Handles disambiguation questions and user selections
- Coordinates file movement and index updates

**2. File Processor Subagent**
- Analyzes a single inbox file
- Proposes updates (create/enrich/reclassify) with target locations
- Identifies disambiguation points (entity resolution, category ambiguity, merge decisions)
- Does NOT execute changes — only proposes

### Data Flow

```
Inbox File
    ↓
File Processor Subagent
    ↓ (returns proposal with options)
Main Skill: [Disambiguation Prompt if needed]
    ↓ (user selection)
Main Skill: Execute Updates
    ├─ Create/modify notes
    ├─ Update timelines
    ├─ Update _index.md
    └─ Move to .raw/
    ↓
Next File
```

## Workflow

### Main Skill: Initialize Phase

1. List all files in `00 Inbox/` (excluding `_index.md`)
2. Display file count and names to user
3. Confirm to proceed or cancel

### Main Skill: Processing Loop

For each inbox file:

1. **Delegate Analysis**
   - Invoke File Processor subagent with file content
   - Receive proposal: update types, target locations, confidence, disambiguation needs

2. **Handle Disambiguation** (if needed)
   - Present user with multiple-choice options
   - Examples:
     - Entity resolution: "Which person is 'Alice'?"
     - Category ambiguity: "Primary domain for this: Technical or Product?"
     - Conflict resolution: "Merge with existing project or keep separate?"
     - File conflict: "Merge into existing file or create variant?"
   - User selects one option

3. **Execute Updates**
   - Create new notes from `zy Templates/`:
     - Fill YAML frontmatter (type, status, tags, dates)
     - Populate sections with content from inbox file
     - Add initial timeline entry: `YYYY-MM-DD | [[source-filename]] — Ingested from inbox`
   - Enrich existing notes:
     - Append content to appropriate sections (Key Assumptions, Assessment, Related Ideas, etc.)
     - Add timeline entry: `YYYY-MM-DD | [[source-filename]] — New insight from...`
     - Add backlink to source in relevant section
   - Reclassify content if needed (move between Ideas/Projects/etc.)
   - Update `_index.md`:
     - For Ideas/Projects: add or update table row
     - For Domains/Entities/Wiki: add link or entry
   - Move inbox file to `.raw/` subdirectory at target location:
     - Create `.raw/` if missing
     - Move file with original name
     - Ensure backlinks from target note point to `.raw/filename`

4. **Confirm & Continue**
   - Show user what was updated
   - Proceed to next file

### Main Skill: Completion Phase

- Show summary of all files processed
- List new notes created, existing notes enriched, reclassifications made
- Reminder that changes are not committed to git

## File Processor Subagent Workflow

1. **Content Analysis**
   - Read and understand inbox file content
   - Extract key concepts, entities, decisions, and insights

2. **Categorization**
   - Determine update type(s):
     - **New note**: Novel idea, project, person, domain concept, or learning material
     - **Enrich existing**: Adds to something already tracked
     - **Reclassify**: Moves content to different category (e.g., Idea → Project)

3. **Propose Routing**
   - For each update: identify target directory and file
   - Target types:
     - New Idea: `10 Ideas/{Personal|Work}/idea-name.md`
     - New Project: `20 Projects/{Personal|Work}/project-index.md`
     - New Domain: `30 Domains/{category}/domain-name.md`
     - New Entity: `40 Entities/{People|Teams|Software}/name.md`
     - New Learning: `50 Wiki/Learning/{topic}/concept.md`
     - New Reference: `50 Wiki/Reference/topic.md`
   - If enriching: specify which existing file

4. **Identify Disambiguation Needs**
   - Entity resolution: ambiguous person, team, or software reference
   - Category ambiguity: content could fit multiple primary categories
   - Merge vs. separate: whether to combine with existing note or keep distinct
   - File conflicts: target filename already exists
   - Template selection: if type is ambiguous, ask which template to use

5. **Return Proposal**
   - Structured output with:
     - Update type and target location
     - Confidence score (if routing is clear)
     - All disambiguation questions with options
     - Suggested content for new notes (frontmatter + body sections)

## Error Handling

**File Conflicts:**
- If target file already exists, ask user:
  - Merge content into existing file?
  - Create variant filename (e.g., `domain-name-2.md`)?
  - Choose different target?

**Ambiguous Content:**
- If File Processor cannot determine meaningful update:
  - Ask user: Delete from inbox? Archive to `.raw/` without note? Manually specify?

**Missing Templates:**
- If required template doesn't exist, halt and notify user

**Malformed Targets:**
- If proposed target doesn't exist (e.g., enriching non-existent Domain):
  - Ask: Create target from template? Choose different target?

**Timeline/Index Failures:**
- If unable to update timeline or `_index.md`, halt and report error before moving file

## Disambiguation: User Interaction

**When to Ask:**
- Entity resolution (which person/team/software?)
- Category ambiguity (which Domain is primary?)
- Merge decisions (combine with existing note or separate?)
- File conflicts (merge or variant?)
- Unclear routing (content doesn't clearly fit any category)

**How to Present:**
- Always offer multiple-choice options
- Include brief context (e.g., "Based on mentions of distributed systems and microservices")
- Allow "other" option for cases where none fit

**Example:**
```
This note mentions "the auth system." Which system is primary?
A) Existing project "Authentication Platform Refresh"
B) New project "Auth Redesign Sprint"
C) Enrich existing Domain "Systems/Security"
D) Other
```

## Source Preservation

**Archival:**
- Original inbox file moved to `.raw/` subdirectory at target location
- Example: `00 Inbox/meeting-2026-04-26.md` → `20 Projects/Work/.raw/meeting-2026-04-26.md`
- `.raw/` directory created if needed

**Backlinks:**
- Every created or enriched note includes Obsidian-style backlink to source
- Format: `[[meeting-2026-04-26]]` (assumes file is in `.raw/` subdirectory of same directory)
- Backlink placed in:
  - New notes: Timeline entry
  - Enriched notes: New timeline entry or relevant section

**Index:**
- `_index.md` updated to reflect new/modified note
- Table format for Ideas/Projects
- Link format for Domains/Entities/Wiki per existing conventions

## Timeline Entries

Every update creates a timeline entry in the target note with format:

```
YYYY-MM-DD | [[source-filename]] — New insight / First ingestion / Enriched from meeting / etc.
```

Example:
```
2026-04-26 | [[meeting-2026-04-26]] — New approach to permission model discovered
```

## Constraints & Non-Goals

**Constraints:**
- Only process files in `00 Inbox/` (not subdirectories)
- Do not commit changes to git
- Do not process files marked as "draft" or with special prefixes (if convention exists)
- Ask for disambiguation when routing is ambiguous; never guess silently

**Non-Goals:**
- Duplicate detection across existing notes (that's a user review task)
- Automatic cleanup of inbox after processing (user must verify)
- Real-time sync with external tools (inbox is manual input)
- Extracting structured data (focus on prose content)

## Success Criteria

**Process:**
- All inbox files analyzed without errors
- User makes deliberate choices on all disambiguation questions
- Sources preserved with backlinks
- No files lost or corrupted

**Output:**
- Each processed file has corresponding update (new note, enriched note, or explicit skip)
- Target note has timeline entry
- `_index.md` files updated
- Inbox file moved to `.raw/` with backlink
- User sees clear summary of what was ingested

## Next Steps

1. Design approval (current)
2. Implementation plan (writing-plans skill)
3. Skill construction (SKILL.md + checklist)
4. Testing with sample inbox files
5. Iteration based on feedback
