# CLAUDE.md

Thinking & Wind-down App. Personal Flutter app for calibrated decisions and a clean end to the work day. Spec version: v1 (30 Sept 2026).

## Project status

- v1 implemented: schema (13 tables), repositories, all screens, backup, password gate, stats, Pages workflow.
- Tested: unit tests for stats, rules and all repositories (in-memory drift DB); web build smoke-tested in headless Chromium (database opens, data persists across reload).
- Not yet done: Android APK build and install (no Android SDK in the dev container), release keystore creation, first Pages deploy (verify `sqlite3.wasm` content type), phone testing.
- Generated `lib/data/database.g.dart` is committed. Regenerate after any table change.

## Targets

| Target | Use | Distribution |
|---|---|---|
| Web | Beta | GitHub Pages, opened in the phone's browser, added to home screen |
| Android | Release | `flutter build apk --release`, installed manually on one phone |

One codebase. All data stays in the browser (beta) or on the phone (release).

## Tech stack

| Layer | Choice | Notes |
|---|---|---|
| Framework | Flutter | web + Android |
| State | Riverpod | |
| Database | SQLite via drift | Typed queries, migrations. Web uses WebAssembly. |
| Charts | fl_chart | Calibration chart, Brier trend |
| Export | share_plus | Android: share sheet. Web: file download. |
| Import | file_picker | Restores backup |

## Scope

- v1 (this spec): predictions, decision journal, decide early (day plan), shutdown, wind-down, stats, JSON backup.
- Out of scope for v1:
  - Notifications or reminders
  - In-app lock on Android (web beta has a password gate only)
  - Sync or any backend
  - AI features inside the app
  - Skill drills (v2) and work sessions (v3)
- Leave room in structure for v2 (drills loaded from JSON content files) and v3 (focus timer, PR checklist). Do not build them.

## Project structure

```
lib/
  data/                drift database, table definitions, one repository per record type
  platform/            target-specific code via conditional imports
                         - database connection (native file / WebAssembly)
                         - backup export (share sheet / download)
                         - password gate (web only)
  features/
    today/             Today screen, morning and evening sections
    predictions/       list, add/edit, resolve
    journal/           list, add/edit, review
    stats/             calibration chart, scores, counts
    settings/          backup, wind-down editor, tag management
  core/                shared widgets, theme, date helpers
```

Rules:
- Shared code imports only `package:drift/drift.dart`. Web and native drift libraries are imported only in `lib/platform/`.
- Bottom nav destinations: Today, Predictions, Journal, Stats, Settings.

## Data model

Thirteen drift tables. Every table has integer `id` primary key plus `createdAt` / `updatedAt`. Dates without time are `yyyy-MM-dd` text.

| Table | Fields |
|---|---|
| tags | name (unique) |
| predictions | statement, confidence (int %), resolveBy, tagId?, outcome? (true/false/void; null = open), resolvedAt?, journalEntryId? |
| prediction_date_changes | predictionId, oldDate, newDate |
| journal_entries | decision, context?, choiceOptionId?, reasoning, expectedOutcome, confidence (int %), tagId?, reviewDate |
| journal_options | entryId, text, sortOrder |
| journal_reviews | entryId (unique), whatHappened, reasoningScore (1-5), lessons?, reviewedAt |
| day_plans | date (unique) |
| day_plan_tasks | dayPlanId, text, done, sortOrder (max 3 per plan) |
| day_plan_defaults | dayPlanId, label, choice, sortOrder |
| open_loops | text, openedOn, closedOn? (null = open), sourceTaskId? |
| shutdowns | date (unique), firstStep, closedAt? |
| winddown_steps | name, minutes?, sortOrder |
| winddown_runs | date, startedAt, completedStepNames (JSON text) |

- Today's Morning/Evening selection: small key-value settings table or `shared_preferences`, whichever is simpler.
- Every table change increments drift `schemaVersion` and adds a migration step.

## Business rules

### Predictions
- Yes/no statement, confidence, resolve-by date. Tag optional.
- Confidence: 50-95 in steps of 5, plus 99. Default 70.
- Resolve-by date must be today or later at creation.
- Due: resolve-by on or before today and still open.
- Resolve: True, False, Void. Early resolution allowed. Reopen allowed.
- Void is excluded from all stats.
- Statement and tag always editable. Confidence locked 24 h after creation.
- Resolve-by date can be extended; each extension is a `prediction_date_changes` row.

### Decision journal
- Required: decision (one line), at least 2 options, choice, reasoning, expected outcome, confidence.
- Optional: context, tag. Review date defaults to 1 month after creation, editable.
- "Add as prediction" toggle (default off) creates a linked prediction from expected outcome, confidence, review date.
- Review: whatHappened (required), reasoningScore 1-5 (required), lessons (optional). If linked prediction is still open, the review also asks for its outcome.
- Review date can be postponed; entry stays Open until then.
- Reasoning and confidence lock 24 h after creation. Other fields editable until review completes. Completed reviews are editable.

