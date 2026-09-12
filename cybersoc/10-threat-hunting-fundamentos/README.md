# 10. Fundamentos y mentalidad de Threat Hunting

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Adoptar una postura proactiva para descubrir actividad que evadió detecciones automáticas y reducir el dwell time.

Threat Hunting es una práctica iterativa y dirigida por analistas. Parte de una hipótesis, consulta telemetría histórica o viva, valida evidencia y devuelve detecciones o acciones.

| Disciplina | Detonante | Resultado |
|---|---|---|
| Monitoreo SOC | Alerta de una regla | Triage o escalamiento |
| Incident Response | Incidente confirmado | Contención y recuperación |
| Threat Hunting | Hipótesis analítica | Brecha descubierta o refutada |

## Mentalidad

Assume breach; la ausencia de alertas no prueba seguridad. Formula una pregunta concreta, busca señales positivas y negativas, conserva timestamps y escala a respuesta si hay actividad en curso.

## Práctica

Hipótesis del laboratorio: el host que generó la alerta TI contiene un archivo con artefactos PurpleWolf. YARA busca el patrón, FIM aporta cambios y Wazuh centraliza evidencia.

## Entrega

Hipótesis, fuentes, campos esperados, evidencia positiva y negativa y decisión de cierre o ampliación.

[Volver al índice CyberSOC](../README.md)
