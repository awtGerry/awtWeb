+++
title = "Punto de Venta"
description = "Una plataforma de punto de venta multi-negocio en producción para dos negocios de retail desde un solo código base, creciendo hacia un ERP."
date = 2026-08-22

# Etiquetas de taxonomía (para filtrado)
[taxonomies]
tags = ["go", "retail"]

# Campos adicionales — datos personalizados para tus plantillas
[extra]
role = "Único desarrollador, responsable de requisitos, arquitectura, frontend, backend, pruebas, despliegue y mantenimiento."
languages = ["Go", "TypeScript", "Vue"]
domain = "Retail"
ai_usage = "Híbrido"
status = "Producción"
scale = "Producción"
type = "Privado"
repo = "" # repositorio privado
demo = "" # privado, sin demo
screenshot = "images/projects/pos.webp"
screenshot_width = 1440
screenshot_height = 900
screenshot_alt = "La pantalla de ventas del punto de venta en su configuración para el salón: tarjetas de servicios a la izquierda y, a la derecha, un ticket con tres servicios, un producto, el total y el botón Cobrar."

+++

Una plataforma de punto de venta que mueve dinero real en producción para dos negocios pequeños e independientes de giros distintos — desde un solo código base. El personal toma pedidos en tablets, cobra en efectivo o tarjeta y hace el corte de caja al cerrar; los dueños llevan inventario y comisiones desde el mismo sistema. Reemplazó las comandas en papel y la conciliación manual de caja, y habla facturación electrónica mexicana de forma nativa.

Ambos negocios corren como despliegues separados de la misma imagen, seleccionados al arrancar con una bandera de tipo de negocio: un código base, dos tiendas en vivo, cada una con su base de datos y su dominio.

**Cómo funciona**

- Go y PostgreSQL en el backend, con un frontend en Vue 3 compilado e incrustado en el binario de Go — cada despliegue es un solo contenedor que sirve la API y la app.
- Un registro de módulos controla funcionalidades en middleware, rutas y el router del frontend, para que el mismo binario opere cualquiera de los dos negocios sin recompilar.
- El dinero se mueve por un libro contable idempotente — corte de caja, transferencias de cajón, reembolsos, cortesías — en lugar de mutar un saldo acumulado.
- Un outbox transaccional encola los efectos secundarios asíncronos, así una caída a media petición no pierde un evento en silencio.
- La facturación va por un proveedor certificado: documentos fiscales reales ante el SAT, no recibos simulados. El escaneo de códigos de barras impulsa la recepción y el conteo de stock, y la impresión de etiquetas está atada a la máquina de la caja en vez de exponerse por red.

Inventario, compras, comisiones y nómina llegaron como módulos de primera clase sobre la misma plataforma en lugar de bifurcarse en un segundo código base — y ese mismo sistema alimenta a las tiendas públicas a través de su API.

Proyecto privado para cliente, en producción para ambos negocios. Sin repositorio público ni demo.
