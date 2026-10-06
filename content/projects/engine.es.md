+++
title = "Graphics Engine"
description = "Un motor de renderizado 2D/3D escrito desde cero en Rust sobre OpenGL puro, para implementar los algoritmos clásicos en lugar de envolver un motor de juegos."
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

Un motor de gráficas para una materia de la universidad, escrito directo sobre OpenGL puro en lugar de recurrir a un crate de motor de juegos — el punto era implementar los algoritmos, no envolver un grafo de escena.

Líneas con Bresenham y DDA, círculos por punto medio, relleno por scanline y flood fill, curvas paramétricas (Lissajous, rosa, tipo Bezier), transformaciones 2D y una pequeña abstracción de shaders. Todo ejercitado en tres demos terminadas: una escena animada estilo Pacman, una mesa de billar en 3D y un reloj analógico texturizado.

**Cómo funciona**

- Un crate de librería separa `graphics` — ventana y contexto con GLFW, compilación de shaders con caché de ubicaciones de uniforms, envoltorios RAII sobre VAOs y buffers — de `algorithms`, un archivo por técnica.
- Tres binarios de demostración lo consumen de forma independiente, cada uno organizado por concepto de dominio.
- La rasterización por software y los triángulos dibujados por GPU conviven a propósito: el camino por píxel está para mostrar el algoritmo, no porque sea rápido.

Código abierto, un semestre de trabajo (sep 2023 – may 2024), terminado y sin tocar desde entonces. Doce ejemplos ejecutables además de las tres demos.
