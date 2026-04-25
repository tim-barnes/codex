#!/usr/bin/env bash
# Usage: bash scaffold.sh [TARGET_DIR]
# Without TARGET_DIR: scaffolds in the current directory.
# With TARGET_DIR: scaffolds into that directory (creates it if needed).
# Re-running overwrites templates but skips existing dashboard notes.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$PWD}"

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

templates=(
  "project-index.md"
  "person.md"
  "team.md"
  "software.md"
  "domain.md"
  "wiki-reference.md"
  "wiki-learning.md"
  "journal-daily.md"
)

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

# Pre-flight: verify all source files exist before touching TARGET_DIR
for tmpl in "${templates[@]}"; do
  src="$SCRIPT_DIR/zy Templates/$tmpl"
  if [[ ! -f "$src" ]]; then
    echo "Error: source template not found: $src" >&2
    exit 1
  fi
done

for dash in "${dashboards[@]}"; do
  src="$SCRIPT_DIR/$dash"
  if [[ ! -f "$src" ]]; then
    echo "Error: source dashboard not found: $src" >&2
    exit 1
  fi
done

# Create directory structure
mkdir -p "$TARGET_DIR"
for dir in "${dirs[@]}"; do
  mkdir -p "$TARGET_DIR/$dir"
  echo "Created: $dir"
done

# Copy templates (always overwrite — canonical sources)
for tmpl in "${templates[@]}"; do
  cp "$SCRIPT_DIR/zy Templates/$tmpl" "$TARGET_DIR/zy Templates/$tmpl"
  echo "Copied template: $tmpl"
done

# Copy dashboard notes (skip if already exist to avoid overwriting edits)
for dash in "${dashboards[@]}"; do
  dest="$TARGET_DIR/$dash"
  if [[ ! -f "$dest" ]]; then
    cp "$SCRIPT_DIR/$dash" "$dest"
    echo "Copied: $dash"
  else
    echo "Skipped (exists): $dash"
  fi
done

echo ""
echo "Vault scaffold complete."
