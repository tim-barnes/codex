# Codex Folder Restructure

**Date:** 2026-04-25

## Goal

Add `10 Ideas` and `90 Raw` folders to the codex vault, shift the existing numbered folders to maintain a continuous 10-step sequence, and add `_index.md` dashboard files to every folder (top-level and subfolders).

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

## _index.md Files

Every folder (top-level and subfolder) gets an `_index.md`. Content is tailored to the folder's purpose. Files are treated as dashboards in `scaffold.sh` — created on first scaffold, never overwritten on re-runs to preserve edits.

Full list of `_index.md` files to create:

| File | Status |
|------|--------|
| `00 Inbox/_index.md` | new |
| `10 Ideas/_index.md` | new |
| `10 Ideas/Work/_index.md` | new |
| `10 Ideas/Personal/_index.md` | new |
| `20 Projects/_index.md` | new |
| `20 Projects/Work/_index.md` | moved from `10 Projects/Work/_index.md` (exists) |
| `20 Projects/Personal/_index.md` | moved from `10 Projects/Personal/_index.md` (exists) |
| `30 Domains/_index.md` | new |
| `30 Domains/Technical/_index.md` | new |
| `30 Domains/Organisational/_index.md` | new |
| `30 Domains/Systems/_index.md` | new |
| `40 Entities/_index.md` | new |
| `40 Entities/People/_index.md` | new |
| `40 Entities/Teams/_index.md` | new |
| `40 Entities/Software/_index.md` | new |
| `50 Wiki/_index.md` | new |
| `50 Wiki/Reference/_index.md` | new |
| `50 Wiki/Learning/_index.md` | new |
| `50 Wiki/Learning/books/_index.md` | new |
| `50 Wiki/Learning/courses/_index.md` | new |
| `50 Wiki/Learning/talks/_index.md` | new |
| `60 Journal/_index.md` | new |
| `90 Raw/_index.md` | new |

Each `_index.md` is a simple Markdown file with a heading matching the folder name and a placeholder table or list appropriate to the folder type. The two existing `_index.md` files (`Work` and `Personal` under Projects) already have a structured dashboard format — new files follow the same pattern scaled to their context.

## scaffold.sh Changes

- Add `"10 Ideas/Work"` and `"10 Ideas/Personal"` to the `dirs` array
- Shift all existing numbered entries: `10 Projects/*` → `20 Projects/*`, `20 Domains/*` → `30 Domains/*`, `30 Entities/*` → `40 Entities/*`, `40 Wiki/*` → `50 Wiki/*`, `50 Journal` → `60 Journal`
- Add `"90 Raw"` to the `dirs` array
- Expand `dashboards` array to include all `_index.md` paths listed above
- Update `dashboards` rename: `"10 Projects/..."` → `"20 Projects/..."`

## Implementation Steps

1. `git mv` each of the five numbered folders to their new names (inside `/Users/tim/Code/codex`)
2. `mkdir -p "10 Ideas/Work" "10 Ideas/Personal"` and `mkdir "90 Raw"`
3. Create all new `_index.md` files with appropriate content
4. Edit `scaffold.sh` to reflect new layout and expanded `dashboards` array
5. Commit all changes

## Out of Scope

- Renaming files inside folders (none reference the numbered folder paths)
- Updating the canvas (`0-BRAINSTORM.canvas`) — it contains no folder path references
- Changes to `zz Archive` sub-folders (mirrors Projects/Domains/Entities/Wiki/Journal labels but not numbers)
