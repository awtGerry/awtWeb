+++
title = "La Tropicana POS"
description = "An Android POS app for a fictional bar — table login, menu, running tab, checkout. A two-person university project."
date = 2023-12-06

[taxonomies]
tags = ["java", "mobile"]

[extra]
languages = ["Java"]
domain = "Retail"
ai_usage = "AI-free"
status = "Archived"
scale = "Archived"
type = "Open Source"
repo = "https://github.com/ocurrentduke1/LaTropicana"
demo = ""

+++

A native Android app for a fictional bar. Customers log in by table, browse the food and drink menu, build a cart, check their running tab, and "pay" to close it out with a confirmation. A separate employee login opens the management side. A teammate and I built it for a mobile-development course.

**How it works**

- One Android module in Java: SQLite for the catalog, SharedPreferences for cart and tab state, Activities and Fragments with RecyclerView adapters for the lists.
- Everything lives on the device — no backend, no sync between the customer and employee views.

The hardcoded demo credentials and the missing server are scope decisions for the assignment, not things we forgot. In spirit it's the ancestor of the production point-of-sale work that came later: the first time I put a cart, a tab, and CRUD against a real database together end to end.

Open source, built with a teammate at Ceti Colomos.
