+++
title = "Configuración NixOS"
description = "Una configuración de NixOS basada en flakes que maneja tres máquinas — escritorio, laptop y un servidor headless — desde un solo repositorio."
date = 2026-08-19

[taxonomies]
tags = ["nix", "devops"]

[extra]
languages = ["Nix"]
domain = "Sistemas"
ai_usage = "Sin IA"
status = "Activo"
scale = "Activo"
type = "Código abierto"
repo = "https://github.com/awtGerry/home-cfg"
demo = ""

+++

Un solo flake y tres máquinas con trabajos muy distintos: un escritorio con Hyprland que además hospeda agentes de código, una laptop con DWM ajustada para batería, y un servidor headless con zram, aprovisionamiento delgado con LVM y builds distribuidos. Lo uso como máquina principal desde hace casi tres años.

**Cómo funciona**

- `flake-parts` compone archivos modulares `parts/*.nix` en lugar de un flake monolítico.
- Agregar una máquina es dejar caer tres archivos por convención de nombres — `nixos/configurations/<host>.nix`, `bootloader/<host>.nix`, `hardware/<host>.nix` — y no extender un switch.
- Cada host se suscribe a perfiles con nombre (`activeProfiles = ["dev" "gaming"]`) en vez de prender el `enable` de cada módulo uno por uno.
- `sops-nix` cifra los secretos por host con llaves age, así que la llave que abre el servidor no descifra el escritorio.

También hay un ADR ahí adentro que documenta el host de agentes sobre Tailscale con tmux y git worktrees, con las alternativas que descarté (Mosh, headscale, Syncthing) escritas en lugar de olvidadas. Se valida con el uso diario en tres máquinas, no con una suite de pruebas.
