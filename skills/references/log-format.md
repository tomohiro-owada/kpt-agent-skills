# Activity Log Format

## File Location & Naming

Logs are stored at `~/.claude/kpt-logs/` with monthly rotation:

```
~/.claude/kpt-logs/
├── activity_2026-01.jsonl
├── activity_2026-02.jsonl
├── activity_2026-03.jsonl    # current month
├── retrospectives/           # KPT session outputs
│   └── YYYY-MM-DD_kpt.md
└── reports/                  # report & trend outputs
    └── YYYY-MM-DD_report_*.md
```

## JSONL Entry Schema

Each line in `activity_YYYY-MM.jsonl` is:

```json
{
  "timestamp": "2026-03-20T10:30:00Z",
  "local_date": "2026-03-20",
  "local_time": "19:30:00",
  "session_id": "abc-123",
  "cwd": "/Users/name/projects/foo",
  "project": "foo",
  "message": "Claude's response text (truncated to 500 chars)"
}
```

## Period Argument Parsing

The user passes a period argument. Interpret it as:

| Argument | Meaning |
|----------|---------|
| (empty) or `today` | Today's date only |
| `yesterday` | Yesterday only |
| `week` | Last 7 days |
| `month` | Last 30 days |
| `YYYY-MM-DD` | Specific date |
| `YYYY-MM-DD..YYYY-MM-DD` | Date range (inclusive) |

## How to Load Logs

1. Determine which months are covered by the requested period
2. Read the relevant `activity_YYYY-MM.jsonl` files (a `week` period near month boundaries may need two files)
3. Filter entries where `local_date` falls within the period
4. If no entries match, tell the user and suggest a wider range
