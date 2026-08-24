+++
title = "Graphics Engine"
description = "Un motor de renderizado 2D/3D escrito desde cero en Rust sobre OpenGL puro, implementando algoritmos clásicos de gráficas por computadora a través de tres escenas de demostración funcionales."
date = 2024-05-08

[taxonomies]
tags = ["rust", "graphics"]

[extra]
languages = ["Rust"]
domain = "Gráficas"
ai_usage = "Sin IA"
status = "Archivado"
scale = "Archivado"
type = "Código abierto"
repo = "https://github.com/awtGerry/engine"
demo = ""

+++

## Descripción general

Un motor de gráficas por computadora para una materia universitaria, construido directamente sobre OpenGL puro en lugar de sobre un crate de motor de videojuegos — el objetivo era implementar los algoritmos clásicos de rasterización, no envolver un scene graph. Incluye dibujo de líneas por Bresenham y DDA, círculo por punto medio, relleno por scanline y flood-fill de polígonos/círculos/elipses, trazado de curvas paramétricas (Lissajous, rosa, tipo Bezier), transformaciones 2D, y una pequeña abstracción de shaders — puesto a prueba en tres demos completas: una escena animada estilo Pacman, una animación 3D de una mesa de billar, y un reloj analógico con texturas.

## Arquitectura

Un crate de biblioteca que expone un módulo `graphics` (manejo de ventana/contexto sobre GLFW, compilación de shaders con caché de ubicaciones de uniforms, wrappers RAII delgados sobre VAOs/buffers/vértices) y un módulo `algorithms` con un archivo por técnica. Tres binarios de demostración consumen la biblioteca de forma independiente, cada uno organizado por concepto de dominio — la demo del billar, por ejemplo, separa bola/taco/animación en sus propios archivos.

## Decisiones de ingeniería destacables

Una combinación deliberada de rasterización por software pixel a pixel —para enseñar el algoritmo subyacente— y triángulos dibujados realmente por GPU dentro del mismo motor, en lugar de elegir un solo camino de renderizado. Las llamadas manuales e inseguras a OpenGL se mantienen detrás de pequeños tipos wrapper en lugar de esparcirse por el código de las demos.

## Notas

Código abierto, un proyecto de un solo semestre (sep 2023 – may 2024) — terminado y sin mantenimiento desde entonces, con 12 ejemplos ejecutables además de las tres demos completas.
