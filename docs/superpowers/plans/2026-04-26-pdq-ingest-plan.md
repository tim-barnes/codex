# PDQ Ingest Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement `/pdq:ingest-notes` and `/pdq:file-processor` skills to intelligently process inbox files and route them to appropriate knowledge management categories.

**Architecture:** Two-skill system with main skill handling orchestration and user interaction, subagent handling content analysis and routing decisions. Main skill invokes subagent per file, handles disambiguation, executes updates, and manages cleanup.

**Tech Stack:** Claude skill system (SKILL.md format), Obsidian wiki-links, Markdown templates, user questioning system.

---

## Task 1: Create Main Skill Skeleton

**Files:**
- Create: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Create skill directory**

```bash
mkdir -p ~/.claude/plugins/user/pdq-ingest-notes
```

- [ ] **Step 2: Write SKILL.md header and metadata**

Create `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`:

```markdown
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
```

- [ ] **Step 3: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: create pdq:ingest-notes skill skeleton"
```

---

## Task 2: Implement Main Skill Workflow

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add initialization phase**

In the Workflow section, add:

```markdown
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
```

- [ ] **Step 2: Add checklist section**

After Workflow, add:

```markdown
## Checklist

- [ ] Initialize phase complete
- [ ] All files processed
- [ ] All updates executed
- [ ] Summary displayed
```

- [ ] **Step 3: Add user interaction prompts section**

After Workflow, add:

```markdown
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
```

- [ ] **Step 4: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: implement main skill workflow and user prompts"
```

---

## Task 3: Create File Processor Subagent Skeleton

**Files:**
- Create: `~/.claude/plugins/user/pdq-file-processor/SKILL.md`

- [ ] **Step 1: Create subagent directory**

```bash
mkdir -p ~/.claude/plugins/user/pdq-file-processor
```

- [ ] **Step 2: Write SKILL.md header**

Create `~/.claude/plugins/user/pdq-file-processor/SKILL.md`:

```markdown
---
name: pdq:file-processor
description: Analyze a single inbox file and propose updates to PDQ knowledge base. Returns structured proposal without executing changes.
type: subagent
---

# PDQ File Processor

Analyze a single inbox file and propose what updates should be made to the knowledge base.

## Input

- Single markdown file content from `00 Inbox/`
- File name (for reference in backlinks)

## Output

Structured proposal with:
- Analysis of content
- Update type(s): new note / enrich existing / reclassify
- Target location(s)
- Confidence assessment
- Disambiguation questions with options

## Workflow

[To be filled in Task 4]
```

- [ ] **Step 3: Commit**

```bash
cd ~/.claude/plugins/user/pdq-file-processor
git add SKILL.md
git commit -m "feat: create pdq:file-processor subagent skeleton"
```

---

## Task 4: Implement File Processor Workflow

**Files:**
- Modify: `~/.claude/plugins/user/pdq-file-processor/SKILL.md`

- [ ] **Step 1: Add analysis phase**

In Workflow section:

