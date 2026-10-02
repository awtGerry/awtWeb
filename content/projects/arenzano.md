+++
title = "Arenzano Swimwear"
description = "An online swimwear store — browse, cart, checkout, no account needed — on a Rust API that mirrors its catalog from the platform running the business."
date = 2026-08-19

[taxonomies]
tags = ["rust", "retail"]

[extra]
role = "Sole developer, responsible for requirements, architecture, frontend, backend, testing, deployment, and maintenance."
languages = ["Rust", "Astro", "React", "TypeScript"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo

+++

An online store for a swimwear brand. Browse the collection in Spanish or English, pick a size and color, check out. No account needed to shop.

The interesting part is that it doesn't own its catalog. Products mirror one-way and read-only from the retail platform that already runs the business, so a bug in the storefront can't corrupt real inventory. Everything after that — cart, orders — is its own.

**How it works**

- Rust (Axum) API on PostgreSQL. Orders move through an explicit state machine rather than a pile of boolean flags, so placed → fulfilled stays auditable.
- Astro storefront that hydrates only the interactive parts — catalog, cart, checkout — as React islands.
- CI runs undefined-behavior detection and dependency audits, and the tests hit a real Postgres in ephemeral containers instead of mocking it away.

Private client work, part of the same family as the point-of-sale platform. No public repo or demo.
