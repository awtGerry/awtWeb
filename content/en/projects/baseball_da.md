+++
title = "Baseball Analytics"
description = "A team-level MLB analytics project: engineered sabermetric stats from box-score data, tested a walk-rate hypothesis, and trained a playoff classifier."
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

## Overview

Analyzed five MLB seasons (2019–2023) from the Lahman Baseball Database, engineering advanced stats — OBP, SLG, OPS, BB%, ISO, WHIP, ERA, K/9, DER — from raw team box-score columns. Tested whether walk rate predicts run production, compared OPS against plain batting average as a predictor of team success, and looked at pitching (WHIP) against making the playoffs, then trained a classifier to predict a playoff berth from the engineered stats.

## Architecture

A notebook-based pipeline (collection → cleaning → analysis → modeling) over pandas/numpy, with a `RandomForestClassifier` (scaled features, 80/20 split) as the final model. Trained artifacts and a small standalone inference script are committed alongside the notebooks. Findings were also exported to a PowerBI dashboard and a slide deck.

## Notable findings

- The headline hypothesis didn't hold up: walk rate alone correlated weakly with team success (≈ -0.07), while OPS (≈ 0.80) and runs/game (≈ 0.74) were far stronger predictors — the data disagreed with the starting assumption, and the writeup says so directly.
- OPS beat batting average as a predictor of winning, matching the secondary hypothesis.

## Notes

Open source, and considered finished by design — a scoped, self-contained analysis rather than an ongoing tool.
