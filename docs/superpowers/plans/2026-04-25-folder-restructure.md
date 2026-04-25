# Codex Folder Restructure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename five numbered folders, add `10 Ideas` and `90 Raw`, and add `_index.md` dashboard files to every folder.

**Architecture:** Direct `git mv` renames preserve history for existing `_index.md` files; new folders and all missing dashboards are created inline; `scaffold.sh` is updated last to reflect the final layout.

**Tech Stack:** Bash, git, Markdown

**Working directory:** `/Users/tim/Code/codex` for all commands.

---

## File Map

| Action | Path |
|--------|------|
| `git mv` | `10 Projects/` → `20 Projects/` |
| `git mv` | `20 Domains/` → `30 Domains/` |
| `git mv` | `30 Entities/` → `40 Entities/` |
| `git mv` | `40 Wiki/` → `50 Wiki/` |
| `git mv` | `50 Journal/` → `60 Journal/` |
| Create dir | `10 Ideas/Work/` |
| Create dir | `10 Ideas/Personal/` |
| Create dir | `90 Raw/` |
| Create | `00 Inbox/_index.md` |
| Create | `10 Ideas/_index.md` |
| Create | `10 Ideas/Work/_index.md` |
| Create | `10 Ideas/Personal/_index.md` |
| Create | `20 Projects/_index.md` |
| Create | `30 Domains/_index.md` |
| Create | `30 Domains/Technical/_index.md` |
| Create | `30 Domains/Organisational/_index.md` |
| Create | `30 Domains/Systems/_index.md` |
| Create | `40 Entities/_index.md` |
| Create | `40 Entities/People/_index.md` |
| Create | `40 Entities/Teams/_index.md` |
| Create | `40 Entities/Software/_index.md` |
| Create | `50 Wiki/_index.md` |
| Create | `50 Wiki/Reference/_index.md` |
| Create | `50 Wiki/Learning/_index.md` |
| Create | `50 Wiki/Learning/books/_index.md` |
| Create | `50 Wiki/Learning/courses/_index.md` |
| Create | `50 Wiki/Learning/talks/_index.md` |
| Create | `60 Journal/_index.md` |
| Create | `90 Raw/_index.md` |
| Modify | `scaffold.sh` |

Moved by `git mv` (no action needed):
- `20 Projects/Work/_index.md` (was `10 Projects/Work/_index.md`)
- `20 Projects/Personal/_index.md` (was `10 Projects/Personal/_index.md`)

---

## Task 1: Rename existing numbered folders

**Files:** directory renames only (git tracks as renames)

- [ ] **Step 1: Verify current state**

```bash
ls /Users/tim/Code/codex
```

Expected output includes: `00 Inbox`, `10 Projects`, `20 Domains`, `30 Entities`, `40 Wiki`, `50 Journal`

- [ ] **Step 2: Rename the five folders**

```bash
cd /Users/tim/Code/codex
git mv "10 Projects" "20 Projects"
git mv "20 Domains" "30 Domains"
git mv "30 Entities" "40 Entities"
git mv "40 Wiki" "50 Wiki"
git mv "50 Journal" "60 Journal"
```

- [ ] **Step 3: Verify renames**

```bash
ls /Users/tim/Code/codex
```

Expected: `00 Inbox`, `20 Projects`, `30 Domains`, `40 Entities`, `50 Wiki`, `60 Journal` (no 10/20/30/40/50 prefixed project/domain/entity/wiki/journal folders)

```bash
ls "/Users/tim/Code/codex/20 Projects"
```

Expected: `Personal  Work`

```bash
ls "/Users/tim/Code/codex/20 Projects/Work"
```

Expected: `_index.md`

- [ ] **Step 4: Commit**

```bash
cd /Users/tim/Code/codex
git commit -m "chore: rename numbered folders (10→20, 20→30, 30→40, 40→50, 50→60)"
```

---