### Day plan (decide early)
- One plan per date; editing replaces it.
- Up to 3 tasks with done checkbox. Evening defaults are label/choice pairs; labels remembered as quick picks.
- Created from Evening for tomorrow, or from Morning for today if none exists.
- Unticked tasks become suggested open loops in that evening's shutdown.

### Shutdown and wind-down
- One shutdown per date; reopenable and editable that day.
- Steps: open loops (tick, delete, accept suggestions, add), tomorrow's first step (required to close), close work (records time, then offers wind-down).
- Open loops carry forward until ticked or deleted; show days open.
- Wind-down: ordered steps (name, optional minutes) defined in Settings. Run screen shows one step at a time with timer if set and Next, nothing else. Timed steps can finish early or extend by 5 min.
- Each run logs date and completed step names as text. Leaving early logs progress so far.

### Stats
- Use resolved (True/False) predictions only. Filter by tag and period (30 d, 90 d, all time).
- Brier score: BS = (1/N) * sum((p - o)^2), p = confidence decimal, o = 1 for True, 0 for False. Show single number plus monthly line chart. 50% always scores 0.25.
- Calibration chart: bands 50-59, 60-69, 70-79, 80-89, 90-99. Y = % that came true, plotted at band's average stated confidence, with diagonal reference line and count per band. Bands with fewer than 5 are greyed out.
- Counts: open, due, resolved (True/False), void.
- Journal stats: entries created, reviews completed, reviews overdue, average reasoning score, reasoning score vs outcome count table (outcome from linked prediction where one exists).

### Backup
- Export: all tables to one JSON file with `schemaVersion` and export timestamp. Android share sheet; web download.
- Import: pick file, show record count summary, confirm, replace all data. Auto-export current data first. Reject files with a newer `schemaVersion` than the app supports.
- Settings shows last export date.

## Web beta specifics

- GitHub Actions on push to `main`: `flutter build web --release --base-href /<repo-name>/`, deploy `build/web` to Pages.
- Public repo. No personal data in the repo.
- Password gate (web only, not in Android build): SHA-256 hash compiled into the app; correct entry remembered in that browser. Casual-visitor deterrent only.
- drift web needs `sqlite3.wasm` and the drift web worker in `web/`, both from the same drift release. Use `WasmDatabase.open`.
- GitHub Pages cannot set COOP/COEP headers, so storage is not safe across multiple tabs. Accepted for beta.
- `web/sqlite3.wasm` is committed (from the sqlite3.dart 3.5.2 release). `web/drift_worker.js` is compiled from `web/drift_worker.dart` with `dart compile js -O4 web/drift_worker.dart -o web/drift_worker.js`; CI rebuilds it. Keep both in step with the drift/sqlite3 versions in `pubspec.lock`.
- Password gate hash is set with `--dart-define=GATE_HASH=<sha256 hex>` (CI reads the repo variable `GATE_HASH`). Empty disables the gate.
- Verify on first Pages deploy that `sqlite3.wasm` is served as `application/wasm`.

## Android release

- Create one release keystore at the start; sign every build with it. Keep it and its passwords outside the repo. Never commit keystore or `key.properties`.
- `android/app/build.gradle.kts` reads `android/key.properties` (storeFile, storePassword, keyAlias, keyPassword). Without it the release build falls back to the debug key and prints a warning; do not install such a build over real data.
- A different signing key forces uninstall and deletes all data.
- Export a backup before installing a version with a schema change.
- After beta, check web-vs-Android differences: back button, keyboard, file import/export, resume from background.

## Commands

```
flutter pub get
dart run build_runner build   # drift codegen
flutter analyze
flutter test
flutter run -d chrome
flutter build web --release --base-href /<repo-name>/
flutter build apk --release
```

## Conventions

- Use repositories for all DB access; widgets use Riverpod providers, not the database directly.
- Table columns named `text` are exposed as `body` in Dart (`.named('text')`) because `text` clashes with drift's column builder.
- Riverpod 3: use `AsyncValue.value`, not `valueOrNull`.
- Date helpers live in `lib/core/`; use `yyyy-MM-dd` strings for date-only values.
- Put every target difference behind a conditional import in `lib/platform/`.
- Write unit tests for stats math (Brier, bands), 24 h lock logic, due-date logic, and backup import/export round trip.

## Open questions (proposed rules in spec, unconfirmed)

- [ ] Lock prediction confidence and journal reasoning/confidence 24 h after creation
- [ ] Default prediction confidence 70%
- [ ] Wind-down extension of 5 minutes
- [ ] 10% calibration bands, greyed out below 5 predictions
- [ ] Web password gate: remember permanently or ask each session
- [ ] Repo name for the Pages URL