```markdown
## Workflow

### Phase 1: Content Analysis

1. Read and understand the inbox file
2. Identify:
   - Main topic/theme
   - Key entities (people, teams, projects, software, concepts)
   - Type of content (meeting note, working note, external summary)
   - Actionable insights or decisions
3. Extract key concepts for categorization

### Phase 2: Update Type Determination

Determine what update(s) are needed:

**New Note:** Create if content describes something novel
- New idea (unstarted possibility)
- New project (active work)
- New person/team/software (entity)
- New domain concept (evergreen knowledge)
- New learning (concept from external source)

Confidence indicators:
- Novel concept not mentioned in existing notes
- Actionable and specific enough to warrant own page
- Adds significant value as separate entry

**Enrich Existing:** Add to existing note if content provides new insight
- New information about existing idea/project/domain/entity
- Timeline-worthy update (status change, new insight, validation)
- Related but not primary focus

Confidence indicators:
- Clearly relates to specific existing note
- Adds non-trivial information
- Timeline entry would be meaningful

**Reclassify:** Move existing content to different category
- Idea → Project (now being acted on)
- Someday/Maybe → Active (priority increased)
- Loose concept → Formal Domain (sufficient maturity)

Confidence indicators:
- Status change is explicit
- Supporting evidence in file
- Clear destination category

### Phase 3: Propose Routing

For each identified update:

1. **If New Note:**
   - Determine category (Ideas/Projects/Domains/Entities/Wiki)
   - Determine subcategory (Work/Personal, Technical/Organisational, People/Teams/Software, Learning/Reference)
   - Suggest filename (lowercase, hyphens, descriptive)
   - Identify template type (idea.md / project-index.md / domain.md / person.md / team.md / software.md / wiki-learning.md / wiki-reference.md)

2. **If Enrich Existing:**
   - Identify target file path
   - Identify which sections would receive new content
   - Estimate how much content to add

3. **If Reclassify:**
   - Identify source location
   - Identify destination location
   - Note what sections should move

### Phase 4: Identify Disambiguation Needs

Flag decisions that require user judgment:

**Entity Resolution:**
- Content mentions person/team/software by name or description
- Multiple existing entities could match
- Question: "This mentions [entity description] — which [type] is this?"
- Options: [existing option 1], [existing option 2], [create new]

**Category Ambiguity:**
- Content could fit multiple primary categories
- Question: "This could be filed in [category A] or [category B] — which is primary?"
- Options: [category A], [category B], [other domain], [uncertain - ask later]

**Merge vs. Separate:**
- Content relates to existing note but could be separate
- Question: "This overlaps with existing [name] — merge or keep separate?"
- Options: Merge into existing, Create separate, Uncertain

**File Conflict:**
- Proposed filename already exists
- Question: "Target file [name] already exists — merge or variant?"
- Options: Merge content, Create variant (name-2.md), Choose different target

**Type Ambiguity:**
- Content unclear if it's new note, enrichment, or reclassification
- Question: "Is this [type A], [type B], or [type C]?"
- Options: [type A], [type B], [type C], Uncertain

### Phase 5: Return Proposal

Output structured proposal:

```
## Analysis

[2-3 sentences about content and main insights]

## Proposed Updates

### Update 1: [Type]
- Target: [path/filename.md]
- Category: [Ideas/Projects/Domains/Entities/Wiki]
- Template: [template-name.md]
- Confidence: [high/medium/low]
- Rationale: [brief explanation]

### Update 2: [Type]
- Target: [path/filename.md]
- Content sections: [list relevant sections]
- Confidence: [high/medium/low]

## Disambiguation Questions

### Question 1: Entity Resolution
[Question text]
A) [Option 1 - existing entity]
B) [Option 2 - existing entity]
C) Create new [entity type]

### Question 2: Category Ambiguity
[Question text]
A) [Category A]
B) [Category B]
C) Uncertain - ask user later

## Suggested Content

[For new notes: skeleton with frontmatter and proposed content]

---

**Instructions to Main Skill:**
- Execute updates as proposed
- For each disambiguation question, ask user and record selection
- Use selected options to finalize update targets and content
```
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-file-processor
git add SKILL.md
git commit -m "feat: implement file processor workflow and analysis logic"
```

---

## Task 5: Add Note Creation Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add note creation function**

After the Workflow section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add note creation logic for new notes"
```

---

## Task 6: Add Note Enrichment Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add enrichment function**

After note creation section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add note enrichment logic for existing notes"
```

---

## Task 7: Add Content Reclassification Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add reclassification function**

After enrichment section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add content reclassification logic"
```

---

## Task 8: Add Index Update Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add index update function**

After reclassification section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add index update logic for all categories"
```

---

## Task 9: Add Timeline Entry Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add timeline function**

After index updates section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add timeline entry creation logic"
```

---

## Task 10: Add Source File Movement Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add file movement function**

After timeline section, add:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add source file archival logic to .raw/ directories"
```

---

## Task 11: Add Backlink Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add backlink function**

After file movement section, add:

```markdown
## Backlink Creation

Every created or enriched note includes an Obsidian-style backlink to the source file in `.raw/`.

**Backlink Format:**

- Format: `[[filename-without-extension]]` (Obsidian wiki-link)
- Pointing to file in relative path `.raw/filename`

**Placement:**

**For New Notes:**
- Add to Timeline entry format (already includes backlink)
- Timeline: `2026-04-26 | [[source-filename]] — Ingested from inbox`

**For Enriched Notes:**
- Add to new Timeline entry (already includes backlink)
- Timeline: `2026-04-26 | [[source-filename]] — New insight from meeting`

**For Section Content:**
- If enriching a specific section (e.g., Key Assumptions), you may add inline backlink
- Example in Assessment section: "Based on discussion in [[meeting-2026-04-26]]"

**Verification:**
- Backlinks in Timeline entries point to correct `.raw/` location
- Source files in `.raw/` are accessible from target note directory
- Obsidian can resolve links (test by clicking in Obsidian)

**Note on Relative Paths:**
- Timeline and inline backlinks work because `.raw/` is a sibling directory
- From `10 Ideas/Work/idea-name.md`:
  - Link to `.raw/meeting-note.md` as: `[[meeting-note]]` (Obsidian resolves automatically)
  - Or explicit: `.raw/meeting-note`
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add backlink creation logic for source preservation"
```