## Task 2: Create 10 Ideas folder

**Files:**
- Create: `10 Ideas/Work/_index.md`
- Create: `10 Ideas/Personal/_index.md`
- Create: `10 Ideas/_index.md`

- [ ] **Step 1: Create directories**

```bash
mkdir -p "/Users/tim/Code/codex/10 Ideas/Work" "/Users/tim/Code/codex/10 Ideas/Personal"
```

- [ ] **Step 2: Create `10 Ideas/_index.md`**

```bash
cat > "/Users/tim/Code/codex/10 Ideas/_index.md" << 'EOF'
# Ideas

| Subfolder | |
|-----------|---|
| [Work](Work/) | |
| [Personal](Personal/) | |
EOF
```

- [ ] **Step 3: Create `10 Ideas/Work/_index.md`**

```bash
cat > "/Users/tim/Code/codex/10 Ideas/Work/_index.md" << 'EOF'
# Work Ideas

## Active

| Idea | Status | Domain | Updated |
|------|--------|--------|---------|
| | | | |

## Someday / Maybe

| Idea | Notes |
|------|-------|
| | |

---
*Promote to `20 Projects/Work/` when ready to act.*
EOF
```

- [ ] **Step 4: Create `10 Ideas/Personal/_index.md`**

```bash
cat > "/Users/tim/Code/codex/10 Ideas/Personal/_index.md" << 'EOF'
# Personal Ideas

## Active

| Idea | Status | Domain | Updated |
|------|--------|--------|---------|
| | | | |

## Someday / Maybe

| Idea | Notes |
|------|-------|
| | |

---
*Promote to `20 Projects/Personal/` when ready to act.*
EOF
```

- [ ] **Step 5: Verify**

```bash
find "/Users/tim/Code/codex/10 Ideas" -type f
```

Expected:
```
/Users/tim/Code/codex/10 Ideas/_index.md
/Users/tim/Code/codex/10 Ideas/Work/_index.md
/Users/tim/Code/codex/10 Ideas/Personal/_index.md
```

- [ ] **Step 6: Commit**

```bash
cd /Users/tim/Code/codex
git add "10 Ideas"
git commit -m "feat: add 10 Ideas folder with Work/Personal structure"
```

---

## Task 3: Create 90 Raw folder

**Files:**
- Create: `90 Raw/_index.md`

- [ ] **Step 1: Create directory and `_index.md`**

```bash
mkdir "/Users/tim/Code/codex/90 Raw"
cat > "/Users/tim/Code/codex/90 Raw/_index.md" << 'EOF'
# Raw

| File | Created | Tags |
|------|---------|------|
| | | |

---
*Unprocessed notes. Process into appropriate folders when ready.*
EOF
```

- [ ] **Step 2: Verify**

```bash
cat "/Users/tim/Code/codex/90 Raw/_index.md"
```

Expected: the content above.

- [ ] **Step 3: Commit**

```bash
cd /Users/tim/Code/codex
git add "90 Raw"
git commit -m "feat: add 90 Raw folder"
```

---

## Task 4: Add _index.md to top-level folders

**Files:**
- Create: `00 Inbox/_index.md`
- Create: `20 Projects/_index.md`
- Create: `30 Domains/_index.md`
- Create: `40 Entities/_index.md`
- Create: `50 Wiki/_index.md`
- Create: `60 Journal/_index.md`

- [ ] **Step 1: Create `00 Inbox/_index.md`**

```bash
cat > "/Users/tim/Code/codex/00 Inbox/_index.md" << 'EOF'
# Inbox

| File | Created | Action |
|------|---------|--------|
| | | |

---
*Process regularly — organise into Projects, Domains, Entities, or Journal.*
EOF
```

- [ ] **Step 2: Create `20 Projects/_index.md`**

