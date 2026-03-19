---
name: kpt-report
description: "Generate an activity summary report from Claude Code session logs. Use for weekly/monthly reports or when reviewing what was accomplished over a period."
user-invocable: true
argument-hint: "<period: week | month | YYYY-MM-DD..YYYY-MM-DD>"
---

# Activity Report Generator

You are generating a structured activity report from Claude Code session logs.

## Step 1: Load Activity Logs

Activity logs are stored as monthly files at `~/.claude/kpt-logs/activity_YYYY-MM.jsonl` (e.g., `activity_2026-03.jsonl`).

Based on the requested period, determine which monthly files to read. For example, `week` might span two months. Read all relevant monthly files by globbing `~/.claude/kpt-logs/activity_*.jsonl`.

The user specified this period: $ARGUMENTS

Interpret the period argument:
- `today` or empty → today's date only
- `yesterday` → yesterday's date only
- `week` → last 7 days
- `month` → last 30 days
- `YYYY-MM-DD` → that specific date
- `YYYY-MM-DD..YYYY-MM-DD` → date range (inclusive)

Filter the JSONL entries by `local_date` field to match the requested period.

If no logs are found, tell the user and suggest a wider range.

## Step 2: Analyze and Categorize

Group and analyze the filtered entries:

1. **By Project** — which projects were worked on, how much activity each had
2. **By Date** — daily breakdown of what was done
3. **By Theme** — categorize activities (e.g., feature development, bug fixes, refactoring, investigation, documentation, configuration)

## Step 3: Generate Report

Create a structured markdown report with the following sections:

```markdown
# Activity Report: {period}
Generated: {today's date}

## Overview
- Period: {start} ~ {end}
- Active days: N
- Projects touched: list
- Total sessions: N

## Project Breakdown
### {project name}
- {concise summary of what was accomplished}
- {key deliverables or milestones}

## Daily Timeline
### {YYYY-MM-DD}
- {time} {project}: {what was done}

## Highlights
- Notable accomplishments
- Significant decisions made

## Notes
- Any patterns observed (e.g., context switching, long sessions)
```

## Step 4: Save Report

Save the report to `~/.claude/kpt-logs/reports/{YYYY-MM-DD}_report_{period}.md` using today's date.

Tell the user where it was saved.

## Style
- Write the report in Japanese
- Be concise and factual — this is a record, not a retrospective
- Focus on what was accomplished, not how
- Group related activities together rather than listing every single log entry
