+++
title = "Graphics Engine"
description = "A 2D/3D renderer written from scratch in Rust on raw OpenGL, to implement the classic graphics algorithms rather than wrap a game engine."
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

A graphics engine for a university course, written straight on raw OpenGL instead of reaching for a game-engine crate — the point was implementing the algorithms, not wrapping a scene graph.

Bresenham and DDA lines, midpoint circles, scanline and flood fill, parametric curves (Lissajous, rose, Bezier-style), 2D transforms, and a small shader abstraction. All of it exercised through three finished demos: an animated Pacman scene, a 3D pool table, and a textured analog clock.

**How it works**

- A library crate splits `graphics` — GLFW window and context, shader compilation with a uniform-location cache, RAII wrappers over VAOs and buffers — from `algorithms`, one file per technique.
- Three demo binaries consume it independently, each organized by domain concept.
- Per-pixel software rasterization and GPU-drawn triangles coexist on purpose: the software path is there to show the algorithm, not because it's fast.

Open source, one semester of work (Sep 2023 – May 2024), finished and left alone since. Twelve runnable examples on top of the three demos.