```bash
cat > "/Users/tim/Code/codex/20 Projects/_index.md" << 'EOF'
# Projects

| Subfolder | |
|-----------|---|
| [Work](Work/) | |
| [Personal](Personal/) | |
EOF
```

- [ ] **Step 3: Create `30 Domains/_index.md`**

```bash
cat > "/Users/tim/Code/codex/30 Domains/_index.md" << 'EOF'
# Domains

| Subfolder | |
|-----------|---|
| [Technical](Technical/) | |
| [Organisational](Organisational/) | |
| [Systems](Systems/) | |
EOF
```

- [ ] **Step 4: Create `40 Entities/_index.md`**

```bash
cat > "/Users/tim/Code/codex/40 Entities/_index.md" << 'EOF'
# Entities

| Subfolder | |
|-----------|---|
| [People](People/) | |
| [Teams](Teams/) | |
| [Software](Software/) | |
EOF
```

- [ ] **Step 5: Create `50 Wiki/_index.md`**

```bash
cat > "/Users/tim/Code/codex/50 Wiki/_index.md" << 'EOF'
# Wiki

| Subfolder | |
|-----------|---|
| [Reference](Reference/) | |
| [Learning](Learning/) | |
EOF
```

- [ ] **Step 6: Create `60 Journal/_index.md`**

```bash
cat > "/Users/tim/Code/codex/60 Journal/_index.md" << 'EOF'
# Journal

| Date | Title | Tags |
|------|-------|------|
| | | |
EOF
```

- [ ] **Step 7: Verify**

```bash
find /Users/tim/Code/codex -maxdepth 2 -name "_index.md" | sort
```

Expected (at this point):
```
/Users/tim/Code/codex/00 Inbox/_index.md
/Users/tim/Code/codex/10 Ideas/_index.md
/Users/tim/Code/codex/10 Ideas/Personal/_index.md
/Users/tim/Code/codex/10 Ideas/Work/_index.md
/Users/tim/Code/codex/20 Projects/_index.md
/Users/tim/Code/codex/20 Projects/Personal/_index.md
/Users/tim/Code/codex/20 Projects/Work/_index.md
/Users/tim/Code/codex/30 Domains/_index.md
/Users/tim/Code/codex/40 Entities/_index.md
/Users/tim/Code/codex/50 Wiki/_index.md
/Users/tim/Code/codex/60 Journal/_index.md
/Users/tim/Code/codex/90 Raw/_index.md
```

- [ ] **Step 8: Commit**

```bash
cd /Users/tim/Code/codex
git add "00 Inbox/_index.md" "20 Projects/_index.md" "30 Domains/_index.md" "40 Entities/_index.md" "50 Wiki/_index.md" "60 Journal/_index.md"
git commit -m "feat: add _index.md to top-level folders"
```

---

## Task 5: Add _index.md to subfolders

**Files:**
- Create: `30 Domains/Technical/_index.md`
- Create: `30 Domains/Organisational/_index.md`
- Create: `30 Domains/Systems/_index.md`
- Create: `40 Entities/People/_index.md`
- Create: `40 Entities/Teams/_index.md`
- Create: `40 Entities/Software/_index.md`
- Create: `50 Wiki/Reference/_index.md`
- Create: `50 Wiki/Learning/_index.md`
- Create: `50 Wiki/Learning/books/_index.md`
- Create: `50 Wiki/Learning/courses/_index.md`
- Create: `50 Wiki/Learning/talks/_index.md`

- [ ] **Step 1: Create Domains subfolder indexes**

```bash
cat > "/Users/tim/Code/codex/30 Domains/Technical/_index.md" << 'EOF'
# Technical Domains

| Domain | Description | Related Projects |
|--------|-------------|-----------------|
| | | |
EOF

cat > "/Users/tim/Code/codex/30 Domains/Organisational/_index.md" << 'EOF'
# Organisational Domains

| Domain | Description | Related Projects |
|--------|-------------|-----------------|
| | | |
EOF

cat > "/Users/tim/Code/codex/30 Domains/Systems/_index.md" << 'EOF'
# Systems Domains

| Domain | Description | Related Projects |
|--------|-------------|-----------------|
| | | |
EOF
```

