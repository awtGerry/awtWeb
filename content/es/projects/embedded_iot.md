+++
title = "Estación Meteorológica IoT"
description = "Una estación meteorológica con ESP32 + DHT11 que transmite lecturas en vivo a un servidor que corre dos modelos de ML para predicción climática local, mostrados en un dashboard en vivo."
date = 2024-12-12

[taxonomies]
tags = ["cpp", "iot"]

[extra]
languages = ["C++", "TypeScript", "Python"]
domain = "IoT"
ai_usage = "Sin IA"
status = "Archivado"
scale = "Archivado"
type = "Código abierto"
repo = "https://gitea.com/awtgerry/embedded-iot"
demo = ""

+++

## Descripción general

Un ESP32 lee temperatura y humedad de un sensor DHT11 cada 15 segundos y las transmite por Wi-Fi vía Socket.IO. Un servidor pasa cada lectura por dos modelos de scikit-learn preentrenados — un árbol de decisión para la condición climática, una regresión lineal para precipitación — entrenados con cerca de dos años de datos históricos de clima, y transmite la predicción a un dashboard en vivo junto con gráficas históricas. Otras nueve construcciones de un solo sensor (táctil, lluvia, luz, flama, movimiento, vibración, nivel de agua, pulso, micrófono) viven en el mismo repositorio como ejercicios independientes.

## Arquitectura

ESP32 (Arduino/PlatformIO, ArduinoJson) → un gateway en NestJS vía Socket.IO → un subproceso de Python que corre los modelos serializados con joblib → SQLite (Prisma), con lecturas replicadas a DynamoDB y una alerta por SNS cuando los valores salen de rango → un dashboard en Next.js/MUI suscrito por WebSocket para valores en vivo más historial respaldado en AWS.

## Decisiones de ingeniería destacables

El dispositivo embebido se mantiene deliberadamente "tonto" — la app cliente tiene prohibido hablar directamente con él, todo pasa por el servidor, así que el nodo sensor no carga ninguna lógica de negocio que pueda fallar. La inferencia se queda fuera del dispositivo y usa modelos clásicos dimensionados para una entrada de dos variables, en lugar de recurrir a una red neuronal que el hardware no necesita. Los datos se limpiaron y exploraron en notebooks antes de modelar, con versiones iteradas del modelo versionadas junto con el pipeline.

## Notas

Código abierto, un proyecto universitario de dos semanas (nov–dic 2024) — construido en solitario, acotado intencionalmente en alcance, y sin mantenimiento después de la entrega.
