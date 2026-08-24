+++
title = "Configuración NixOS"
description = "Una configuración de NixOS + home-manager basada en flakes que unifica tres máquinas — escritorio, laptop y servidor — con modularidad por host y secretos vía sops-nix."
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

## Descripción general

Un solo flake que gobierna tres máquinas con roles distintos: un escritorio con Hyprland/Wayland (también configurado como host para correr agentes de código), una laptop con DWM/X11 optimizada para batería, y un servidor headless (zram, aprovisionamiento delgado con LVM, builds distribuidos). Mantenido de forma continua durante casi tres años, validado con uso diario como estación de trabajo principal.

## Arquitectura

- **flake-parts** compone archivos modulares `parts/*.nix` en lugar de un flake monolítico.
- **Hosts guiados por convención**: un esquema de opciones propio (`awt.nixosConfigurations`) deriva el bootloader, hardware y archivos de entrada de cada host por convención de nombres — `nixos/configurations/<host>.nix`, `bootloader/<host>.nix`, `hardware/<host>.nix` — en lugar de conectar cada `nixosSystem` a mano.
- **Perfiles, no interruptores por módulo**: un host activa paquetes con nombre (`activeProfiles = ["dev" "gaming"]`) en lugar de habilitar cada módulo individualmente.
- **sops-nix** cifra secretos por host mediante llaves age, junto con paquetes propios construidos dentro del mismo flake.

## Decisiones de ingeniería destacables

- **Convención sobre configuración para los hosts.** Agregar una máquina significa añadir tres archivos por convención de nombres, no extender un switch statement.
- **Secretos acotados por host, no por todo el repositorio.** Una llave que desbloquea el servidor no puede descifrar los secretos del escritorio.
- **Una decisión de arquitectura documentada.** Un ADR expone —con alternativas rechazadas explícitamente (Mosh, headscale, Syncthing/NFS)— el diseño para acceder a un host de agentes de código (tmux + git worktrees) vía Tailscale con SSH fail-closed y solo por llave.
- **Fail-closed por defecto**, en el propio módulo del servidor, no solo como aspiración documentada.

## Notas

Infraestructura personal, mantenida activamente desde diciembre de 2023 — validada por el uso diario en tres máquinas en lugar de por una suite de pruebas.
