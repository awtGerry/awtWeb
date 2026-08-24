+++
title = "NixOS Configuration"
description = "A flake-based NixOS + home-manager setup unifying three machines — desktop, laptop, and server — with per-host modularity and sops-nix secrets."
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

## Overview

A single flake driving three machines with different jobs: a Hyprland/Wayland desktop (also set up as a host for running coding agents), a DWM/X11 laptop tuned for battery life, and a headless server (zram, LVM thin provisioning, distributed builds). Maintained continuously for close to three years, across daily use as a primary workstation.

## Architecture

- **flake-parts** composes modular `parts/*.nix` files instead of one monolithic flake.
- **Convention-driven hosts**: a custom option schema (`awt.nixosConfigurations`) derives each host's bootloader, hardware, and entry-point files by naming convention — `nixos/configurations/<host>.nix`, `bootloader/<host>.nix`, `hardware/<host>.nix` — instead of hand-wiring every `nixosSystem` call.
- **Profiles, not per-module toggles**: a host opts into named bundles (`activeProfiles = ["dev" "gaming"]`) rather than flipping every module's `enable` individually.
- **sops-nix** encrypts secrets per host by age key, alongside custom packages built into the same flake.

## Notable engineering decisions

- **Convention over configuration for hosts.** Adding a machine means dropping in three files by naming convention, not extending a switch statement.
- **Secrets scoped per host, not repo-wide.** A key that unlocks the server can't decrypt the desktop's secrets.
- **A recorded architecture decision.** An ADR lays out — with rejected alternatives (Mosh, headscale, Syncthing/NFS) explicitly written down — the design for reaching a tmux-and-git-worktree coding-agent host over Tailscale with fail-closed, key-only SSH.
- **Fail-closed by default**, on the server module itself, not just as a documented aspiration.

## Notes

Personal infrastructure, actively maintained since December 2023 — validated by daily use across three machines rather than by a test suite.
