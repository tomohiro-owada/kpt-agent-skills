---
name: kpt-trends
description: "Analyze trends across past KPT retrospectives. Identifies recurring problems, stale tries, and patterns over time. Use when you want to see if retrospectives are actually driving improvement."
user-invocable: true
argument-hint: "[number of past retrospectives to analyze, default: all]"
---

# KPT Trend Analyzer

You are analyzing trends across multiple past KPT retrospective records to surface patterns and measure improvement.

## Step 1: Load Past Retrospectives

Read all markdown files in `~/.claude/kpt-logs/retrospectives/` directory.

If $ARGUMENTS specifies a number, use only the most recent N retrospectives. Otherwise, analyze all available.

If fewer than 2 retrospectives exist, tell the user there isn't enough data yet and suggest running `/kpt` a few more times first.

## Step 2: Extract and Categorize

From each retrospective, extract:
- **Date** of the retrospective
- **Period** it covered
- **Keep items** — things that were going well
- **Problem items** — issues identified
- **Try items** — experiments proposed

## Step 3: Trend Analysis

Perform the following analyses:

### Recurring Problems (要注意)
- Problems that appear in 2+ retrospectives → these are systemic, not one-off
- Highlight any problem that has persisted across 3+ retrospectives as a **chronic issue**
- Suggest these need a fundamentally different approach, not just another Try

### Try → Keep Pipeline (改善の成果)
- Try items from older retrospectives that became Keep items later → celebrate these wins
- This is evidence that the retrospective process is working

### Stale Tries (未着手・未解決)
- Try items that were proposed but never appeared as Keep (resolved) or weren't mentioned again
- These may have been forgotten or deprioritized — surface them for re-evaluation

### Keep Stability (安定した強み)
- Keep items that appear consistently → these are established strengths
- Keep items that disappeared → potential regression, worth investigating

### Activity Patterns (from reports if available)
- If reports exist in `~/.claude/kpt-logs/reports/`, cross-reference with activity data
- Identify correlations between activity patterns and problems

## Step 4: Generate Trend Report

Create a structured analysis:

```markdown
# KPT Trend Analysis
Generated: {today's date}
Retrospectives analyzed: N ({earliest date} ~ {latest date})

## Summary
{2-3 sentence overview of the health of the retrospective cycle}

## Chronic Problems (繰り返し出てくる課題)
| Problem | Occurrences | First Seen | Status |
|---------|-------------|------------|--------|
| ...     | N times     | YYYY-MM-DD | ongoing/resolved |

{For each chronic problem, suggest a structural change rather than incremental improvement}

## Improvement Wins (Try → Keep の成功)
- {Try item} → became a Keep by {date}
{Celebrate these — they prove the process works}

## Stale Tries (放置されたTry)
- {Try item} from {date} — never followed up
{Recommend: re-commit, reframe, or explicitly drop}

## Stable Strengths (定着した強み)
- {Keep item} — consistent since {date}

## Recommendations
{3-5 concrete, prioritized actions based on the analysis}
```

## Step 5: Save Report

Save to `~/.claude/kpt-logs/reports/{YYYY-MM-DD}_trends.md`.

Tell the user where it was saved.

## Style
- Write in Japanese
- Be direct and honest — if improvement isn't happening, say so clearly
- Focus on actionable patterns, not just data summaries
- Use specific examples from the retrospectives to support observations
