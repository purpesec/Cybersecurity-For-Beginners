# 09. Aplicación de Threat Intelligence en el SOC

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Usar inteligencia para prevenir, detectar, investigar y responder sin convertir un IOC en una conclusión automática.

## De inteligencia a detección

Un informe puede producir reglas sobre IOC, búsquedas, firmas de red, listas de bloqueo revisadas, detecciones de comportamiento y preguntas para respuesta. La automatización debe incluir vigencia, confianza y retiro de indicadores obsoletos.

## Enriquecimiento

Sin contexto, una conexión saliente compite con muchas señales. Con contexto, el analista conoce campaña, sector, fecha, confianza y actividad relacionada. El nivel de Wazuh debe responder a la política del laboratorio, no al texto del feed por sí solo.

## Práctica

En [CyberSOC Lab](../06-cybersoc-lab/README.md), compara alerta base 86601 con 100500, ejecuta el control negativo con una IP ausente y registra qué no puede concluirse del IOC.

## Entrega

Comparativa base/enriquecida, política de expiración de IOC y dos búsquedas derivadas: una técnica y otra de comportamiento.

[Volver al índice CyberSOC](../README.md)
