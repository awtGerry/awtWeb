+++
title = "Estación Meteorológica IoT"
description = "Una estación meteorológica con ESP32 que transmite lecturas en vivo a un servidor que predice el clima local con dos modelos de ML pequeños."
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

Un ESP32 lee temperatura y humedad de un DHT11 cada 15 segundos y las transmite por Wi-Fi. El servidor pasa cada lectura por dos modelos entrenados con unos dos años de historial climático local — un árbol de decisión para la condición del clima, una regresión lineal para precipitación — y empuja la predicción a un dashboard en vivo junto a las gráficas.

**Cómo funciona**

- ESP32 (Arduino/PlatformIO) → un gateway en NestJS sobre Socket.IO → un subproceso de Python con los modelos serializados con joblib.
- SQLite vía Prisma, replicado a DynamoDB, con una alerta de SNS cuando una lectura se sale de rango.
- Un dashboard en Next.js suscrito por WebSocket para valores en vivo e histórico.

El dispositivo se queda tonto a propósito: el dashboard nunca habla directo con él, así que el nodo sensor no carga lógica de negocio que pueda salir mal. La inferencia es clásica y no una red neuronal — dos variables no la necesitan.

Proyecto universitario de dos semanas de finales de 2024, hecho solo. Código abierto, y en el mismo repositorio viven otras nueve prácticas de un solo sensor.
