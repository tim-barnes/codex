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
