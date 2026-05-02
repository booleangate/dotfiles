#!/usr/bin/env bash
# 100% AI generated. LGTM!
#
# rebase-onto-branch — rebase the currently checked-out branch onto a new base.
#
# Handles:
#   1) Parent branch was updated and still exists (pass the parent).
#   2) Parent was merged into the grandparent and deleted (pass the grandparent).
#
# Usage:
#   git checkout <my-branch>
#   rebase-onto-branch <new-base-branch> [--dry-run]
#
# Notes on correctness:
# - Scenario 1 (parent updated, still exists): --fork-point finds the old tip of the parent via its reflog, so only
#   your commits replay. Equivalent to git rebase <parent> but explicit.
# - Scenario 2a (parent was merge-committed into grandparent and deleted): merge-base(HEAD, grandparent) is the tip of
#   the old parent — only your commits replay. Works.
# - Scenario 2b (parent was squash-merged into grandparent): there's no shared SHA for the parent's commits in
#   grandparent's history, so merge-base falls back to the original fork point and the script will try to replay the
#   parent's commits too. Git will skip patches it detects as already applied; otherwise you'll resolve conflicts. If
#   your team squash-merges and you hit this often, the only clean fix is explicit parent tracking — say the word and
#   I'll add git config branch.<name>.parent bookkeeping.
#
# Safety:
# - Refuses on detached HEAD, dirty tree, or unknown base.
# - Read-only until the actual git rebase line — easy to dry-run by commenting it out.

set -euo pipefail

dry_run=0
args=()
for a in "$@"; do
  case "$a" in
    --dry-run|-n) dry_run=1 ;;
    -h|--help)
      sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    -*) echo "error: unknown flag '$a'" >&2; exit 1 ;;
    *) args+=("$a") ;;
  esac
done

[[ ${#args[@]} -eq 1 ]] || {
  echo "usage: $(basename "$0") <new-base-branch> [--dry-run]" >&2
  exit 1
}
new_base_branch="${args[0]}"

current=$(git symbolic-ref --short HEAD 2>/dev/null) || {
  echo "error: not on a branch (detached HEAD?)" >&2; exit 1
}
[[ "$current" != "$new_base_branch" ]] || {
  echo "error: current branch is the new base" >&2; exit 1
}

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "error: working tree dirty; commit or stash first" >&2; exit 1
fi

if [[ $dry_run -eq 1 ]]; then
  echo "→ [dry-run] skipping fetch (using local refs as-is)"
else
  echo "→ fetching"
  git fetch --quiet --all --prune
fi

# Accept either a local branch or origin/<branch>.
if git rev-parse --verify --quiet "$new_base_branch" >/dev/null; then
  base_ref="$new_base_branch"
elif git rev-parse --verify --quiet "origin/$new_base_branch" >/dev/null; then
  base_ref="origin/$new_base_branch"
else
  echo "error: '$new_base_branch' not found locally or on origin" >&2; exit 1
fi

# Find the cutoff (where the current branch's "own" commits begin).
cutoff=$(git merge-base --fork-point "$base_ref" HEAD 2>/dev/null || true)
[[ -n "$cutoff" ]] || cutoff=$(git merge-base "$base_ref" HEAD)

n=$(git rev-list --count "$cutoff..HEAD")
target_sha=$(git rev-parse --short "$base_ref")

if [[ $dry_run -eq 1 ]]; then
  echo "→ [dry-run] would rebase '$current' onto '$base_ref' ($target_sha)"
  echo "          cutoff: ${cutoff:0:8}"
  echo "          $n commit(s) would be replayed:"
  git log --oneline --reverse "$cutoff..HEAD" | sed 's/^/            /'
  echo "→ [dry-run] no changes made. re-run without --dry-run to execute."
  exit 0
fi

echo "→ rebasing '$current' onto '$base_ref' (cutoff ${cutoff:0:8}, $n commit(s) to replay)"
git rebase --onto "$base_ref" "$cutoff" "$current"

echo "✓ done. inspect: git log --oneline ${base_ref}..HEAD"