# 11. Metodología y formulación de hipótesis

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Diseñar cazas repetibles, medibles y trazables.

## Ciclo

1. Hipótesis: técnica, activo, periodo y comportamiento.
2. Diseño: fuentes, campos, consulta, umbral y resultado negativo.
3. Recolección: cobertura, calidad y sincronización.
4. Análisis: frecuencia, baseline y contexto.
5. Evaluación: confirmar, refutar o ampliar.
6. Mitigación y automatización: corregir y convertir el éxito en regla.

## Hipótesis útil

Debe ser específica, comprobable y orientada a comportamiento.

Débil: “Hay un atacante en la red”.

Operativa: “Un proceso de PowerShell con argumentos ocultos o codificados es creado por un servicio web durante el periodo de estudio”.

## Tipos

- Intelligence-driven: campaña, reporte o vulnerabilidad.
- Technique-driven: una técnica de MITRE ATT&CK.
- Anomaly-driven: una desviación estadística o temporal.

## Plantilla

~~~text
Hipótesis:
Activo y periodo:
Técnica / comportamiento:
Fuentes y campos:
Consulta:
Resultado positivo:
Control negativo:
Limitaciones:
Decisión:
Regla posterior:
~~~

## Práctica y entrega

Completa la plantilla para la hipótesis PurpleWolf y para una ruta vigilada que recibe un archivo nuevo. Entrega consulta, umbral, evidencia positiva, negativa y limitaciones.

[Volver al índice CyberSOC](../README.md)
