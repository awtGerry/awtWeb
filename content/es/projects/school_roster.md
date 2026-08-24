+++
title = "School Roster"
description = "Aplicación de escritorio que genera horarios escolares con un motor de backtracking construido desde cero — materias, maestros y aulas asignados bajo restricciones reales."
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

## Descripción general

Una herramienta de escritorio para que administradores escolares construyan horarios de clases — asignando materia, maestro, bloque de día/hora y aula a cada grupo de estudiantes para que nada se empalme. El núcleo es una búsqueda de backtracking en profundidad escrita a mano: explora bloques de tiempo contiguos, días y maestros para cada requerimiento usando una heurística de variable más restringida (menos opciones válidas primero), y verifica la factibilidad de aulas en cada candidato mediante emparejamiento bipartito determinista en lugar de expandir cada posible asignación de salones. Reporta infactibilidad y "presupuesto de búsqueda agotado" como dos resultados distintos en lugar de un solo fallo genérico.

## Arquitectura

Tauri (migrando de v1 a v2) envuelve un backend en Rust y un frontend en SvelteKit/TypeScript. SQLite vía `sqlx` maneja la persistencia, junto con un formato de archivo `.roster` propio, importación desde Excel y exportación a PDF de horarios existentes. El motor de scheduling está aislado como su propio módulo (`scheduling/{engine,constraints,scorer,types}`) tras una refactorización deliberada de una función anterior que mezclaba heurísticas, puntuación, persistencia y efectos secundarios. Un asistente de IA, anclado al estado actual del horario, responde preguntas sobre la programación. Los builds multiplataforma (Windows, macOS Intel/ARM, Linux) se publican mediante un pipeline de releases automatizado.

## Decisiones de ingeniería destacables

- **Asignación de aulas como verificación de factibilidad, no como dimensión de búsqueda.** Emparejar aulas mediante matching bipartito en cada candidato evita la explosión combinatoria de enumerar planes de salones completos.
- **Una búsqueda nombrada y con presupuesto.** El motor tiene un límite explícito de unidades de trabajo y límites de seguridad documentados (máximo de días, módulos por día, grupos, aulas), así que "no se encontró horario" siempre viene con una razón concreta.
- **Disciplina de refactorización, por escrito.** Una revisión de arquitectura interna documenta el reemplazo de una función de scheduling monolítica por una separación desacoplada de motor/restricciones/puntuación — evidencia de que el código se paga deliberadamente, no solo se extiende.
- **Edición de cuadrícula con arrastrar y soltar, con deshacer/rehacer completo** sobre un horario generado, para que una persona siempre pueda ajustar a mano la salida del solver.

## Notas

Código abierto, con colaboradores externos, y releases etiquetados hasta la v1.0.1 en un pipeline automatizado multiplataforma. La v2.0 está en desarrollo activo en ramas de features —migración a Tauri v2, un motor de scheduling reescrito, y soporte móvil— sobre un roadmap público.