- [ ] **Step 2: Create Entities subfolder indexes**

```bash
cat > "/Users/tim/Code/codex/40 Entities/People/_index.md" << 'EOF'
# People

| Name | Role | Organisation | Tags |
|------|------|--------------|------|
| | | | |
EOF

cat > "/Users/tim/Code/codex/40 Entities/Teams/_index.md" << 'EOF'
# Teams

| Team | Organisation | Purpose | Tags |
|------|--------------|---------|------|
| | | | |
EOF

cat > "/Users/tim/Code/codex/40 Entities/Software/_index.md" << 'EOF'
# Software

| Name | Type | Purpose | Tags |
|------|------|---------|------|
| | | | |
EOF
```

- [ ] **Step 3: Create Wiki subfolder indexes**

```bash
cat > "/Users/tim/Code/codex/50 Wiki/Reference/_index.md" << 'EOF'
# Reference

| Title | Topic | Tags |
|-------|-------|------|
| | | |
EOF

cat > "/Users/tim/Code/codex/50 Wiki/Learning/_index.md" << 'EOF'
# Learning

| Subfolder | |
|-----------|---|
| [Books](books/) | |
| [Courses](courses/) | |
| [Talks](talks/) | |
EOF

cat > "/Users/tim/Code/codex/50 Wiki/Learning/books/_index.md" << 'EOF'
# Books

| Title | Author | Status | Tags |
|-------|--------|--------|------|
| | | | |
EOF

cat > "/Users/tim/Code/codex/50 Wiki/Learning/courses/_index.md" << 'EOF'
# Courses

| Title | Provider | Status | Tags |
|-------|----------|--------|------|
| | | | |
EOF

cat > "/Users/tim/Code/codex/50 Wiki/Learning/talks/_index.md" << 'EOF'
# Talks

| Title | Speaker | Status | Tags |
|-------|---------|--------|------|
| | | | |
EOF
```

- [ ] **Step 4: Verify all _index.md files exist**

```bash
find /Users/tim/Code/codex -name "_index.md" | grep -v ".git" | sort
```

Expected (23 total — 2 pre-existing + 21 new):
```
/Users/tim/Code/codex/00 Inbox/_index.md
/Users/tim/Code/codex/10 Ideas/_index.md
/Users/tim/Code/codex/10 Ideas/Personal/_index.md
/Users/tim/Code/codex/10 Ideas/Work/_index.md
/Users/tim/Code/codex/20 Projects/_index.md
/Users/tim/Code/codex/20 Projects/Personal/_index.md
/Users/tim/Code/codex/20 Projects/Work/_index.md
/Users/tim/Code/codex/30 Domains/_index.md
/Users/tim/Code/codex/30 Domains/Organisational/_index.md
/Users/tim/Code/codex/30 Domains/Systems/_index.md
/Users/tim/Code/codex/30 Domains/Technical/_index.md
/Users/tim/Code/codex/40 Entities/_index.md
/Users/tim/Code/codex/40 Entities/People/_index.md
/Users/tim/Code/codex/40 Entities/Software/_index.md
/Users/tim/Code/codex/40 Entities/Teams/_index.md
/Users/tim/Code/codex/50 Wiki/_index.md
/Users/tim/Code/codex/50 Wiki/Learning/_index.md
/Users/tim/Code/codex/50 Wiki/Learning/books/_index.md
/Users/tim/Code/codex/50 Wiki/Learning/courses/_index.md
/Users/tim/Code/codex/50 Wiki/Learning/talks/_index.md
/Users/tim/Code/codex/50 Wiki/Reference/_index.md
/Users/tim/Code/codex/60 Journal/_index.md
/Users/tim/Code/codex/90 Raw/_index.md
```

