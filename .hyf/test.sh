#!/usr/bin/env bash
set -uo pipefail

# Week 12 autograder.
# Ladder: the untouched scaffold must FAIL; a completed Minimum solution passes.
# Work-verifying checks (not mere file presence):
#   - metric Names filled with real (non-placeholder) values
#   - Panel 1 implemented (no NotImplementedError / TODO: implement left)
#   - AI_ASSIST.md filled with real content

PASSING=6
SCORE=0

check() {
    if [ "$2" = "true" ]; then echo "  PASS  $1"; SCORE=$((SCORE + 1));
    else echo "  FAIL  $1"; fi
}

METRIC_FILE="../task-1/metric_definitions.md"
APP_FILE="../task-2/app.py"
AI_FILE="../AI_ASSIST.md"

# 1. metric_definitions.md exists
[ -f "$METRIC_FILE" ] && check "metric_definitions.md exists" "true" || check "metric_definitions.md exists" "false"

# 2. >=3 metric Name fields filled with a REAL value (not empty, not _(...)_ placeholder)
FILLED=$(grep -E '^\| \*\*Name\*\* \|' "$METRIC_FILE" 2>/dev/null \
    | sed -E 's/^\| \*\*Name\*\* \|([^|]*)\|.*/\1/' \
    | grep -vE '^[[:space:]]*$' | grep -vF '_(' | wc -l | tr -d ' ')
[ "${FILLED:-0}" -ge 3 ] && check "3+ metric Name fields filled" "true" \
    || check "3+ metric Name fields filled (found ${FILLED:-0})" "false"

# 3. task-2/app.py exists
[ -f "$APP_FILE" ] && check "task-2/app.py exists" "true" || check "task-2/app.py exists" "false"

# 4. Panel 1 implemented: no NotImplementedError / TODO: implement remaining
if grep -qE 'raise NotImplementedError|TODO: implement' "$APP_FILE" 2>/dev/null; then
    check "Panel 1 implemented (get_dag_runs)" "false"
else
    check "Panel 1 implemented (get_dag_runs)" "true"
fi

# 5. app.py uses @st.cache_data (quality: do not strip caching)
grep -q "st.cache_data" "$APP_FILE" 2>/dev/null \
    && check "app.py uses @st.cache_data" "true" || check "app.py uses @st.cache_data" "false"

# 6. app.py has no hardcoded password
if grep -qE 'password[[:space:]]*=[[:space:]]*"[^"]+"' "$APP_FILE" 2>/dev/null; then
    check "app.py has no hardcoded password" "false"
else
    check "app.py has no hardcoded password" "true"
fi

# 7. AI_ASSIST.md filled: >=3 real content lines (exclude blanks, headings, placeholders)
if [ -f "$AI_FILE" ]; then
    AI_LINES=$(grep -vE '^[[:space:]]*$|^#|^⚠️|^Document' "$AI_FILE" | grep -vF '_(' | wc -l | tr -d ' ')
    [ "${AI_LINES:-0}" -ge 3 ] && check "AI_ASSIST.md documents LLM usage" "true" \
        || check "AI_ASSIST.md documents LLM usage (needs 3+ entries)" "false"
else
    check "AI_ASSIST.md exists" "false"
fi

if [ "$SCORE" -ge "$PASSING" ]; then PASS=true; else PASS=false; fi

cat > score.json <<JSONEOF
{
  "score": $SCORE,
  "pass": $PASS,
  "passingScore": $PASSING
}
JSONEOF

echo ""
echo "Score: $SCORE / 7  (passingScore 6)  pass: $PASS"
