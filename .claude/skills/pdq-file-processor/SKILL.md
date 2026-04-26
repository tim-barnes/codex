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
