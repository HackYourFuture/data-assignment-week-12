#!/usr/bin/env bash
set -euo pipefail

# Week 12 autograder
# Checks:
#   1. metric_definitions.md has at least 3 metric entries
#   2. app.py uses @st.cache_data
#   3. app.py does not contain hardcoded passwords (heuristic: no "password" = "...")

PASS=true
SCORE=0

check() {
    local description="$1"
    local result="$2"
    if [ "$result" = "true" ]; then
        echo "  PASS  $description"
        SCORE=$((SCORE + 1))
    else
        echo "  FAIL  $description"
        PASS=false
    fi
}

METRIC_FILE="../task-1/metric_definitions.md"
APP_FILE="../task-2/app.py"

# Check 1: metric definitions file exists
if [ -f "$METRIC_FILE" ]; then
    check "metric_definitions.md exists" "true"
else
    check "metric_definitions.md exists" "false"
fi

# Check 2: at least 3 metric sections
METRIC_COUNT=$(grep -c "^## Metric" "$METRIC_FILE" 2>/dev/null || echo 0)
if [ "$METRIC_COUNT" -ge 3 ]; then
    check "metric_definitions.md has ≥3 metrics" "true"
else
    check "metric_definitions.md has ≥3 metrics (found $METRIC_COUNT)" "false"
fi

# Check 3: at least 3 metrics have a non-empty Name field
FILLED=$(grep -A1 "\*\*Name\*\*" "$METRIC_FILE" 2>/dev/null | grep -v "^--$" | grep -v "Name" | grep -v "^$" | grep -v "e.g\." | wc -l | tr -d ' ')
if [ "$FILLED" -ge 3 ]; then
    check "≥3 metric Name fields are filled" "true"
else
    check "≥3 metric Name fields are filled (found $FILLED)" "false"
fi

# Check 4: app.py exists
if [ -f "$APP_FILE" ]; then
    check "task-2/app.py exists" "true"
else
    check "task-2/app.py exists" "false"
fi

# Check 5: app.py uses @st.cache_data
if grep -q "st.cache_data" "$APP_FILE" 2>/dev/null; then
    check "app.py uses @st.cache_data" "true"
else
    check "app.py uses @st.cache_data" "false"
fi

# Check 6: app.py does not hardcode a password (heuristic)
if grep -qE 'password\s*=\s*"[^"]+"' "$APP_FILE" 2>/dev/null; then
    check "app.py has no hardcoded password string" "false"
else
    check "app.py has no hardcoded password string" "true"
fi

cat << JSONEOF > score.json
{
  "score": $SCORE,
  "pass": $PASS,
  "passingScore": 4
}
JSONEOF

echo ""
echo "Score: $SCORE / 6  —  pass: $PASS"
