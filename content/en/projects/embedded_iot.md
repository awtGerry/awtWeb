+++
title = "IoT Weather Station"
description = "An ESP32 + DHT11 weather station streaming live readings to a server that runs two ML models for local weather prediction, shown on a live dashboard."
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

## Overview

An ESP32 devkit reads temperature and humidity from a DHT11 sensor every 15 seconds and streams it over Wi-Fi via Socket.IO. A server pipes each reading through two pre-trained scikit-learn models — a decision tree for weather condition, a linear regression for precipitation — trained on roughly two years of historical weather data, then broadcasts the prediction to a live dashboard alongside historical charts. Nine other single-sensor lab builds (touch, rain, light, flame, motion, vibration, water level, pulse, microphone) live in the same repo as standalone exercises.

## Architecture

ESP32 (Arduino/PlatformIO, ArduinoJson) → a NestJS gateway over Socket.IO → a spawned Python subprocess running the joblib-serialized models → SQLite (Prisma), with readings mirrored to DynamoDB and an SNS alert on out-of-range values → a Next.js/MUI dashboard subscribed over WebSocket for live values plus AWS-backed history.

## Notable engineering decisions

The embedded device is kept deliberately "dumb" — the client app is barred from talking to it directly, everything routes through the server, so the sensor node carries no business logic to get wrong. Inference stays off-device and uses classical models sized to a two-feature input, rather than reaching for a neural net the hardware doesn't need. Data was cleaned and explored in notebooks before modeling, with iterated model versions committed alongside the pipeline.

## Notes

Open source, a two-week university project (Nov–Dec 2024) — solo-built, scoped intentionally small, and not maintained past the assignment.
