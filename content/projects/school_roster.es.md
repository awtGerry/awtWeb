+++
title = "School Roster"
description = "Una aplicación de escritorio que arma horarios escolares con un motor de backtracking hecho desde cero."
date = 2026-08-17

[taxonomies]
tags = ["rust", "education"]

[extra]
languages = ["Rust", "Svelte", "TypeScript"]
domain = "Educación"
ai_usage = "Sin IA"
status = "Producción"
scale = "Producción"
type = "Código abierto"
repo = "https://github.com/School-Roster/school_roster.app"
demo = ""

+++

Una herramienta de escritorio para que administradores escolares armen horarios de clase — materia, maestro, bloque de horario y aula para cada grupo, sin empalmes.

El corazón es una búsqueda de backtracking en profundidad escrita a mano. Toma primero el requerimiento más restringido, explora bloques contiguos, días y maestros, y verifica la factibilidad de aulas con emparejamiento bipartito determinista en lugar de tratar los salones como otra dimensión de búsqueda — que es lo que evita la explosión combinatoria. También distingue entre "no existe un horario válido" y "se acabó el presupuesto de búsqueda", porque significan cosas muy distintas para quien está esperando.

**Cómo funciona**

- Tauri envolviendo un backend en Rust y un frontend en SvelteKit, SQLite vía `sqlx`, más un formato propio `.roster`, importación desde Excel y exportación a PDF.
- El motor de horarios vive en su propio módulo — `engine`, `constraints`, `scorer`, `types` — tras sacarlo de una sola función que mezclaba heurísticas, puntuación y persistencia.
- Edición del horario generado con arrastrar y soltar, con deshacer y rehacer completos, para que una persona siempre pueda corregir al solucionador.

Código abierto con colaboradores externos, publicado hasta la v1.0.1 en un pipeline multiplataforma automatizado. La v2.0 — Tauri v2, motor reescrito, soporte móvil — está en curso contra un roadmap público.
