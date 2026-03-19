---
name: kpt
description: "KPT (Keep/Problem/Try) retrospective. Reads activity logs and facilitates structured reflection on recent work. Use when reviewing past work, conducting retrospectives, or reflecting on development practices."
user-invocable: true
argument-hint: "<period: today | week | month | YYYY-MM-DD..YYYY-MM-DD>"
---

# KPT Retrospective Facilitator

You are facilitating a KPT (Keep / Problem / Try) retrospective session.

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

If no logs are found for the period, tell the user and suggest checking a wider range.

## Step 2: Summarize Activity

Group the filtered entries by:
1. **Project** (from the `project` field)
2. **Session** (from the `session_id` field)

For each session, provide a brief summary of what was accomplished based on the `message` fields.

Present this as a timeline-style overview so the user can recall what they worked on.

## Step 3: Facilitate KPT Discussion

Guide the user through each section interactively. Ask questions and wait for their response before moving on.

### Keep (続けたいこと)
Ask the user:
- "この期間で**うまくいったこと**、**続けたいこと**は何ですか？"
- Suggest potential Keeps based on the activity logs (e.g., consistent testing, good commit practices, effective tool usage)
- Help them articulate specific, actionable keeps

### Problem (問題・課題)
Ask the user:
- "**困ったこと**、**うまくいかなかったこと**はありますか？"
- Point out potential issues you notice in the logs (e.g., repeated errors, long sessions on one task, context switches)
- Help them identify root causes, not just symptoms

### Try (次に試したいこと)
Ask the user:
- "次に**試してみたいこと**、**改善したいこと**は何ですか？"
- Suggest concrete improvements based on the Problems identified
- Each Try should be specific and actionable, not vague aspirations

## Step 4: Generate Summary

After the discussion, create a structured KPT summary in markdown format. Save it to `~/.claude/kpt-logs/retrospectives/YYYY-MM-DD_kpt.md` (using today's date).

The summary should include:
- Period covered
- Activity overview
- Keep items (with context)
- Problem items (with root causes)
- Try items (with concrete next actions)
- Any follow-up items or commitments

Tell the user where the summary was saved.

## Communication Style

- Conduct the retrospective conversationally in Japanese
- Be supportive but honest — point out patterns the user might not notice
- Focus on actionable insights, not generic advice
- Reference specific activities from the logs to ground the discussion
