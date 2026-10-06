+++
title = "NixOS Configuration"
description = "A flake-based NixOS setup driving three machines — desktop, laptop, and a headless server — from one repo."
date = 2026-08-19

[taxonomies]
tags = ["nix", "devops"]

[extra]
languages = ["Nix"]
domain = "Systems"
ai_usage = "AI-free"
status = "Active"
scale = "Active"
type = "Open Source"
repo = "https://github.com/awtGerry/home-cfg"
demo = ""

+++

One flake, three machines with very different jobs: a Hyprland desktop that also hosts coding agents, a DWM laptop tuned for battery life, and a headless server doing zram, LVM thin provisioning, and distributed builds. I've run it as my daily driver for close to three years.

**How it works**

- `flake-parts` composes modular `parts/*.nix` files instead of one monolithic flake.
- Adding a machine means dropping in three files by naming convention — `nixos/configurations/<host>.nix`, `bootloader/<host>.nix`, `hardware/<host>.nix` — not extending a switch statement.
- Hosts opt into named profiles (`activeProfiles = ["dev" "gaming"]`) rather than flipping every module's `enable` flag one at a time.
- `sops-nix` scopes secrets per host by age key, so the key that unlocks the server can't decrypt the desktop.

There's an ADR in there too, laying out the Tailscale + tmux + git-worktree agent host with the alternatives I rejected (Mosh, headscale, Syncthing) written down rather than forgotten. Validated by daily use across three machines instead of by a test suite.
