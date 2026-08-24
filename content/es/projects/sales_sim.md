+++
title = "Simulador de ventas"
description = "Software (web + desktop) para simulador de ventas y márgenes para una empresa exportadora de productos agrícolas: hoja de cálculo por SKU, escenarios con nombre, comparación lado a lado y paridad numérica con Excel."
date = 2026-01-27

# Etiquetas de taxonomía (para filtrado)
[taxonomies]
tags = ["python", "finanzas"]

# Campos adicionales — datos personalizados para tus plantillas
[extra]
languages = ["Python", "TypeScript", "Svelte"]
domain = "Finanzas"
ai_usage = "Sin IA"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo
+++

## Descripción general

Un simulador de ventas y márgenes que reemplaza un libro de Excel de 15 MB y 17 hojas usado para planear precios semanales y proyectar rentabilidad en una empresa exportadora de productos agrícolas. La hoja de cálculo original no tenía persistencia de estado, era fácil de romper editando una sola celda con fórmula, y obligaba a los operadores a copiar y pegar entre hojas para comparar escenarios.

La app replica las tres vistas principales del libro detrás de lógica de backend protegida, agrega escenarios con nombre y comparación lado a lado, y exporta a PDF / CSV / TXT.

## Arquitectura

Dos repositorios, un entregable.

- **Frontend de escritorio y web** (SvelteKit + Svelte 5, TypeScript) empaquetado como app de Tauri 2. Corre como binario de escritorio con auto-actualización, y como build web estático. La UI desacopla las matemáticas derivadas del renderizado: un motor cliente puro en TS replica las fórmulas de Excel usando `decimal.js-light` para todo el dinero, recalcula en vivo conforme cambian los parámetros, y registra divergencias contra los valores del servidor en lugar de ocultarlas.
- **Backend** (FastAPI + SQLAlchemy 1.4 + PostgreSQL) desplegado en Railway. Esquema migrado con Alembic. El motor financiero está vectorizado con pandas, con redondeo `Decimal` aplicado solo en el límite de serialización (round-half-up, fijo). Un caché global en proceso de "época de datos" invalida lecturas ante cualquier mutación; GZip + un solo endpoint `/bootstrap` redujeron el arranque de cinco round trips a uno. Las migraciones están protegidas con inspección y son reversibles, de modo que la misma revisión es segura tanto en una instalación nueva como en una base de datos de producción viva.
- **Ingesta de datos**: el libro de Excel original se importa vía `openpyxl` a tablas normalizadas de Postgres (premisas, concentrado, tipo de cambio, precios, clientes, productos, temporadas, semanas); una sola importación de xlsx se enlaza con el incremento de la época de datos.
- **Disciplina de paridad**: pruebas de valores de referencia con `pytest` verifican que la app reproduce los números calculados por Excel (abs ≤ 0.01 en moneda, rel ≤ 1e-6 en razones) contra (1) una implementación de referencia escrita a mano, (2) datos crudos reales del libro, y (3) salidas verdaderas de Excel recalculadas con LibreOffice. Una prueba de caracterización protege el endpoint legado `/simular` byte a byte en estructura mientras sigue vivo durante la refactorización de vectorización.

## Decisiones de ingeniería destacables

- **Los números son la especificación, no el código.** El Excel es el juez; la corrección se demuestra, no se afirma. Tanto la migración como la vectorización se entregan detrás de pruebas de caracterización escritas antes del cambio.
- **Dinero seguro con Decimal de punta a punta.** Servidor y cliente usan el mismo redondeo explícito (ROUND_HALF_UP) e intermedios de precisión completa; el frontend nunca hace `parseFloat` sobre dinero. Los formateadores de vista existentes quedan intactos, la hoja de trabajo usa su propio helper de despliegue con Decimal.
- **Migraciones a prueba de fallos.** El único backfill que toca las premisas de producción se rehúsa a adivinar una temporada objetivo: requiere una sola temporada activa o una variable de entorno explícita, auditada en ambos sentidos. El downgrade consciente del estado solo elimina lo que la revisión creó.
- **Propiedad de los datos expresada en el copy.** Las notas de mercado por semana se comparten entre el equipo; los ajustes manuales de simulación se pueden guardar por escenario. Ambos hechos se indican en una línea de texto de UI junto al control correspondiente.

## Notas

Proyecto privado para un solo cliente. Sin repositorio público ni demo en vivo; nombre del cliente y cifras se omiten intencionalmente.