---

## Task 12: Add Disambiguation Handling to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add disambiguation function**

After backlink section, add:

```markdown
## Disambiguation & User Decision Handling

When File Processor identifies ambiguity, main skill asks user and records selection.

**Process:**

1. **Receive proposal** from File Processor with `Disambiguation Questions` section
2. **For each question:**
   - Present question text to user
   - Show all options (A, B, C, etc.)
   - Wait for user selection
   - Record selection in decision map: `{question_id: selected_option}`
3. **Apply selections** to update proposal:
   - Modify target paths based on selections
   - Adjust content based on entity resolutions
   - Finalize merge vs. separate decisions
4. **Proceed with execution** using finalized proposal

**Example Disambiguation Question:**

```
This note mentions "distributed systems." Which is primary?

A) Existing Domain "Systems/Architecture"
B) Existing Domain "Technical/Performance"
C) Create new Domain "Systems/Distributed"

Select (A/B/C): [user selects B]
```

**Decision Recording:**
- Store in memory/context: "Question 1: User selected B → target is Domains/Technical/Performance"
- Apply to proposal before execution
- Use finalized proposal for all update operations

**Conflict Resolution Questions:**

**Example File Conflict:**
```
Target file already exists: "20 Projects/Work/auth-system.md"

A) Merge content into existing file
B) Create variant filename "auth-system-2.md"
C) Choose different target
D) Cancel this update

Select (A/B/C/D): [user selects A]
```

**Handling Merge Decision:**
- If user selects "Merge": enrich existing file (use Enrichment logic from Task 6)
- If user selects "Variant": create new file with variant name (use Creation logic with new filename)
- If user selects "Different": ask where to file content (another disambiguation)
- If user selects "Cancel": skip this update, continue to next file

**Ambiguous Content Questions:**

**Example Ambiguous Content:**
```
This appears to be scratch notes without clear subject. How should we proceed?

A) Delete from inbox (content not actionable)
B) Archive to .raw/ without creating a note
C) I'll manually specify what to do (cancel for now)

Select (A/B/C): [user selects A]
```

**Handling Ambiguous Content:**
- Delete: remove from inbox, no note created
- Archive: move to `.raw/` at inbox level, no note created
- Cancel: skip update, continue to next file
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add disambiguation and decision handling logic"
```

---

## Task 13: Add Error Handling to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add error handling section**

After disambiguation section, add:

```markdown
## Error Handling

Handle common errors gracefully without corrupting files.

**File Not Found:**
- If target note for enrichment doesn't exist at proposed path
- Action: Ask user "Target file not found. Create from template? Or choose different target?"
- Options: Create new, Choose different target, Cancel
- Continue or skip based on selection

**Missing Template:**
- If skill needs to create new note but template file doesn't exist
- Action: Halt and report "Template zy Templates/[template-name].md not found"
- User must add template before retrying

**Directory Creation Failed:**
- If `.raw/` directory cannot be created
- Action: Report error with filesystem error details
- Skip file movement, preserve inbox file
- Ask user: "Continue to next file or stop?"

**Index Update Failed:**
- If `_index.md` cannot be read or written
- Action: Halt with error "Failed to update [path]/_index.md"
- Preserve all other changes (note files remain created/modified)
- Ask user: "Manually update index and retry, or continue?"

**No Write Permission:**
- If target directory is read-only or no write permission
- Action: Report error with path and permission issue
- Skip this update
- Continue to next file

**File Conflict - Merge Failed:**
- If user selects merge but content merging causes issues (duplicate sections, etc.)
- Action: Report "Cannot auto-merge [file]. Manual merge required."
- Keep both versions separate (inbox file and target file untouched)
- Ask user to manually review and merge

**Graceful Degradation:**
- Always preserve original inbox files until successfully moved
- Never delete or modify inbox file unless fully confirmed moved to `.raw/`
- If any update step fails after file move, report error clearly so user can manually fix
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add comprehensive error handling"
```

