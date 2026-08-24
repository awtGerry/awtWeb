+++
title = "Baseball Analytics"
description = "Un proyecto de analítica de MLB a nivel de equipo: estadísticas sabermétricas calculadas a partir de datos de box-score, una hipótesis sobre bases por bola puesta a prueba, y un clasificador de playoffs."
date = 2024-12-18

[taxonomies]
tags = ["python", "sports"]

[extra]
languages = ["Python"]
domain = "Analítica deportiva"
ai_usage = "Sin IA"
status = "Archivado"
scale = "Archivado"
type = "Código abierto"
repo = "https://github.com/awtGerry/baseball-da"
demo = ""

+++

## Descripción general

Se analizaron cinco temporadas de MLB (2019–2023) de la base de datos Lahman, calculando estadísticas avanzadas — OBP, SLG, OPS, BB%, ISO, WHIP, ERA, K/9, DER — a partir de columnas crudas de box-score por equipo. Se puso a prueba si el porcentaje de bases por bola predice la producción de carreras, se comparó OPS contra el promedio de bateo simple como predictor de éxito de equipo, y se analizó el pitcheo (WHIP) contra llegar a playoffs, para después entrenar un clasificador que predice un lugar en playoffs a partir de las estadísticas calculadas.

## Arquitectura

Un pipeline basado en notebooks (recolección → limpieza → análisis → modelado) sobre pandas/numpy, con un `RandomForestClassifier` (features escaladas, split 80/20) como modelo final. Los artefactos entrenados y un pequeño script de inferencia independiente quedaron versionados junto con los notebooks. Los hallazgos también se exportaron a un dashboard de PowerBI y una presentación.

## Hallazgos destacables

- La hipótesis principal no se sostuvo: el porcentaje de bases por bola por sí solo correlacionó débilmente con el éxito del equipo (≈ -0.07), mientras que OPS (≈ 0.80) y carreras por juego (≈ 0.74) fueron predictores mucho más fuertes — los datos contradijeron la suposición inicial, y el reporte lo dice directamente.
- OPS superó al promedio de bateo como predictor de victorias, confirmando la hipótesis secundaria.

## Notas

Código abierto, y considerado terminado por diseño — un análisis acotado y autocontenido en lugar de una herramienta en desarrollo continuo.
