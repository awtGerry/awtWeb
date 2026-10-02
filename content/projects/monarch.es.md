+++
title = "Monarch Beauty Lab"
description = "Sitio bilingüe de reservaciones para un spa y salón de uñas — servicios, explorador de tonos, carrito y checkout de varios pasos."
date = 2026-08-21

[taxonomies]
tags = ["astro", "retail"]

[extra]
role = "Único desarrollador, responsable de requisitos, arquitectura, frontend, backend, pruebas, despliegue y mantenimiento."
languages = ["Astro", "Svelte", "TypeScript", "Tailwind"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "https://monarchwellness.mx"

+++

El sitio público de un spa y salón de uñas: una página de inicio, el menú completo de servicios y precios, un explorador de tonos para uñas, un carrito y un checkout de varios pasos — datos, personal y horario, pago — que termina en una cita confirmada. Bilingüe (ES/EN) para público mexicano, y funciona también como el menú del salón detrás de un código QR.

**Cómo funciona**

- Astro para la parte estática con islas de Svelte 5 para lo interactivo, así las páginas de marketing — la mayoría del tráfico — no envían nada de JavaScript al cliente.
- Un cliente tipado contra la API pública de la plataforma de retail, con llaves de idempotencia al crear una reservación para que un reintento no aparte el mismo horario dos veces.
- El carrito sobrevive a un refresh sin necesidad de cuenta, guardado en un store con runes en session storage.
- Un catálogo local de respaldo cubre el caso de que el backend responda vacío, así el menú nunca se ve en blanco.
- Reservaciones y pagos van detrás de feature flags, así el sitio de marketing puede salir a su propio ritmo.

Proyecto privado para cliente, en producción. Comparte catálogo y API de reservaciones con la plataforma de punto de venta que opera la caja del salón.
