+++
title = "La Tropicana POS"
description = "An Android POS app for a fictional bar — table login, a browsable menu, a running tab, and checkout — a two-person university project."
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

## Overview

A native Android app for a fictional bar. Customers log in by table, browse a food/drink menu, build a cart, check a running tab, and "pay" to close it out with a confirmation notification. A separate employee login opens a management-side menu. Built as a two-person university mobile-development project — the direct predecessor, in spirit, to the production point-of-sale work that came later.

## Architecture

A single Android module (Java, SQLite via SQLiteOpenHelper for the product catalog, SharedPreferences for cart/tab state) with multiple Activities and Fragments, and a RecyclerView/adapter pattern for menu and cart lists. Everything is local to the device — no backend, no sync between the customer and employee views.

## Notable engineering decisions

First working exposure to the pieces a real POS needs — CRUD against a local database, multi-screen navigation, a cart/tab model, and basic map/QR integrations — built and shipped end-to-end by a two-person team on a course deadline rather than left half-done.

## Notes

Open source, a course project (Ceti Colomos) built with a teammate; hardcoded demo credentials and no server sync are intentional simplifications for the assignment's scope, not oversights.
