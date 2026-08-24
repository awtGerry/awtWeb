+++
title = "Punto de Venta"
description = "Una plataforma de punto de venta multi-negocio en producción para dos negocios de retail independientes, evolucionando de un POS de una sola tienda a un ERP de retail completo con inventario, personal y nómina."
date = 2026-08-22

# Etiquetas de taxonomía (para filtrado)
[taxonomies]
tags = ["go", "retail"]

# Campos adicionales — datos personalizados para tus plantillas
[extra]
languages = ["Go", "TypeScript", "Vue"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo

+++

## Descripción general

Una plataforma de punto de venta que mueve dinero real para dos negocios pequeños independientes desde un solo código base: una raspadería/aguas frescas y un spa con venta de productos. El personal toma pedidos en tablets, cobra en efectivo o tarjeta, y hace el corte de caja al final del día; los dueños llevan inventario y comisiones del personal desde el mismo sistema. Reemplazó el papel y la conciliación manual de caja, y habla facturación fiscal mexicana de forma nativa.

Los dos negocios corren como despliegues separados de la misma imagen, seleccionados al arrancar mediante una bandera de tipo de negocio — un solo código base, dos tiendas en vivo, cada una con su propia base de datos y dominio.

## Arquitectura

Un repositorio, un entregable por negocio.

- **Backend**: Go, router Chi, PostgreSQL vía pgx, golang-migrate para versionado de esquema, autenticación JWT, logging con Zap, un hub de WebSocket para actualizaciones de pedidos/cocina en tiempo real, AWS S3 para almacenamiento de archivos, y exportación a PDF/Excel (fpdf, excelize).
- **Frontend**: Vue 3 + TypeScript, Vite, Pinia, TanStack Query, Tailwind CSS — compilado e incrustado directamente en el binario de Go vía `go:embed`, así cada despliegue es un solo contenedor que sirve tanto la API como la app estática.
- **Multi-negocio por despliegue**: un registro de módulos por tipo de negocio controla funcionalidades en tres capas — middleware, rutas y el router del frontend — para que el mismo binario funcione como cualquiera de las dos tiendas sin recompilar.
- **Paquetes de dominio**: inventario, compras, nómina, comisiones, checkout, corte de caja, CFDI (fiscal), gateway PAC, hub de WebSocket, outbox transaccional, pasarela de pago, notificaciones — cada uno aislado en su propio límite de paquete.
- **Builds reproducibles**: un flake de Nix fija la cadena de herramientas Go/Node (`gomod2nix`, `nix flake check` en CI), respaldando un build de Docker multi-etapa (Node → Go → Alpine).
- **Pruebas**: 144 archivos de test en Go más una suite de 18 pruebas Playwright que ejercitan el frontend de punta a punta.

## Decisiones de ingeniería destacables

- **Cumplimiento fiscal real, no una factura de juguete.** La facturación electrónica CFDI mexicana está conectada a través de un PAC (Finkok) — documentos fiscales reales ante el gobierno, no un recibo simulado.
- **Hardware físico en el flujo.** Un lector de código de barras impulsa la recepción y conteo de stock; una impresora térmica de etiquetas está deliberadamente atada por USB a la caja — imprimir tiene que originarse desde la máquina físicamente en la caja registradora, no por red.
- **El dinero se mueve por un libro contable, no por un total acumulado.** El corte de caja, transferencias de cajón, reembolsos y cortesías se registran todos a través de un libro contable idempotente en lugar de mutar un saldo directamente.
- **Confiabilidad vía outbox, no reintentos y esperanza.** Un patrón de outbox transaccional encola efectos secundarios asíncronos para que un fallo a mitad de una petición no pierda un evento silenciosamente.
- **Creciendo hacia un ERP sin reescribir.** Inventario y comisiones del personal están llegando como módulos de primera clase en una rama de features antes de fusionarse a master, con nómina a continuación — el mismo sistema que opera la caja se está convirtiendo en el backend que tiendas públicas (ver Monarch Beauty Lab) leen vía una API pública, en lugar de bifurcarse en un segundo código base.

## Notas

Proyecto privado, en producción para ambos negocios. Sin repositorio público ni demo — nombres de clientes y cifras financieras se omiten intencionalmente.
