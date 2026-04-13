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
  "10 Projects/Work/_index.md"
  "10 Projects/Personal/_index.md"
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
