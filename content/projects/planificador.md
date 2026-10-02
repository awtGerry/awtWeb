+++
title = "Planificador"
description = "A weekly task planner that replaced my boss's 2017 Excel workbook, installed as a PWA on his phone."
date = 2026-08-28

[taxonomies]
tags = ["rust", "productivity"]

[extra]
role = "Sole developer, responsible for requirements, architecture, frontend, backend, testing, deployment, and maintenance."
languages = ["Rust", "Vue", "TypeScript"]
domain = "Productivity"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # internal, no demo

+++

My boss had planned his week in the same Excel workbook since 2017: one tab per week, cloned forward, tasks grouped by client, scheduled by typing a weekday beside them. This replaces it — a Spanish-language weekly planner for exactly one person, installed as a PWA on his Apple devices.

Recurring tasks are defined once in a catalog and spawn one occurrence per week; completion lives on the occurrence, so past weeks stay browsable as history. Anything left unfinished carries forward as *atrasada* until it's done or explicitly dismissed.

**How it works**

- Rust (axum + sqlx) over SQLite on a mounted volume, serving the built Vue 3 SPA from the same binary — one container, one origin, and cookie auth stays trivial.
- Weeks materialize lazily on first view, recorded in their own table. No cron job, no pre-generated future.
- A skipped week stays empty rather than catching up: come back from vacation and you get your week, not four weeks of instant backlog.
- Single password, no accounts, no multi-user anything. The app assumes one user and is simpler for it.

The domain vocabulary is Spanish and written down in a glossary, because the terms are his rather than mine — *unidad de negocio*, *plantilla*, *ocurrencia*, *atrasada*. The decisions with real trade-offs are recorded as ADRs, including what got cut: the old workbook was also a capacity planner with minutes per task, and that went on purpose.

Private and internal. No public repo or demo.
