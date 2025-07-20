#!/bin/bash

# Usage: ./find_word_removal.sh "aberrant" [/path/to/repo]

phrase="${1:-aberrant}"
repo_dir="${2:-.}"

if ! cd "$repo_dir" 2>/dev/null; then
  echo "Error: Cannot access directory $repo_dir"
  exit 1
fi

echo "Searching for removal of phrase: \"$phrase\""

last_commit=""
for commit in $(git rev-list --reverse --all); do
  if git grep -q --extended-regexp "\\b$phrase\\b" "$commit" -- '*'; then
    last_commit="$commit"
  elif [ -n "$last_commit" ]; then
    # Phrase disappeared after $last_commit
    echo ""
    echo "Found removal!"
    echo "The word \"$phrase\" was present up to commit: $last_commit"
    echo "It was removed in the next commit on this path: $commit"
    echo ""
    echo "=== Commit that removed it ==="
    git log --oneline -1 "$commit"
    echo ""
    git show --stat "$commit"
    echo ""
    echo "=== Relevant diff (lines with '$phrase') ==="
    git diff "$last_commit" "$commit" | grep -i -C 5 "$phrase" || echo "(No direct match in diff, possibly removed indirectly or in binary/file deletion)"
    exit 0
  fi
done

echo "The word \"$phrase\" is either:"
echo "  • Still present in the current HEAD"
echo "  • Was never present in any commit"
echo "  • Or the repository history is very unusual"
echo ""
echo "Quick check: does it exist now?"
if git grep -q "$phrase"; then
  echo "Yes, \"$phrase\" is still present in current files."
else
  echo "No, it's not in current files."
fi
