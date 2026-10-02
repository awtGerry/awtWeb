+++
title = "Planificador"
description = "Un planificador semanal que reemplazó el libro de Excel que mi jefe usaba desde 2017, instalado como PWA en su teléfono."
date = 2026-08-28

[taxonomies]
tags = ["rust", "productivity"]

[extra]
role = "Único desarrollador, responsable de requisitos, arquitectura, frontend, backend, pruebas, despliegue y mantenimiento."
languages = ["Rust", "Vue", "TypeScript"]
domain = "Productividad"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # interno, sin demo

+++

Mi jefe planeaba su semana en el mismo libro de Excel desde 2017: una pestaña por semana, clonada hacia adelante, tareas agrupadas por cliente y agendadas escribiendo un día de la semana al lado. Esto lo reemplaza: un planificador semanal en español para exactamente una persona, instalado como PWA en sus dispositivos Apple.

Las tareas recurrentes se definen una vez en un catálogo y engendran una ocurrencia por semana; el completado vive en la ocurrencia, así las semanas pasadas quedan como historia navegable. Lo que queda sin cerrar se arrastra como atrasada hasta que se hace o se descarta explícitamente.

**Cómo funciona**

- Rust (axum + sqlx) sobre SQLite en un volumen montado, sirviendo la SPA de Vue 3 desde el mismo binario — un contenedor, un origen, y la autenticación por cookie se mantiene trivial.
- Las semanas se materializan de forma perezosa en su primera visita, y eso queda registrado en su propia tabla. Sin cron y sin futuro pregenerado.
- Una semana que nunca se abrió se queda vacía en lugar de ponerse al corriente: vuelves de vacaciones y recibes tu semana, no cuatro semanas de atraso instantáneo.
- Una sola contraseña, sin cuentas, sin nada multiusuario. La app asume un usuario y por eso es más simple.

El vocabulario del dominio está en español y escrito en un glosario, porque los términos son suyos y no míos — unidad de negocio, plantilla, ocurrencia, atrasada. Las decisiones con compromisos reales quedaron como ADRs, incluyendo lo que se recortó: el libro viejo también era un planificador de capacidad con minutos por tarea, y eso se fue a propósito.

Privado e interno. Sin repositorio público ni demo.
