# 07. Fundamentos y niveles de Threat Intelligence

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Distinguir datos, información, conocimiento e inteligencia y escoger el nivel adecuado para una decisión defensiva.

Threat Intelligence es conocimiento basado en evidencia sobre amenazas, producido para reducir una incertidumbre y apoyar una decisión. Una lista de IP sin contexto es un dato.

dato → información relacionada → conocimiento interpretado → inteligencia accionable

Todo producto debe indicar consumidor, decisión, fuente, fecha, vigencia, confianza, limitaciones y acción recomendada.

## Niveles

| Nivel | Pregunta | Producto |
|---|---|---|
| Estratégico | ¿Qué riesgo cambia la decisión del negocio? | Tendencias y prioridades |
| Operacional | ¿Qué actor o campaña afecta? | Objetivos y capacidades |
| Táctico | ¿Qué TTP detectar o bloquear? | Técnicas y procedimientos |
| Técnico | ¿Qué observable buscar ahora? | IP, dominio, URL, hash o regla |

Los IOC caducan con rapidez. Las TTP y el comportamiento suelen conservar más valor.

## Práctica

En el laboratorio, clasifica 172.30.0.20 como IOC técnico, PurpleWolf-C2-high como contexto simulado y 100500 como decisión de priorización. No presentes estos elementos como atribución real.

## Entrega

Ficha de inteligencia con fuente, confianza, vigencia, observables, limitaciones y acción.

[Volver al índice CyberSOC](../README.md)
