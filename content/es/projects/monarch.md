+++
title = "Monarch Beauty Lab"
description = "Sitio bilingüe de reservaciones para un spa y salón de uñas — menú de servicios, explorador de tonos, carrito y checkout, leyendo su catálogo en vivo desde la API pública de la plataforma POS."
date = 2026-08-21

[taxonomies]
tags = ["astro", "retail"]

[extra]
languages = ["Astro", "Svelte", "TypeScript", "Tailwind"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "https://monarchwellness.mx"

+++

## Descripción general

El sitio público de Monarch, un spa y salón de uñas: una página de inicio con propósito comercial, un menú completo de servicios y precios con un explorador de tonos de esmalte tipo "carta", un carrito, y un checkout de varios pasos (datos del cliente, selección de personal/horario, pago) que termina en una confirmación de reservación. Bilingüe (ES/EN) para una audiencia mexicana, y construido para funcionar también como menú accesible por QR dentro del salón.

## Arquitectura

- **Astro** para el esqueleto estático, con islas de **Svelte 5** para todo lo interactivo (menú, carrito, checkout) — la mayor parte de la página se sirve como HTML estático, solo las partes que necesitan reaccionar se hidratan.
- **Cliente de API tipado** que habla con la API pública REST de la plataforma POS (`/api/v1/public/content|services|availability|bookings`) — clases de error tipadas para timeout vs. red vs. errores de API, timeouts de petición, y llaves de idempotencia al crear una reservación para que una petición reintentada no duplique una cita.
- **Pagos** vía Mercado Pago, actualmente por redirección; un flujo de pago con tarjeta embebido está diseñado pero en pausa.
- **Desplegado en Railway** como un build estático con verificación de salud.
- **Catálogo de respaldo**: un catálogo local sembrado cubre el caso donde el backend en vivo regresa un menú vacío, para que el sitio nunca se muestre en blanco.

## Decisiones de ingeniería destacables

- **Mejora progresiva en lugar de una SPA pesada.** El modelo de islas de Astro significa que las páginas de marketing —la mayoría del tráfico— no envían JS al cliente; solo el carrito/checkout se hidratan.
- **Un carrito que sobrevive a un refresh sin necesidad de login.** Un store de carrito basado en runes de Svelte 5 persistido en `sessionStorage` — no se requiere cuenta para navegar o iniciar una reservación.
- **Accesibilidad y diseño documentados como algo central.** Un sistema de diseño y brief de producto escritos apuntan a WCAG 2.1 AA, no solo a la accesibilidad por defecto del framework.
- **Una bandera de feature protege la tienda.** El checkout está controlado por una variable de entorno, para que el sitio de marketing pueda salir en producción independientemente de que el flujo de pago esté activo.

## Notas

Proyecto privado para un cliente; en producción en monarchwellness.mx. Comparte su catálogo de backend y API de reservaciones con la plataforma POS que opera la caja del salón.