- [ ] **Step 5: Commit**

```bash
cd /Users/tim/Code/codex
git add "30 Domains" "40 Entities" "50 Wiki"
git commit -m "feat: add _index.md to all subfolders"
```

---

## Task 6: Update scaffold.sh

**Files:**
- Modify: `scaffold.sh`

- [ ] **Step 1: Replace the `dirs` array**

In `scaffold.sh`, replace:
```bash
dirs=(
  "00 Inbox"
  "10 Projects/Work"
  "10 Projects/Personal"
  "20 Domains/Technical"
  "20 Domains/Organisational"
  "20 Domains/Systems"
  "30 Entities/People"
  "30 Entities/Teams"
  "30 Entities/Software"
  "40 Wiki/Reference"
  "40 Wiki/Learning/books"
  "40 Wiki/Learning/courses"
  "40 Wiki/Learning/talks"
  "50 Journal"
  "zy Templates"
  "zz Archive/Projects"
  "zz Archive/Domains"
  "zz Archive/Entities"
  "zz Archive/Wiki"
  "zz Archive/Journal"
)
```

With:
```bash
dirs=(
  "00 Inbox"
  "10 Ideas/Work"
  "10 Ideas/Personal"
  "20 Projects/Work"
  "20 Projects/Personal"
  "30 Domains/Technical"
  "30 Domains/Organisational"
  "30 Domains/Systems"
  "40 Entities/People"
  "40 Entities/Teams"
  "40 Entities/Software"
  "50 Wiki/Reference"
  "50 Wiki/Learning/books"
  "50 Wiki/Learning/courses"
  "50 Wiki/Learning/talks"
  "60 Journal"
  "90 Raw"
  "zy Templates"
  "zz Archive/Projects"
  "zz Archive/Domains"
  "zz Archive/Entities"
  "zz Archive/Wiki"
  "zz Archive/Journal"
)
```

- [ ] **Step 2: Replace the `dashboards` array**

In `scaffold.sh`, replace:
```bash
dashboards=(
  "10 Projects/Work/_index.md"
  "10 Projects/Personal/_index.md"
)
```

With:
```bash
dashboards=(
  "00 Inbox/_index.md"
  "10 Ideas/_index.md"
  "10 Ideas/Work/_index.md"
  "10 Ideas/Personal/_index.md"
  "20 Projects/_index.md"
  "20 Projects/Work/_index.md"
  "20 Projects/Personal/_index.md"
  "30 Domains/_index.md"
  "30 Domains/Technical/_index.md"
  "30 Domains/Organisational/_index.md"
  "30 Domains/Systems/_index.md"
  "40 Entities/_index.md"
  "40 Entities/People/_index.md"
  "40 Entities/Teams/_index.md"
  "40 Entities/Software/_index.md"
  "50 Wiki/_index.md"
  "50 Wiki/Reference/_index.md"
  "50 Wiki/Learning/_index.md"
  "50 Wiki/Learning/books/_index.md"
  "50 Wiki/Learning/courses/_index.md"
  "50 Wiki/Learning/talks/_index.md"
  "60 Journal/_index.md"
  "90 Raw/_index.md"
)
```

- [ ] **Step 3: Verify scaffold.sh runs cleanly against a temp directory**

```bash
bash /Users/tim/Code/codex/scaffold.sh /tmp/codex-test
```

Expected: output lists all dirs as `Created: ...`, all templates as `Copied template: ...`, all dashboards as `Copied: ...`, ends with `Vault scaffold complete.` No errors.

- [ ] **Step 4: Clean up temp directory**

```bash
rm -rf /tmp/codex-test
```

- [ ] **Step 5: Commit**

```bash
cd /Users/tim/Code/codex
git add scaffold.sh
git commit -m "chore: update scaffold.sh for new folder structure and _index.md dashboards"
```