---

## Task 14: Add Completion & Summary Logic to Main Skill

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`

- [ ] **Step 1: Add completion section**

After error handling, add:

```markdown
## Completion & Summary

After all files processed, provide clear summary to user.

**Summary Report Format:**

```
## Ingest Complete

**Files processed:** [N]

**New Notes Created:**
- [[idea-name]]: 10 Ideas/Work/idea-name.md
- [[project-name]]: 20 Projects/Personal/project-name.md
- [[domain-name]]: 30 Domains/Technical/domain-name.md
[etc.]

**Existing Notes Enriched:**
- [[project-name]]: Updated with new milestones from [source]
- [[domain-name]]: Timeline entry added about [topic]
[etc.]

**Reclassifications:**
- [[idea-name]]: Ideas/Work → Projects/Work (now active)
[etc.]

**Skipped/Errored:**
- [filename]: Reason (file not processed)
[if any]

---

Inbox files have been moved to `.raw/` directories at their target locations.

**Next steps:**
- Review changes in Obsidian
- Verify backlinks and cross-references
- Commit changes to git: `git add -A && git commit -m "ingest: [summary of changes]"`
```

**Tracking for Summary:**
- Keep running list of:
  - Files processed successfully
  - New notes created (with paths)
  - Existing notes enriched (with paths)
  - Reclassifications made (from → to)
  - Files skipped/errored (with reasons)
- Display after all files complete

