+++
title = "Point of Sale"
description = "A multi-tenant point-of-sale platform running in production for two independent retail businesses, evolving from a single-store POS into a full retail ERP with inventory, staff, and payroll."
date = 2026-08-22

# Taxonomy tags (for filtering)
[taxonomies]
tags = ["go", "retail"]

# Extra fields — custom data for your templates
[extra]
languages = ["Go", "TypeScript", "Vue"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo

+++

## Overview

A point-of-sale platform handling real money for two independent small businesses from a single codebase: a raspados/aguas frescas counter shop and a spa with boutique retail. Staff take orders on tablets, take payment in cash or by card, and close out the till at the end of the day; owners track inventory and staff commissions from the same system. It replaced manual, paper-based order-taking and cash reconciliation, and speaks Mexican government tax invoicing natively.

The two businesses run as separate deployments of the same image, switched at boot by a business-kind flag — one codebase, two live storefronts, each with its own database and domain.

## Architecture

One repository, one deliverable per business.

- **Backend**: Go, Chi router, PostgreSQL via pgx, golang-migrate for schema versioning, JWT auth, Zap logging, a WebSocket hub for live order/kitchen updates, AWS S3 for asset storage, and PDF/Excel export (fpdf, excelize).
- **Frontend**: Vue 3 + TypeScript, Vite, Pinia, TanStack Query, Tailwind CSS — built and embedded directly into the Go binary via `go:embed`, so each deployment ships as a single container serving both the API and the static app.
- **Multi-tenancy by deployment**: a business-kind module registry gates features at three layers — middleware, route, and frontend router — so the same binary runs as either storefront without a recompile.
- **Domain packages**: inventory, purchasing, payroll, commissions, checkout, cashbox posting, CFDI (tax), PAC gateway, WebSocket hub, transactional outbox, payment gateway, notifications — each isolated behind its own package boundary.
- **Reproducible builds**: a Nix flake pins the Go/Node toolchain (`gomod2nix`, `nix flake check` in CI), backing a multi-stage Docker build (Node → Go → Alpine).
- **Testing**: 144 Go test files plus an 18-spec Playwright suite exercising the frontend end to end.

## Notable engineering decisions

- **Real tax compliance, not a toy invoice.** Mexican CFDI electronic invoicing is wired through a PAC integration (Finkok) — actual government-facing tax documents, not a mocked receipt.
- **Physical hardware in the loop.** A barcode scanner drives stock receiving and counts; a thermal label printer is deliberately USB-bound to the till — printing has to originate from the machine physically at the register, not over the network.
- **Money moves through a ledger, not a running total.** Cash-cut/cashbox reconciliation, drawer transfers, refunds, and courtesy discounts all post through an idempotent ledger rather than mutating a balance in place.
- **Reliability via outbox, not retries-and-hope.** A transactional outbox pattern queues async side effects so a crash mid-request can't silently drop an event.
- **Growing into an ERP without a rewrite.** Inventory and staff commissions are landing as first-class modules on a feature branch before merging to master, with payroll next — the same system that runs the till is becoming the backend that public storefronts (see Monarch Beauty Lab) read from over a public API, instead of forking into a second codebase.

## Notes

Private engagement, live in production for both businesses. No public repo or demo — client names and financial figures withheld intentionally.
