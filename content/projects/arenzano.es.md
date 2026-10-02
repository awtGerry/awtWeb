+++
title = "Arenzano Swimwear"
description = "Una tienda en línea de trajes de baño — navegar, carrito y checkout sin cuenta — sobre una API en Rust que refleja el catálogo de la plataforma que opera el negocio."
date = 2026-08-19

[taxonomies]
tags = ["rust", "retail"]

[extra]
role = "Único desarrollador, responsable de requisitos, arquitectura, frontend, backend, pruebas, despliegue y mantenimiento."
languages = ["Rust", "Astro", "React", "TypeScript"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo

+++

Una tienda en línea para una marca de trajes de baño. Navegas la colección en español o inglés, eliges talla y color, y pagas. No hace falta crear una cuenta para comprar.

Lo interesante es que no es dueña de su catálogo. Los productos se replican en un solo sentido y de solo lectura desde la plataforma de retail que ya opera el negocio, así que un bug en la tienda no puede corromper el inventario real. De ahí en adelante — carrito, pedidos — todo es suyo.

**Cómo funciona**

- API en Rust (Axum) sobre PostgreSQL. Los pedidos avanzan por una máquina de estados explícita en vez de un montón de banderas booleanas, así el camino de creado a entregado queda auditable.
- Tienda en Astro que hidrata solo lo interactivo — catálogo, carrito, checkout — como islas de React.
- CI con detección de comportamiento indefinido y auditoría de dependencias, y pruebas que golpean un Postgres real en contenedores efímeros en lugar de simularlo.

Proyecto privado para cliente, de la misma familia que la plataforma de punto de venta. Sin repositorio público ni demo.
