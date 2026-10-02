+++
title = "Simulador de ventas"
description = "Un simulador de escritorio y web que reemplazó una hoja de cálculo frágil de precios para una exportadora agrícola — y demuestra que da los mismos números."
date = 2026-01-27

# Etiquetas de taxonomía (para filtrado)
[taxonomies]
tags = ["python", "finanzas"]

# Campos adicionales — datos personalizados para tus plantillas
[extra]
role = "Único desarrollador, responsable de requisitos, arquitectura, frontend, backend, pruebas, despliegue y mantenimiento."
languages = ["Python", "TypeScript", "Svelte"]
domain = "Finanzas"
ai_usage = "Sin IA"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo
+++

Una empresa exportadora agrícola planeaba sus precios y márgenes semanales en un libro de Excel enorme. No guardaba estado, se rompía si editabas la celda equivocada, y obligaba a copiar y pegar entre hojas para comparar dos escenarios. Esto lo reemplaza: las mismas vistas, los cálculos movidos detrás de un backend, más escenarios con nombre, comparación lado a lado y exportación a PDF, CSV y TXT.

**Cómo funciona**

- Un frontend en SvelteKit empaquetado con Tauri 2 — un solo código base que sale como binario de escritorio con auto-actualización y como build web estático.
- FastAPI, SQLAlchemy y PostgreSQL detrás, con el motor financiero vectorizado en pandas y el redondeo decimal aplicado solo al serializar.
- El cliente recalcula en vivo conforme cambian los parámetros, usa una librería decimal para el dinero de punta a punta, y registra cualquier divergencia contra los valores del servidor en vez de taparla.
- Pruebas de valores dorados verifican que la app reproduce los números de la hoja dentro de una tolerancia fija, contrastados contra una implementación de referencia escrita a mano y datos reales del libro.

Aquí la hoja de cálculo es el juez, así que la exactitud se demuestra en lugar de afirmarse. La única migración que toca datos de producción se niega a adivinar su objetivo: exige un estado inequívoco o una anulación explícita, y audita en ambos casos.

Proyecto privado para cliente. Sin repositorio público ni demo.