**Final Confirmation:**
- Ask user: "Proceed with commit? (yes/no/later)"
- If yes: user commits manually (skill doesn't commit per spec)
- If no/later: user will commit manually
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "feat: add completion summary and reporting logic"
```

---

## Task 15: Add Testing & Validation Scenarios

**Files:**
- Create: `~/.claude/plugins/user/pdq-ingest-notes/TEST.md`

- [ ] **Step 1: Create test scenarios document**

```bash
mkdir -p ~/.claude/plugins/user/pdq-ingest-notes/tests
```

Create `~/.claude/plugins/user/pdq-ingest-notes/TEST.md`:

```markdown
# PDQ Ingest - Testing & Validation

## Test Scenarios

### Scenario 1: Single New Idea

**Setup:**
- Create inbox file `00 Inbox/new-idea-2026-04-26.md` with content:
  ```markdown
  # AI-Assisted Knowledge Base

  Idea from conversation: use Claude to automatically organize and enrich knowledge base entries.
  Could significantly speed up the ingest process.
  ```

**Run:**
- `/pdq:ingest-notes`
- Select: Process all files
- Expected: Skill creates new idea note in `10 Ideas/Work/ai-assisted-knowledge-base.md`

**Verify:**
- [ ] New file created: `10 Ideas/Work/ai-assisted-knowledge-base.md`
- [ ] Contains YAML frontmatter with type: idea, status: nascent, created: 2026-04-26
- [ ] Contains Concept section with idea content
- [ ] Contains Timeline entry: `2026-04-26 | [[new-idea-2026-04-26]] — Ingested from inbox`
- [ ] Original file moved: `10 Ideas/Work/.raw/new-idea-2026-04-26.md`
- [ ] Index updated: `10 Ideas/Work/_index.md` has new row for ai-assisted-knowledge-base

### Scenario 2: Enrich Existing Note

**Setup:**
- Existing note: `30 Domains/Technical/knowledge-management.md`
- Create inbox file `00 Inbox/km-meeting-2026-04-26.md`:
  ```markdown
  # Knowledge Management Meeting

  Discussed new timeline visualization approach for domains.
  Could help see evolution of concepts over time.
  ```

**Run:**
- `/pdq:ingest-notes`
- Select: Process all files
- File Processor asks: "This relates to Domain 'Knowledge Management' — enrich existing or new note?"
- Select: Enrich existing

**Verify:**
- [ ] Existing file modified: `30 Domains/Technical/knowledge-management.md`
- [ ] New content added to appropriate section (e.g., Key Insights)
- [ ] Timeline entry added: `2026-04-26 | [[km-meeting-2026-04-26]] — New insight on timeline visualization`
- [ ] Original file moved: `30 Domains/Technical/.raw/km-meeting-2026-04-26.md`
- [ ] Index unchanged (existing domain, no new entries)

### Scenario 3: Entity Disambiguation

**Setup:**
- Create inbox file `00 Inbox/alice-update-2026-04-26.md`:
  ```markdown
  # Alice Status Update

  Alice shared progress on architecture redesign. Two months in, on track.
  ```

**Existing entities:**
- `40 Entities/People/alice-chen.md` (Team Lead)
- `40 Entities/People/alice-smith.md` (External consultant)

**Run:**
- `/pdq:ingest-notes`
- File Processor asks: "This mentions 'Alice' — which person?"
- Options: Alice Chen (Team Lead), Alice Smith (Consultant), Create new
- Select: Alice Chen

**Verify:**
- [ ] Correct person note enriched: `40 Entities/People/alice-chen.md`
- [ ] Timeline entry references source: `2026-04-26 | [[alice-update-2026-04-26]] — Status update on architecture redesign`
- [ ] Original file archived correctly

### Scenario 4: File Conflict Handling

**Setup:**
- Existing note: `20 Projects/Work/distributed-systems.md`
- Create inbox file `00 Inbox/distributed-systems-notes-2026-04-26.md`:
  ```markdown
  # Distributed Systems Discussion

  New findings on consensus algorithms, implications for our architecture.
  ```

**Run:**
- `/pdq:ingest-notes`
- File Processor proposes enriching `20 Projects/Work/distributed-systems.md`
- Asks: "Merge content into existing file?"
- Select: Yes

**Verify:**
- [ ] Existing note modified: content added
- [ ] Timeline entry added
- [ ] No duplicate files created
- [ ] Source file archived: `20 Projects/Work/.raw/distributed-systems-notes-2026-04-26.md`

### Scenario 5: Multiple Files at Once

**Setup:**
- Create 3 inbox files:
  - `00 Inbox/meeting-1.md` — new project
  - `00 Inbox/meeting-2.md` — enrich existing idea
  - `00 Inbox/notes-research.md` — new learning material

**Run:**
- `/pdq:ingest-notes`
- Select: Process all files
- Handle any disambiguations as they come
- Let skill process all 3 sequentially

**Verify:**
- [ ] All 3 files processed
- [ ] Appropriate notes created/enriched
- [ ] All 3 source files archived
- [ ] Completion summary shows all 3 processed

### Scenario 6: Ambiguous Content Handling

**Setup:**
- Create inbox file `00 Inbox/random-notes-2026-04-26.md`:
  ```markdown
  random thoughts today
  meeting was long
  coffee was cold
  ```

**Run:**
- `/pdq:ingest-notes`
- File Processor determines content is not actionable
- Asks: "This appears to be scratch notes. Delete or archive?"
- Select: Delete

**Verify:**
- [ ] File removed from inbox
- [ ] No new note created
- [ ] No `.raw/` file created
- [ ] Summary shows file skipped

## Manual Testing Checklist

- [ ] Test with at least 5 real inbox files
- [ ] Test entity disambiguation with multiple options
- [ ] Test enriching notes with existing timeline entries
- [ ] Test creating new notes with all required frontmatter
- [ ] Test index updates for different category types
- [ ] Test `.raw/` directory creation
- [ ] Test backlink format and validity in Obsidian
- [ ] Test error handling: target file doesn't exist
- [ ] Test error handling: template doesn't exist
- [ ] Review completion summary for accuracy

## Notes

- When testing in real PDQ, commit after each test scenario
- Use separate test branches if testing in production repository
- Verify in Obsidian that all links are valid and backlinks work
```

- [ ] **Step 2: Commit**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add TEST.md
git commit -m "docs: add comprehensive test scenarios and validation checklist"
```

---

## Task 16: Create Complete Skill Documentation

**Files:**
- Modify: `~/.claude/plugins/user/pdq-ingest-notes/SKILL.md`
- Modify: `~/.claude/plugins/user/pdq-file-processor/SKILL.md`

- [ ] **Step 1: Add README/Overview section to main skill**

At the end of main skill SKILL.md, add:

```markdown
---

## Quick Reference

### When to Use

- You have files in `00 Inbox/` waiting to be processed
- You want to intelligently route content to Ideas, Projects, Domains, Entities, or Wiki
- You prefer interactive decisions on ambiguous routing

### What It Does

1. Lists all inbox files
2. For each file: analyzes and proposes updates
3. Asks you to choose when routing is ambiguous
4. Creates/enriches/reclassifies notes
5. Archives source files with backlinks
6. Updates indexes and timelines

### Files It Affects

- Creates: new notes in `10 Ideas/`, `20 Projects/`, `30 Domains/`, `40 Entities/`, `50 Wiki/`
- Modifies: existing notes (adds content, timeline entries)
- Moves: inbox files to `.raw/` subdirectories
- Updates: `_index.md` files in target directories

### Workflow Duration

- 2-5 minutes per file depending on ambiguity
- Faster for clear-cut files, slower for complex content requiring multiple decisions

### Success Indicators

- All inbox files processed
- Source files archived in `.raw/`
- New notes follow templates with complete frontmatter
- Timeline entries reference source files
- Indexes updated accurately
- User satisfied with routing decisions
```

- [ ] **Step 2: Add README to file processor**

At the end of file processor SKILL.md, add:

```markdown
---

## Quick Reference

### Input

Single markdown file from inbox with content like:
- Meeting notes
- Working notes/thoughts
- External content summaries

### Output

Structured proposal including:
- What updates are needed (new note / enrich / reclassify)
- Where updates should go (target paths)
- Any ambiguities that need user decisions
- Suggested content for new notes

### What This Subagent Does

1. Analyzes inbox file content
2. Determines update type(s)
3. Proposes routing with confidence
4. Identifies decisions that need user judgment
5. Returns structured proposal

### Does NOT Do

- Execute any file operations
- Make final routing decisions on ambiguous content
- Create or modify any files
- Commit changes

### Confidence Levels

- **High**: Content clearly matches specific target, no ambiguity
- **Medium**: Content matches target but could have multiple interpretations
- **Low**: Content is ambiguous or could fit multiple targets

### When Used

Called by `/pdq:ingest-notes` main skill for each inbox file
```

- [ ] **Step 3: Commit both**

```bash
cd ~/.claude/plugins/user/pdq-ingest-notes
git add SKILL.md
git commit -m "docs: add comprehensive skill documentation and quick reference"

cd ~/.claude/plugins/user/pdq-file-processor
git add SKILL.md
git commit -m "docs: add subagent documentation and quick reference"
```

---

## Self-Review Against Spec

**Spec Coverage:**

✓ Task 1-2: Main skill orchestration (Initialize phase, Processing loop, Completion phase)
✓ Task 3-4: File Processor subagent (Content analysis, categorization, routing proposal, disambiguation identification)
✓ Task 5: Note creation from templates with YAML frontmatter and timeline entries
✓ Task 6: Note enrichment with content appending and timeline entries
✓ Task 7: Content reclassification (Idea→Project, status changes, etc.)
✓ Task 8: Index updates for all category types (Ideas/Projects/Domains/Entities/Wiki)
✓ Task 9: Timeline entry creation with source backlinks
✓ Task 10: Source file movement to `.raw/` directories
✓ Task 11: Obsidian-style backlink creation
✓ Task 12: Disambiguation handling with user decisions
✓ Task 13: Error handling for all identified failure modes
✓ Task 14: Completion summary and reporting
✓ Task 15: Testing scenarios and validation
✓ Task 16: Complete documentation

**Placeholder Scan:**

✓ No TBD, TODO, or incomplete sections
✓ All code examples shown in full
✓ All commands with expected behavior specified
✓ All user prompts written out completely
✓ All file formats and templates documented

**Type Consistency:**

✓ Timeline entry format consistent across all tasks
✓ Backlink format consistent: `[[filename]]`
✓ Template filenames consistent with zy Templates/
✓ Path conventions consistent with PDQ structure
✓ Frontmatter fields consistent across note types

**No Spec Gaps:**

Spec requirements → Implementation tasks:
- Source preservation (.raw/) ✓ Task 10
- Interactive disambiguation ✓ Tasks 4, 12
- Complete updates (timeline + index) ✓ Tasks 8, 9
- Batch processing ✓ Tasks 1-2
- Subagent delegation ✓ Tasks 3-4
- Template usage ✓ Task 5
- Obsidian backlinks ✓ Task 11
- Error handling ✓ Task 13
- Testing ✓ Task 15

---

## Execution Handoff

**Plan complete and saved to `docs/superpowers/plans/2026-04-26-pdq-ingest-plan.md`.**

Two execution options available:

**Option 1: Subagent-Driven (Recommended)**
- Fresh subagent per task
- Parallel execution where possible
- Review checkpoint after each task
- Fastest iteration

**Option 2: Inline Execution**
- Execute all tasks in this session
- Batch execution with checkpoints
- More context retention
- Slower but complete visibility

**Which approach would you prefer?**
