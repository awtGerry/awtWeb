+++
title = "Baseball Analytics"
description = "Cinco temporadas de MLB, una hipótesis sobre bases por bola que no sobrevivió a los datos, y un clasificador de playoffs."
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

Tomé cinco temporadas de MLB (2019–2023) de la base de datos Lahman y construí las estadísticas avanzadas — OBP, SLG, OPS, BB%, ISO, WHIP, ERA, K/9, DER — a partir de los box scores por equipo, para preguntar si la tasa de bases por bola predice la producción de carreras.

No lo hace. La tasa de bases por bola apenas correlacionó con el éxito del equipo (≈ -0.07), mientras que OPS (≈ 0.80) y carreras por juego (≈ 0.74) se llevaron la ventaja. El reporte lo dice tal cual, en vez de reformular la pregunta a modo. Lo que sí se sostuvo fue que OPS gana como predictor frente al promedio de bateo.

**Cómo funciona**

- Pipeline en notebooks sobre pandas y numpy: recolección → limpieza → análisis → modelado.
- Un `RandomForestClassifier` sobre las estadísticas construidas predice el pase a playoffs, con el modelo entrenado y un script de inferencia guardados junto al pipeline.
- Los hallazgos también se exportaron a un dashboard de PowerBI y una presentación.

Código abierto, y terminado a propósito — un análisis acotado, no una herramienta que pensara seguir creciendo.
