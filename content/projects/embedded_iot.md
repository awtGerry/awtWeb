+++
title = "IoT Weather Station"
description = "An ESP32 weather station streaming live readings to a server that predicts local weather with two small ML models."
date = 2024-12-12

[taxonomies]
tags = ["cpp", "iot"]

[extra]
languages = ["C++", "TypeScript", "Python"]
domain = "IoT"
ai_usage = "AI-free"
status = "Archived"
scale = "Archived"
type = "Open Source"
repo = "https://gitea.com/awtgerry/embedded-iot"
demo = ""

+++

An ESP32 reads temperature and humidity off a DHT11 every 15 seconds and streams it over Wi-Fi. A server runs each reading through two models trained on roughly two years of local weather history — a decision tree for conditions, a linear regression for precipitation — and pushes the prediction to a live dashboard alongside the charts.

**How it works**

- ESP32 (Arduino/PlatformIO) → a NestJS gateway over Socket.IO → a Python subprocess holding the joblib-serialized models.
- SQLite through Prisma, mirrored to DynamoDB, with an SNS alert on out-of-range readings.
- A Next.js dashboard subscribed over WebSocket for live values and history.

The device stays deliberately dumb: the dashboard is never allowed to talk to it directly, so the sensor node carries no business logic worth getting wrong. Inference is classical rather than a neural net — two features don't need one.

A two-week university project from late 2024, built solo. Open source, with nine other single-sensor lab builds sharing the repo.
