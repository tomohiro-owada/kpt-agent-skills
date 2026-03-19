---
name: kpt-trends
description: "Analyze trends across past KPT retrospectives — recurring problems, stale tries, improvement wins. Use this skill when the user asks about retrospective trends, whether things are improving, pattern analysis, 傾向分析, same problems keep coming up, or wants to check if their KPT process is actually working."
user-invocable: true
argument-hint: "[number of past retrospectives, default: all]"
---

# KPT Trend Analysis

Analyze multiple past KPT retrospectives to surface patterns. The point is to answer: "Are these retrospectives actually driving improvement, or are we just going through the motions?"

## Load Retrospectives

Read all `*.md` files in `~/.claude/kpt-logs/retrospectives/`.

If $ARGUMENTS is a number, use only the most recent N. Otherwise, analyze all.

If fewer than 2 exist, tell the user there's not enough data yet and suggest running `/kpt` a few more times first.

## Extract Items

From each retrospective, extract the date, period covered, and all Keep/Problem/Try items.

## Analyze Trends

### Recurring Problems (要注意)
Problems appearing in 2+ retrospectives are systemic. Those persisting across 3+ are **chronic** — they need a fundamentally different approach, not another incremental Try. Call these out clearly.

### Try → Keep Pipeline (改善の成果)
Try items that later became Keeps are wins. Highlight these — they're evidence the retrospective process is working and worth celebrating.

### Stale Tries (未着手・未解決)
Try items that were proposed but never resolved or mentioned again. These were either forgotten, too vague to act on, or deprioritized. Surface them so the user can decide: re-commit, reframe, or explicitly drop.

### Keep Stability (安定した強み)
Keeps appearing consistently are established strengths. Keeps that disappeared may signal regression — flag them.

### Cross-reference with Reports
If `~/.claude/kpt-logs/reports/` contains activity reports, look for correlations between activity patterns and problems (e.g., high context-switching weeks correlating with "focus" problems).

## Generate Report

```markdown
# KPT Trend Analysis
Generated: {today's date}
Retrospectives analyzed: N ({earliest} ~ {latest})

## Summary
{2-3 sentences: is the process healthy? improving? stagnant?}

## Chronic Problems (繰り返し出てくる課題)
| Problem | Occurrences | First Seen | Status |
|---------|-------------|------------|--------|
{For each, suggest a structural change}

## Improvement Wins (Try → Keep)
{Celebrate specific successes}

## Stale Tries (放置されたTry)
{For each: re-commit, reframe, or drop?}

## Stable Strengths (定着した強み)
{Consistent Keeps}

## Recommendations
{3-5 prioritized, concrete actions}
```

## Save

Save to `~/.claude/kpt-logs/reports/{YYYY-MM-DD}_trends.md`.

Tell the user the saved path.

## Style
- Write in Japanese
- Be direct — if improvement isn't happening, say so
- Support observations with specific examples from the retrospectives
