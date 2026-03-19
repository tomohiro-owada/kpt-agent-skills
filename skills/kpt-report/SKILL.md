---
name: kpt-report
description: "Generate an activity summary report from Claude Code session logs. Use this skill when the user asks for a weekly report, monthly summary, work log, activity digest, what they accomplished, 週報, 月報, 作業ログ, or wants to review what was done over a period — even without mentioning 'report' explicitly."
user-invocable: true
argument-hint: "<period: week | month | YYYY-MM-DD..YYYY-MM-DD>"
---

# Activity Report

Generate a factual activity report from Claude Code session logs. This is a record of what happened, not a retrospective — save opinions for `/kpt`.

## Load Activity Logs

See [log-format.md](../references/log-format.md) for file locations, schema, and period parsing.

Period requested: $ARGUMENTS

## Analyze

Group and categorize filtered entries along three axes:

1. **By Project** — which projects were touched, relative activity volume
2. **By Date** — daily breakdown of work
3. **By Theme** — feature development, bug fixes, refactoring, investigation, documentation, configuration, etc. (infer from message content)

## Generate Report

Use this structure:

```markdown
# Activity Report: {period}
Generated: {today's date}

## Overview
- Period: {start} ~ {end}
- Active days: N
- Projects: {list}
- Sessions: N

## Project Breakdown
### {project name}
- {what was accomplished — concise, deliverable-focused}

## Daily Timeline
### {YYYY-MM-DD}
- {time} [{project}] {what was done}

## Highlights
- {notable accomplishments or decisions}

## Notes
- {patterns: context switching, long sessions, etc. — only if notable}
```

Merge related log entries into coherent summaries rather than listing every single entry. A 50-entry day should become 5-8 bullet points, not 50.

## Save

Save to `~/.claude/kpt-logs/reports/{YYYY-MM-DD}_report_{period}.md`.

Tell the user the saved path.

## Style
- Write in Japanese
- Concise and factual
- Focus on what was accomplished, not how
