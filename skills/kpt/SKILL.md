---
name: kpt
description: "KPT (Keep/Problem/Try) retrospective that reads Claude Code activity logs and facilitates structured reflection. Use this skill whenever the user mentions retrospective,振り返り, KPT, reflecting on work, reviewing what went well or poorly, or wants to improve their development process — even if they don't explicitly say 'KPT'."
user-invocable: true
argument-hint: "<period: today | week | month | YYYY-MM-DD..YYYY-MM-DD>"
---

# KPT Retrospective

Facilitate a KPT (Keep / Problem / Try) retrospective based on real activity data.

The value of this skill is grounding retrospectives in actual logs rather than fuzzy memory. Reference specific entries when suggesting Keep/Problem items — vague observations aren't useful.

## Load Activity Logs

See [log-format.md](../references/log-format.md) for file locations, schema, and period parsing.

Period requested: $ARGUMENTS

## Summarize Activity

Group filtered entries by **project**, then by **session_id**. Present a timeline-style overview so the user can recall what they worked on. Keep it concise — this is context-setting, not the main event.

## Facilitate KPT — One Section at a Time

This is interactive. Ask one section, wait for the user's response, then move on. Don't rush through all three at once — the pauses are where reflection happens.

### Keep (続けたいこと)

Ask: "この期間で **うまくいったこと**、**続けたいこと** は何ですか？"

Suggest 2-3 potential Keeps you notice in the logs (consistent testing, good commit practices, effective tool usage, smooth project switches). The user may not notice their own good habits — surface them.

### Problem (問題・課題)

Ask: "**困ったこと**、**うまくいかなかったこと** はありますか？"

Look for signals in the logs: repeated errors, unusually long sessions on one task, frequent context switches between projects, sessions that end abruptly. Point these out as conversation starters. Help the user dig into root causes rather than symptoms — ask "why" at least once.

### Try (次に試したいこと)

Ask: "次に **試してみたいこと**、**改善したいこと** は何ですか？"

Each Try should be specific and actionable. "もっとテストを書く" is too vague — "PR作成前に必ずテストを追加する" is better. Suggest concrete Tries that address the Problems identified.

## Save Summary

After the discussion, save a structured KPT summary to `~/.claude/kpt-logs/retrospectives/YYYY-MM-DD_kpt.md` (today's date).

Include: period covered, activity overview, Keep/Problem/Try items with context and concrete next actions.

If a file for today already exists, append a timestamp suffix (e.g., `_kpt_2.md`) to avoid overwriting.

Tell the user the saved path.

## Style

- Conduct in Japanese
- Be supportive but honest — patterns the user doesn't notice are the most valuable observations
- Reference specific log entries, not generic advice
