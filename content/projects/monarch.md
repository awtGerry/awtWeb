+++
title = "Monarch Beauty Lab"
description = "Bilingual booking site for a nail salon and spa — services, shade browser, cart, and a multi-step booking checkout."
date = 2026-08-21

[taxonomies]
tags = ["astro", "retail"]

[extra]
role = "Sole developer, responsible for requirements, architecture, frontend, backend, testing, deployment, and maintenance."
languages = ["Astro", "Svelte", "TypeScript", "Tailwind"]
domain = "Retail"
ai_usage = "Hybrid"
status = "Production"
scale = "Production"
type = "Private"
repo = "" # private repo
demo = "https://monarchwellness.mx"

+++

The public site for a spa and nail salon: a marketing homepage, the full service and price menu, a shade browser for nail colors, a cart, and a multi-step checkout — details, staff and time, payment — ending in a confirmed booking. Bilingual EN/ES for a Mexican audience, and it doubles as the in-salon menu behind a QR code.

**How it works**

- Astro for the static shell with Svelte 5 islands for anything interactive, so the marketing pages — most of the traffic — ship no client JavaScript at all.
- A typed client against the retail platform's public API, with idempotency keys on booking creation so a retried request can't double-book a slot.
- The cart survives a refresh without a login, held in a runes-based store in session storage.
- A seeded fallback catalog covers an empty response from the backend, so the menu never renders blank.
- Booking and payments sit behind feature flags, letting the marketing site ship on its own schedule.

Private client work, live in production. It shares its catalog and booking API with the point-of-sale platform that runs the salon's till.
