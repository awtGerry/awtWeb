+++
title = "La Tropicana POS"
description = "Una app de Android de punto de venta para un bar ficticio — login por mesa, un menú navegable, una cuenta abierta y checkout — un proyecto universitario de dos personas."
date = 2023-12-06

[taxonomies]
tags = ["java", "mobile"]

[extra]
languages = ["Java"]
domain = "Retail"
ai_usage = "Sin IA"
status = "Archivado"
scale = "Archivado"
type = "Código abierto"
repo = "https://github.com/ocurrentduke1/LaTropicana"
demo = ""

+++

## Descripción general

Una app nativa de Android para un bar ficticio. Los clientes inician sesión por mesa, navegan un menú de comida/bebida, arman un carrito, revisan una cuenta abierta, y "pagan" para cerrarla con una notificación de confirmación. Un login separado de empleado abre un menú del lado administrativo. Construido como un proyecto universitario de desarrollo móvil entre dos personas — el antecesor directo, en espíritu, del trabajo de punto de venta en producción que vino después.

## Arquitectura

Un solo módulo de Android (Java, SQLite vía SQLiteOpenHelper para el catálogo de productos, SharedPreferences para el estado del carrito/cuenta) con múltiples Activities y Fragments, y un patrón RecyclerView/adapter para las listas de menú y carrito. Todo es local al dispositivo — sin backend, sin sincronización entre las vistas de cliente y empleado.

## Decisiones de ingeniería destacables

Primer contacto real con las piezas que necesita un POS de verdad — CRUD contra una base de datos local, navegación multi-pantalla, un modelo de carrito/cuenta, e integraciones básicas de mapas/QR — construido y entregado de punta a punta por un equipo de dos personas en la fecha límite del curso en lugar de quedar a medias.

## Notas

Código abierto, un proyecto de curso (Ceti Colomos) construido con un compañero; las credenciales de demo fijas en el código y la falta de sincronización con servidor son simplificaciones intencionales para el alcance de la tarea, no descuidos.
