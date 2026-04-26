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
