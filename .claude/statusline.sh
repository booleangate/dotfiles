#!/usr/bin/env bash
# Claude Code status line.
#
# Reads the status JSON payload on stdin (fields per the CLI's status-line
# contract: model, effort, context_window, cost) and renders:
#   <cwd> ⎇ <branch> │ <model> · <effort> │ ctx <used>% (<used>/<window>) │ $<session cost>
#
# Fields absent from the payload (e.g. effort on models that don't expose it)
# are omitted rather than rendered blank.

set -uo pipefail

payload=$(cat)

# Unit separator, not tab: tab is IFS whitespace and would collapse the empty
# fields that optional payload keys (effort, model) legitimately produce.
IFS=$'\x1f' read -r cwd model effort fast used_pct used_tok ctx_size cost <<<"$(
  printf '%s' "$payload" | jq -j '
    [ .cwd // ""
    , .model.display_name // ""
    , .effort.level // ""
    , (.fast_mode // false | tostring)
    , (.context_window.used_percentage // 0 | floor | tostring)
    , (.context_window.total_input_tokens // 0 | tostring)
    , (.context_window.context_window_size // 0 | tostring)
    , (.cost.total_cost_usd // 0 | tostring)
    ] | join("")'
)"

DIM=$'\033[2m'
RESET=$'\033[0m'
CYAN=$'\033[36m'
MAGENTA=$'\033[35m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'

branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
[[ -z $branch ]] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

fmt_tokens() {
  local n=$1
  if ((n >= 1000000)); then
    printf '%d.%dM' "$((n / 1000000))" "$(((n % 1000000) / 100000))"
  else
    printf '%dk' "$((n / 1000))"
  fi
}

ctx_color=$GREEN
((used_pct >= 60)) && ctx_color=$YELLOW
((used_pct >= 85)) && ctx_color=$RED

parts=()

parts+=("${CYAN}${cwd/#$HOME/~}${RESET}")

[[ -n $branch ]] && parts+=("${MAGENTA}⎇ ${branch}${RESET}")

model_label=$model
[[ -n $effort ]] && model_label+=" · ${effort}"
[[ $fast == "true" ]] && model_label+=" · fast"
[[ -n $model_label ]] && parts+=("$model_label")

((ctx_size > 0)) && parts+=("${ctx_color}ctx ${used_pct}%${RESET} ${DIM}($(fmt_tokens "$used_tok")/$(fmt_tokens "$ctx_size"))${RESET}")

parts+=("$(printf '$%.2f' "$cost")")

sep="${DIM} │ ${RESET}"
out=""
for p in "${parts[@]}"; do
  [[ -n $out ]] && out+=$sep
  out+=$p
done
printf '%s' "$out"
