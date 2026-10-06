+++
title = "Sales Simulator"
description = "A desktop and web simulator that replaced a fragile pricing spreadsheet for an agricultural exporter — and proves it matches the numbers."
date = 2026-01-27

# Taxonomy tags (for filtering)
[taxonomies]
tags = ["python", "finance"]

# Extra fields — custom data for your templates
[extra]
role = "Sole developer, responsible for requirements, architecture, frontend, backend, testing, deployment, and maintenance."
languages = ["Python", "TypeScript", "Svelte"]
domain = "Finance"
ai_usage = "AI-free"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo
+++

An agricultural export business planned its weekly pricing and margins in a large Excel workbook. It saved no state, broke if you edited the wrong formula cell, and forced people to copy-paste between sheets to compare two scenarios. This replaces it: the same views, the math moved behind a backend, plus named scenarios, side-by-side comparison, and PDF/CSV/TXT export.

**How it works**

- A SvelteKit frontend packaged with Tauri 2 — one codebase shipping as a desktop binary with auto-update and as a static web build.
- FastAPI, SQLAlchemy, and PostgreSQL behind it, with the financial engine vectorized in pandas and decimal rounding applied only at the serialization boundary.
- The client recomputes live as parameters change, uses a decimal library for money end to end, and logs any divergence from server values instead of masking it.
- Golden-value tests assert the app reproduces the spreadsheet's numbers to a pinned tolerance, checked against a hand-written reference implementation and real workbook inputs.

The spreadsheet is the judge here, so correctness is proven rather than claimed. The one migration that touches production data refuses to guess its target: it wants an unambiguous state or an explicit override, and audits either way.

Private client work. No public repo or demo.
