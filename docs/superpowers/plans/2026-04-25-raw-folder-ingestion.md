# Raw Folder Ingestion Structure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Distribute raw content ingestion across all main folder categories via `.raw` subfolders by removing the centralized `90 Raw` folder and creating `.raw` subfolders at all nesting levels in eligible folders.

**Architecture:** A Bash script will recursively find all directories, exclude the specified paths (Inbox, zz Archive/Journal, zy Templates), and create `.raw` subfolders. This ensures consistent structure across all folders and provides an audit trail of what was created.

**Tech Stack:** Bash, git

---

## File Structure

**No new code files are created.** This is a structural reorganization:
- Script: Create `create-raw-folders.sh` (temporary, deleted after running)
- Folders: Create `.raw/` subfolders throughout the directory tree
- Delete: Remove `90 Raw/` folder entirely

---

### Task 1: Create and Run Raw Folder Creation Script

**Files:**
- Create: `create-raw-folders.sh`
- Affected: All directories at all levels (except exclusions)

- [ ] **Step 1: Write the folder creation script**

Create the file `create-raw-folders.sh` with the following content:

```bash
#!/bin/bash

# Excluded paths that should NOT have .raw folders
EXCLUDE_PATTERNS=(
  "00 Inbox"
  "60 Journal"
  "zz Archive/Journal"
  "zy Templates"
)

# Function to check if a path should be excluded
should_exclude() {
  local path="$1"
  for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    if [[ "$path" == *"$pattern"* ]]; then
      return 0  # Should exclude
    fi
  done
  return 1  # Should not exclude
}

# Find all directories and create .raw subfolders
find . -mindepth 1 -type d \( -name ".git" -o -name ".conductor" -o -name "docs" -o -name ".context" \) -prune -o -type d -print | while read dir; do
  # Skip if directory should be excluded
  if should_exclude "$dir"; then
    continue
  fi
  
  # Skip if it's already a .raw folder
  if [[ "$dir" == *".raw"* ]]; then
    continue
  fi
  
  # Create .raw subfolder if it doesn't exist
  raw_folder="$dir/.raw"
  if [ ! -d "$raw_folder" ]; then
    mkdir -p "$raw_folder"
    echo "Created: $raw_folder"
  fi
done

echo "Raw folder creation complete."
```

- [ ] **Step 2: Make the script executable and run it**

Run: `chmod +x create-raw-folders.sh && ./create-raw-folders.sh`

Expected output: A list of created `.raw` folders like:
```
Created: ./10 Ideas/.raw
Created: ./10 Ideas/Personal/.raw
Created: ./10 Ideas/Work/.raw
Created: ./20 Projects/.raw
...
Created: zz Archive/.raw
```

- [ ] **Step 3: Verify the script output**

Run: `find . -type d -name ".raw" | sort`

Expected: A list of all `.raw` folders at all levels, excluding:
- Nothing under `00 Inbox/`
- Nothing under `60 Journal/`
- Nothing under `zz Archive/Journal/`
- Nothing under `zy Templates/`

- [ ] **Step 4: Delete the script**

Run: `rm create-raw-folders.sh`

- [ ] **Step 5: Commit the .raw folder creation**

Run:
```bash
git add -A
git commit -m "feat: create .raw folders for ingestion at all levels"
```

---

### Task 2: Remove 90 Raw Folder

**Files:**
- Delete: `90 Raw/` (entire folder)

- [ ] **Step 1: Delete the 90 Raw folder**

Run: `rm -rf "90 Raw"`

- [ ] **Step 2: Verify it's deleted**

Run: `ls -d "90 Raw" 2>&1`

Expected: `ls: cannot access '90 Raw': No such file or directory`

- [ ] **Step 3: Commit the removal**

Run:
```bash
git add -A
git commit -m "feat: remove 90 Raw folder in favor of distributed .raw folders"
```

---

### Task 3: Final Verification and Status

**Files:**
- None (verification only)

- [ ] **Step 1: Verify git status**

Run: `git status`

Expected: No untracked files, all changes committed

- [ ] **Step 2: List all .raw folders**

Run: `find . -type d -name ".raw" | wc -l`

Expected: A number > 20 (roughly 24-30 depending on template structure)

- [ ] **Step 3: Verify no .raw folders in excluded paths**

Run: `find "00 Inbox" "60 Journal" "zz Archive/Journal" "zy Templates" -type d -name ".raw" 2>/dev/null`

Expected: No output (no .raw folders found)

- [ ] **Step 4: Review the commit log**

Run: `git log --oneline -5`

Expected: Two new commits:
```
feat: remove 90 Raw folder in favor of distributed .raw folders
feat: create .raw folders for ingestion at all levels
```

---

## Plan Verification Checklist

- [x] **Spec coverage:** All requirements covered:
  - Remove `90 Raw` folder → Task 2
  - Create `.raw` subfolders at all levels → Task 1
  - Exclude Inbox, Journal, Templates → Task 1 (exclusion patterns)
  - No `_index.md` files in `.raw` → Task 1 (script only creates empty folders)
  - Audit trail of created folders → Task 1 (script outputs each created folder)

- [x] **No placeholders:** All steps contain exact commands and expected output

- [x] **Type consistency:** Only dealing with folder operations, no type mismatches
