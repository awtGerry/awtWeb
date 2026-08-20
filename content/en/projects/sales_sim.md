+++
title = "Sales Simulator"
description = "A desktop + web app sales-and-margin simulator for a produce-export company: per-SKU worksheet, named scenarios, side-by-side comparison, and Excel-numeric parity."
date = 2026-01-27

# Taxonomy tags (for filtering)
[taxonomies]
tags = ["python", "finance"]

# Extra fields — custom data for your templates
[extra]
languages = ["Python", "TypeScript", "Svelte"]
domain = "Finance"
ai_usage = "AI-free"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo
+++

## Overview

A sales-and-margin simulator that replaces a 15 MB, 17-sheet Excel workbook used to plan weekly pricing and forecast profitability for a produce-export business. The original spreadsheet had no state persistence, was easy to break by editing a single formula cell, and forced operators to copy-paste between sheets to compare scenarios.

The app mirrors the workbook's three core views behind protected backend logic, adds named scenarios with side-by-side comparison, and exports to PDF / CSV / TXT.

## Architecture

Two repositories, one deliverable.

- **Desktop + web frontend** (SvelteKit + Svelte 5, TypeScript) packaged as a Tauri 2 app. Runs as a desktop binary with auto-update, and as a static web build. UI decouples derived math from rendering: a pure-TS client engine ports the Excel formulas using `decimal.js-light` for all money, recomputes live as parameters change, and logs divergences against server values instead of masking them.
- **Backend** (FastAPI + SQLAlchemy 1.4 + PostgreSQL) deployed on Railway. Alembic-migrated schema. The financial engine is vectorized with pandas, with `Decimal` rounding applied only at the serialization boundary (round-half-up, pinned). A global in-process "data epoch" cache invalidates reads on any mutation; GZip + a single `/bootstrap` endpoint cut startup from five round trips to one. Migrations are inspect-guarded and reversible so the same revision is safe on a fresh install and on a live production DB.
- **Data ingestion**: the original Excel workbook is imported via `openpyxl` into normalized Postgres tables (premisas, concentrado, FX, prices, clients, products, seasons, semanas); a single xlsx import threads through the data-epoch bump.
- **Parity discipline**: `pytest` golden-value tests assert that the app reproduces the Excel's computed numbers (abs ≤ 0.01 currency, rel ≤ 1e-6 ratios) against (1) a hand-written reference implementation, (2) real workbook raw inputs, and (3) LibreOffice-recalculated true-Excel outputs. A characterization test guards the legacy `/simular` endpoint byte-for-byte on structure while alive during the vectorization refactor.

## Notable engineering decisions

- **Numbers are the spec, not the code.** The Excel is the judge; correctness is proven, not claimed. Migration and vectorization both ship behind characterization tests written before the change.
- **Decimal-safe money end-to-end.** Server and client use the same explicit rounding (ROUND_HALF_UP) and full-precision intermediates; the frontend never `parseFloat`s money. Existing view formatters are left untouched, the worksheet uses its own Decimal display helper.
- **Fail-closed migrations.** The one backfill that touches production premisas refuses to guess a target season: it requires a single active temporada or an explicit env var, audited both ways. State-aware downgrade only drops what the revision created.
- **Data ownership surfaced in copy.** Per-week market notes are shared across the team; manual simulation overrides can be saved per scenario. Both facts are stated in one line of UI text next to the relevant control.

## Notes

Private engagement for a single client. No public repo or live demo; client name and figures withheld intentionally.
