+++
title = "Baseball Analytics"
description = "Five MLB seasons, a walk-rate hypothesis that didn't survive contact with the data, and a playoff classifier."
date = 2024-12-18

[taxonomies]
tags = ["python", "sports"]

[extra]
languages = ["Python"]
domain = "Sports Analytics"
ai_usage = "AI-free"
status = "Archived"
scale = "Archived"
type = "Open Source"
repo = "https://github.com/awtGerry/baseball-da"
demo = ""

+++

I took five MLB seasons (2019–2023) from the Lahman database and built the advanced stats — OBP, SLG, OPS, BB%, ISO, WHIP, ERA, K/9, DER — out of raw team box scores, to ask whether walk rate predicts run production.

It doesn't. Walk rate barely correlated with team success (≈ -0.07), while OPS (≈ 0.80) and runs per game (≈ 0.74) ran away with it. The writeup says so plainly instead of quietly reframing the question. OPS beating plain batting average was the one hypothesis that did hold up.

**How it works**

- A notebook pipeline over pandas and numpy: collect → clean → analyze → model.
- A `RandomForestClassifier` on the engineered stats predicts a playoff berth, with the trained model and a small inference script committed alongside.
- Findings also exported to a PowerBI dashboard and a slide deck.

Open source, and finished by design — a scoped analysis, not a tool I meant to keep growing.
