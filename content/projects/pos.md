+++
title = "Point of Sale"
description = "A multi-tenant point-of-sale platform running in production for two retail businesses from one codebase, growing into a retail ERP."
date = 2026-08-22

# Taxonomy tags (for filtering)
[taxonomies]
tags = ["go", "retail"]

# Extra fields — custom data for your templates
[extra]
role = "Sole developer, responsible for requirements, architecture, frontend, backend, testing, deployment, and maintenance."
languages = ["Go", "TypeScript", "Vue"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "" # private, no demo
screenshot = "images/projects/pos.webp"
screenshot_width = 1440
screenshot_height = 900
screenshot_alt = "The sales screen of the point-of-sale app in its salon configuration: service cards on the left, and on the right a ticket with three services, a retail product, the total and a Charge button."

+++

A point-of-sale platform handling real money in production for two independent small businesses in different retail segments — from a single codebase. Staff take orders on tablets, take cash or card, and close out the till at the end of the day; owners track inventory and staff commissions from the same system. It replaced paper order slips and manual cash reconciliation, and speaks Mexican electronic tax invoicing natively.

Both businesses run as separate deployments of the same image, switched at boot by a business-kind flag: one codebase, two live storefronts, each with its own database and domain.

**How it works**

- Go and PostgreSQL on the backend, with a Vue 3 frontend built and embedded into the Go binary — each deployment ships as one container serving both the API and the app.
- A module registry gates features at middleware, route, and frontend-router level, so the same binary runs as either business without a recompile.
- Money moves through an idempotent ledger — cash reconciliation, drawer transfers, refunds, discounts — instead of mutating a running balance in place.
- A transactional outbox queues async side effects, so a crash mid-request can't quietly drop an event.
- Invoicing goes through a certified provider: real government-facing tax documents, not mocked receipts. Barcode scanning drives stock receiving and counts, and label printing is bound to the machine at the register rather than exposed over the network.

Inventory, purchasing, commissions, and payroll landed as first-class modules on the same platform rather than forking into a second codebase — and the same system backs the public storefronts over its API.

Private client work, live for both businesses. No public repo or demo.
