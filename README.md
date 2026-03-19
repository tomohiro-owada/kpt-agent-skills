# kpt-hooks

Claude Code の Hooks と Skills を使った KPT（Keep / Problem / Try）振り返りフレームワークの自動化ツール。

普段通り Claude Code を使うだけでアクティビティログが自動的に蓄積され、専用スキルで振り返りができます。

## Features

- **自動ログ記録** — `Stop` hook により、Claude Code の応答ごとにアクティビティを JSONL に記録
- **月次ローテーション** — ログは `activity_YYYY-MM.jsonl` として月ごとに自動分割
- **3つのスキル**:
  - `/kpt` — 対話的な KPT 振り返りセッション
  - `/kpt-report` — 期間指定の活動レポート生成
  - `/kpt-trends` — 過去の KPT 結果の傾向分析

## Install

### Plugin として（推奨）

Claude Code の対話画面で:

```
/plugin install tomohiro-owada/kpt-hooks
```

Hook と Skills が自動的に登録されます。手動の設定は不要です。

### 手動インストール

```bash
git clone https://github.com/tomohiro-owada/kpt-hooks.git
cd kpt-hooks
./install.sh
```

インストーラが以下を配置します:

| File | Destination |
|------|-------------|
| `hooks/on-stop.sh` | `~/.claude/hooks/on-stop.sh` |
| `skills/kpt/SKILL.md` | `~/.claude/skills/kpt/SKILL.md` |
| `skills/kpt-report/SKILL.md` | `~/.claude/skills/kpt-report/SKILL.md` |
| `skills/kpt-trends/SKILL.md` | `~/.claude/skills/kpt-trends/SKILL.md` |

`~/.claude/settings.json` の `hooks.Stop` に以下を追加してください:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/on-stop.sh"
          }
        ]
      }
    ]
  }
}
```

## Usage

Plugin インストールの場合はスキル名に名前空間がつきます:

```
/kpt-hooks:kpt today                     # 今日の振り返り
/kpt-hooks:kpt week                      # 直近1週間の振り返り
/kpt-hooks:kpt month                     # 直近1ヶ月の振り返り
/kpt-hooks:kpt 2026-03-01..2026-03-20   # 期間指定の振り返り

/kpt-hooks:kpt-report week               # 週次活動レポート
/kpt-hooks:kpt-report month              # 月次活動レポート

/kpt-hooks:kpt-trends                    # KPT傾向分析（全期間）
/kpt-hooks:kpt-trends 5                  # 直近5回分のKPTを分析
```

手動インストールの場合は名前空間なし (`/kpt`, `/kpt-report`, `/kpt-trends`)。

## Data

ログと振り返り結果は `~/.claude/kpt-logs/` に保存されます:

```
~/.claude/kpt-logs/
├── activity_2026-03.jsonl      # 月次アクティビティログ
├── retrospectives/             # KPT振り返り結果
│   └── 2026-03-20_kpt.md
└── reports/                    # 活動レポート
    └── 2026-03-20_report_week.md
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- `jq` (hook script で使用)

## License

MIT
