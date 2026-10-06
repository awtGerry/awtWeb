+++
title = "La Tropicana POS"
description = "Una app de Android de punto de venta para un bar ficticio — login por mesa, menú, cuenta abierta y checkout. Proyecto universitario de dos personas."
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

Una app nativa de Android para un bar ficticio. Los clientes entran por número de mesa, navegan el menú de comida y bebida, arman un carrito, revisan su cuenta y "pagan" para cerrarla con una notificación de confirmación. Un login aparte de empleado abre el lado administrativo. La construimos entre dos para una materia de desarrollo móvil.

**Cómo funciona**

- Un solo módulo de Android en Java: SQLite para el catálogo, SharedPreferences para el estado del carrito y la cuenta, Activities y Fragments con adaptadores de RecyclerView para las listas.
- Todo vive en el dispositivo — sin backend, sin sincronización entre la vista del cliente y la del empleado.

Las credenciales de demostración quemadas en el código y la falta de servidor son decisiones de alcance de la tarea, no descuidos. En espíritu es el antepasado del punto de venta en producción que vino después: la primera vez que junté un carrito, una cuenta y CRUD contra una base de datos real de punta a punta.

Código abierto, hecho con un compañero en el Ceti Colomos.
