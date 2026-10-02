+++
title = "School Roster"
description = "A desktop app that builds school timetables with a from-scratch backtracking scheduler."
date = 2026-08-17

[taxonomies]
tags = ["rust", "education"]

[extra]
languages = ["Rust", "Svelte", "TypeScript"]
domain = "Education"
ai_usage = "AI-free"
status = "Production"
scale = "Production"
type = "Open Source"
repo = "https://github.com/School-Roster/school_roster.app"
demo = ""

+++

A desktop tool for school administrators to build class timetables — subject, teacher, time block, and classroom for every student group, with nothing double-booked.

The core is a hand-written depth-first backtracking search. It takes the most constrained requirement first, explores contiguous blocks, days, and teachers, and checks classroom feasibility with deterministic bipartite matching rather than treating rooms as another search dimension — which is what keeps it from blowing up combinatorially. It also separates "no valid schedule exists" from "the search budget ran out," because those mean very different things to the person waiting on it.

**How it works**

- Tauri wrapping a Rust backend and a SvelteKit frontend, SQLite via `sqlx`, plus a custom `.roster` format, Excel import, and PDF export.
- The scheduling engine lives in its own module — `engine`, `constraints`, `scorer`, `types` — after a refactor out of one function that mixed heuristics, scoring, and persistence together.
- Drag-and-drop grid editing with full undo/redo on top of the generated schedule, so a human can always overrule the solver.

Open source with outside contributors, released through v1.0.1 on an automated cross-platform pipeline. v2.0 — Tauri v2, a rewritten engine, mobile support — is in progress against a public roadmap.
