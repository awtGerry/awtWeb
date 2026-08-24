+++
title = "School Roster"
description = "Desktop app that generates school class timetables with a from-scratch backtracking scheduler — subjects, teachers, and classrooms assigned under real constraints."
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

## Overview

A desktop tool for school administrators to build class timetables — assigning subject, teacher, day/time block, and classroom to each student group so nothing double-books. The core is a hand-written depth-first backtracking search: it explores contiguous time blocks, days, and teachers per requirement using a most-constrained-variable heuristic (fewest valid options first), and checks classroom feasibility at each candidate via deterministic bipartite matching instead of expanding every possible room assignment. It reports infeasibility and "search budget exhausted" as two distinct outcomes rather than one generic failure.

## Architecture

Tauri (migrating v1 → v2) wraps a Rust backend and a SvelteKit/TypeScript frontend. SQLite via `sqlx` handles persistence, alongside a custom `.roster` file format, Excel import, and PDF export for existing schedules. The scheduling engine is isolated as its own module (`scheduling/{engine,constraints,scorer,types}`) after a deliberate refactor out of an earlier single function that mixed heuristics, scoring, persistence, and side effects together. An AI assistant, grounded in the current schedule state, answers scheduling questions. Cross-platform release builds (Windows, macOS Intel/ARM, Linux) ship through an automated release pipeline.

## Notable engineering decisions

- **Room assignment as a feasibility check, not a search dimension.** Matching classrooms via bipartite matching at each candidate slot avoids the combinatorial blowup of enumerating full room plans.
- **A named, budgeted search.** The engine has an explicit work-unit ceiling and documented safety limits (max days, modules/day, groups, classrooms), so "no schedule found" always comes with a concrete reason.
- **Refactor discipline, written down.** An internal architecture review documents replacing a monolithic scheduling function with a decoupled engine/constraints/scorer split — evidence the codebase gets deliberately paid down, not just extended.
- **Drag-and-drop grid editing with full undo/redo** on top of a generated schedule, so a human can always hand-adjust the solver's output.

## Notes

Open source, with outside contributors, and tagged releases through v1.0.1 on an automated cross-platform pipeline. v2.0 is in active development on feature branches — a Tauri v2 migration, a rewritten scheduling engine, and mobile support — against a public roadmap.
