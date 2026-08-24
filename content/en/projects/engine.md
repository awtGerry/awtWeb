+++
title = "Graphics Engine"
description = "A 2D/3D rendering engine written from scratch in Rust on raw OpenGL, implementing classic computer-graphics algorithms across three working demo scenes."
date = 2024-05-08

[taxonomies]
tags = ["rust", "graphics"]

[extra]
languages = ["Rust"]
domain = "Graphics"
ai_usage = "AI-free"
status = "Archived"
scale = "Archived"
type = "Open Source"
repo = "https://github.com/awtGerry/engine"
demo = ""

+++

## Overview

A computer-graphics engine for a university course, built directly on raw OpenGL rather than a game-engine crate — the point was implementing the classic rasterization algorithms, not wrapping a scene graph. Includes Bresenham and DDA line drawing, midpoint-circle, scanline and flood-fill polygon/circle/ellipse fill, parametric curve plotting (Lissajous, rose, Bezier-style curves), 2D transformations, and a small shader abstraction — exercised through three complete demos: an animated Pacman-style scene, a 3D pool-table animation, and a textured analog clock.

## Architecture

A library crate exposing a `graphics` module (window/context handling over GLFW, shader compilation with a uniform-location cache, thin RAII wrappers over VAOs/buffers/vertices) and an `algorithms` module with one file per technique. Three demo binaries consume the library independently, each organized by domain concept — the pool demo, for instance, splits ball/cue/animation into their own files.

## Notable engineering decisions

A deliberate hybrid of per-pixel software rasterization — for teaching the underlying algorithm — and true GPU-drawn triangles in the same engine, rather than picking one rendering path throughout. Manual, unsafe OpenGL calls are kept behind small safe-ish wrapper types instead of scattered through demo code.

## Notes

Open source, a single-semester course project (Sep 2023 – May 2024) — finished and not maintained since, with 12 runnable examples on top of the three full demos.
