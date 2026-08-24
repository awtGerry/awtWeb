+++
title = "Monarch Beauty Lab"
description = "Bilingual booking site for a nail salon and spa — service menu, shade browser, cart, and checkout, reading its catalog live from the POS platform's public API."
date = 2026-08-21

[taxonomies]
tags = ["astro", "retail"]

[extra]
languages = ["Astro", "Svelte", "TypeScript", "Tailwind"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "https://monarchwellness.mx"

+++

## Overview

The public-facing site for Monarch, a spa and nail salon: a marketing homepage, a full services/pricing menu with a shade-browsing "carte" experience for nail colors, a cart, and a multi-step checkout (customer details, staff/time selection, payment) ending in a booking confirmation. Bilingual (EN/ES) for a Mexican audience, and built to double as an in-salon QR-accessible menu.

## Architecture

- **Astro** for the static shell, with **Svelte 5** islands for anything interactive (menu, cart, checkout) — most of the page ships as static HTML, only the parts that need to react hydrate.
- **Typed API client** talking to the POS platform's public REST API (`/api/v1/public/content|services|availability|bookings`) — typed error classes for timeout vs. network vs. API errors, request timeouts, and idempotency keys on booking creation so a retried request can't double-book a slot.
- **Payments** via Mercado Pago, currently redirect-based; an inline card-payment flow is designed but on hold.
- **Deployed on Railway** as a static build with a health-checked deployment.
- **Fallback catalog**: a seeded local catalog covers the case where the live backend returns an empty menu, so the site never renders blank.

## Notable engineering decisions

- **Progressive enhancement over a heavy SPA.** Astro's island model means the marketing pages — the majority of traffic — ship zero client JS; only cart/checkout hydrate.
- **A cart that survives a refresh without a login.** A Svelte 5 runes-based cart store persisted to `sessionStorage` — no account required to browse or start a booking.
- **Accessibility and design as first-class docs.** A written design system and product brief target WCAG 2.1 AA, not just default-framework accessibility.
- **A feature flag protects the storefront.** Checkout is gated behind an environment flag, so the marketing site can ship independently of the payment flow going live.

## Notes

Private client engagement; live in production at monarchwellness.mx. Shares its backend catalog and booking API with the POS platform that runs the salon's till.
