# Raw Folder Ingestion Structure Design

**Date:** 2026-04-25
**Author:** Tim Barnes
**Status:** Approved

## Overview

Restructure the folder system to distribute raw content ingestion across all main folder categories via `.raw` subfolders, removing the centralized `90 Raw` folder.

## Problem Statement

Currently, raw unprocessed content is collected in a single `90 Raw` folder. The new approach distributes raw content intake to each major folder category (Projects, Domains, Entities, Wiki, Ideas, Archive), allowing raw items to be processed into their destination folders more naturally.

## Architecture

### Folder Structure Changes

**Remove:**
- `90 Raw/` (entire folder, no content to preserve)

**Create `.raw` subfolders at all levels except:**
- `00 Inbox/` (entry point for raw content—no `.raw` needed)
- `zz Archive/Journal/` (archived journal—excluded)
- `zy Templates/` (reference templates—excluded)

**Result:** Every other folder at every nesting level gets a `.raw` subfolder.

Example:
```
20 Projects/
  .raw/
  Work/
    .raw/
  Personal/
    .raw/
30 Domains/
  .raw/
  Organisational/
    .raw/
  Systems/
    .raw/
  Technical/
    .raw/
...
```

### Ingestion Flow

1. Raw content enters via `00 Inbox`
2. Ingestion process (manual or automated) routes content to the appropriate folder's `.raw` subdirectory
3. User reviews and processes content from `.raw` into the main folder structure

### Properties of `.raw` Folders

- No `_index.md` files (they are simple containers)
- Not included in the main dashboard/navigation
- Treated as temporary processing spaces, not permanent storage
- Named with dot-prefix (`.raw`) to indicate they are internal/special

## Implementation

A Bash script will:
1. Find all directories recursively
2. Exclude the specified paths (Inbox, zz Archive/Journal, zy Templates)
3. Create `.raw` subfolders where they don't exist
4. Output a summary of created folders (audit trail)

## Success Criteria

- `90 Raw` folder is deleted
- All eligible folders have `.raw` subfolders at all levels
- No unintended folders are created
- Script output provides clear verification of what was created
