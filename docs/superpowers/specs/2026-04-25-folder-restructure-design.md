# Codex Folder Restructure

**Date:** 2026-04-25

## Goal

Add `10 Ideas` and `90 Raw` folders to the codex vault, and shift the existing numbered folders to maintain a continuous 10-step sequence.

## New Folder Structure

| Folder | Status | Notes |
|--------|--------|-------|
| `00 Inbox` | unchanged | |
| `10 Ideas/Work` | new | mirrors Projects split |
| `10 Ideas/Personal` | new | mirrors Projects split |
| `20 Projects` | renamed from `10 Projects` | git mv preserves subfolders and _index.md files |
| `30 Domains` | renamed from `20 Domains` | subfolders preserved |
| `40 Entities` | renamed from `30 Entities` | subfolders preserved |
| `50 Wiki` | renamed from `40 Wiki` | subfolders preserved |
| `60 Journal` | renamed from `50 Journal` | |
| `90 Raw` | new | flat, no subfolders |
| `zy Templates` | unchanged | |
| `zz Archive` | unchanged | |

The gap between `60 Journal` and `90 Raw` (70, 80) is intentional, reserved for future folders.

## scaffold.sh Changes

- Add `"10 Ideas/Work"` and `"10 Ideas/Personal"` to the `dirs` array
- Shift all existing numbered entries: `10 Projects/*` → `20 Projects/*`, `20 Domains/*` → `30 Domains/*`, `30 Entities/*` → `40 Entities/*`, `40 Wiki/*` → `50 Wiki/*`, `50 Journal` → `60 Journal`
- Add `"90 Raw"` to the `dirs` array
- Update `dashboards` array: both `"10 Projects/..."` entries → `"20 Projects/..."`

## Implementation Steps

1. `git mv` each of the five numbered folders to their new names (inside `/Users/tim/Code/codex`)
2. `mkdir -p "10 Ideas/Work" "10 Ideas/Personal"` and `mkdir "90 Raw"`
3. Edit `scaffold.sh` to reflect new layout
4. Commit all changes

## Out of Scope

- Renaming files inside folders (none reference the numbered folder paths)
- Updating the canvas (`0-BRAINSTORM.canvas`) — it contains no folder path references
- Changes to `zz Archive` sub-folders (mirrors Projects/Domains/Entities/Wiki/Journal labels but not numbers)
