+++
title = "Arenzano Swimwear"
description = "Tienda en línea full-stack de trajes de baño con carrito de invitado y checkout, reflejando su catálogo en vivo desde la plataforma POS; cuentas de usuario y pago en vivo se lanzan esta semana."
date = 2026-08-19

[taxonomies]
tags = ["rust", "retail"]

[extra]
languages = ["Rust", "Astro", "React", "TypeScript"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo

+++

## Descripción general

Una tienda en línea para Arenzano, una línea de trajes de baño que comparte el catálogo de la plataforma POS. Los visitantes navegan bikinis y accesorios con contenido según el idioma (ES/EN), agregan artículos con variantes (talla, color) a un carrito, y completan el checkout (datos del cliente, entrega, pago) para generar un pedido — sin necesidad de cuenta para comprar.

## Arquitectura

Tres capas, claramente separadas:

- **POS en Go** (fuente de verdad, externo a este repositorio) es dueño del catálogo real de productos e inventario.
- **API en Rust** (Axum, PostgreSQL vía sqlx) refleja el catálogo en una sola dirección y solo lectura, trayendo únicamente los productos marcados para esta marca a través de una credencial de cuenta de servicio de solo lectura acotada — y luego es dueña de sus propias tablas de carritos y pedidos. Endpoints REST: `/products`, `/carts`, `/orders`, `/delivery-options`.
- **Tienda en Astro + React** hidrata solo las piezas interactivas (navegación de catálogo, carrito, pasos de checkout) como islas, con estilos en Tailwind y estado de carrito en nanostores.

Un pedido avanza por una máquina de estados explícita (`pending → confirmed / cancelled`) con una bandera `pos_exported` reservada para sincronizar pedidos confirmados de vuelta al POS.

## Decisiones de ingeniería destacables

- **Espejo de catálogo de solo lectura, acotado por marca.** La tienda no puede corromper el estado del POS ni con un bug — solo lee a través de una cuenta de servicio filtrada por marca, nunca escribe de vuelta.
- **Rigor de CI poco común para una tienda de un solo desarrollador.** Además de los checks habituales de fmt/clippy/tests, el pipeline corre `miri` para detectar comportamiento indefinido y `cargo-deny`/`rustsec` para auditar vulnerabilidades de dependencias.
- **97 pruebas en Rust**, incluyendo pruebas de integración respaldadas por Postgres vía testcontainers y flujos de punta a punta — no solo pruebas unitarias sobre funciones puras.
- **Construido para fallar visiblemente, no en silencio.** El paso de pago es un flujo explícito y claramente etiquetado con tarjetas de prueba en lugar de una integración real a medio conectar, y enviar pedidos de vuelta al POS es un stub explícito de logging — ambos marcados en el código como exactamente lo que falta terminar, no disfrazado de terminado.

## Notas

Proyecto privado para un cliente, parte de la misma familia de marca que Monarch Beauty Lab y la plataforma POS. Navegación de catálogo, carrito y checkout están en vivo hoy; cuentas de usuario y pagos procesados son las últimas piezas que llegan esta semana para cerrar el lanzamiento.
