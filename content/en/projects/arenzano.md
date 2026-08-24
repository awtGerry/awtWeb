+++
title = "Arenzano Swimwear"
description = "Full-stack swimwear storefront with a guest cart and checkout, mirroring its catalog live from the POS platform; accounts and live payment are shipping this week."
date = 2026-08-19

[taxonomies]
tags = ["rust", "retail"]

[extra]
languages = ["Rust", "Astro", "React", "TypeScript"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo

+++

## Overview

A storefront for Arenzano, a swimwear line sharing the POS platform's catalog. Visitors browse bikinis and accessories with locale-aware (ES/EN) copy, add variant-specific items (size, color) to a cart, and complete checkout (customer info, delivery, payment) to place an order — no account required to shop.

## Architecture

Three tiers, cleanly separated:

- **Go POS** (system of record, external to this repo) owns the real product catalog and inventory.
- **Rust API** (Axum, PostgreSQL via sqlx) mirrors the catalog one-way and read-only, pulling only products flagged for this brand through a scoped, read-only service-account credential — then owns its own tables for carts and orders. REST endpoints: `/products`, `/carts`, `/orders`, `/delivery-options`.
- **Astro + React storefront** hydrates only the interactive pieces (catalog browsing, cart, checkout steps) as islands, styled with Tailwind and backed by nanostores for cart state.

An order moves through an explicit state machine (`pending → confirmed / cancelled`) with a `pos_exported` flag reserved for syncing confirmed orders back to the POS.

## Notable engineering decisions

- **Read-only, brand-scoped catalog mirror.** The storefront can't corrupt POS state even with a bug — it only ever reads through a filtered, brand-scoped service account, never writes back.
- **CI rigor uncommon for a solo storefront.** Beyond the usual fmt/clippy/test gates, the pipeline runs `miri` for undefined-behavior detection and `cargo-deny`/`rustsec` for dependency-vulnerability audits.
- **97 Rust tests**, including Postgres-backed integration tests via testcontainers and end-to-end flows — not just unit tests around pure functions.
- **Built to fail visibly, not silently.** The payment step is an explicit, clearly-labeled test-card flow rather than a half-wired real integration, and pushing orders back to the POS is an explicit logging stub — both flagged in code as exactly what's left to finish, not disguised as done.

## Notes

Private client engagement, part of the same brand family as Monarch Beauty Lab and the POS platform. Catalog browsing, cart, and checkout are live today; user accounts and processed payments are the final pieces landing this week to close out the launch.
