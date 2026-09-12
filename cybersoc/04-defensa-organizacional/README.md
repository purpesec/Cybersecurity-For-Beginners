# 04. Defensa organizacional

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Diseñar una defensa en profundidad que combine personas, procesos y tecnología.

## Defensa en profundidad

La prevención reduce la probabilidad; la detección acorta el descubrimiento; la respuesta limita el impacto.

1. Identidad: MFA, mínimo privilegio y revisión de cuentas.
2. Endpoint: parches, EDR, FIM y configuración segura.
3. Red: segmentación, firewall, IDS/IPS y VPN.
4. Datos: clasificación, cifrado y respaldos aislados.
5. Operación: registros centralizados, procedimientos y ejercicios.

Un firewall decide qué comunicación se permite. Un IDS observa y alerta. Un IPS está en línea y puede bloquear. Un puerto abierto demuestra exposición, no vulnerabilidad.

## Evidencia de controles

| Control | Evidencia útil |
|---|---|
| Firewall | origen, destino, puerto, acción y regla |
| IDS/IPS | firma, flujo, severidad y timestamp |
| EDR | proceso, archivo, hash y conexión |
| VPN | usuario, origen, sesión y duración |
| FIM | ruta, cambio, usuario y hash |
| Respaldo | fecha, integridad y restauración |

## Respuesta organizacional

Confirma, comunica, contiene, investiga, erradica, recupera y documenta lecciones. Cada paso debe preservar evidencia y tener un responsable.

## Práctica

Completa el [CyberSOC Lab](../06-cybersoc-lab/README.md) y relaciona Suricata, Wazuh Agent, FIM, Manager y Dashboard con su capa defensiva.

## Entrega

Diagrama de capas, tabla de evidencias y criterio para escalar una alerta a respuesta a incidentes.

[Volver al índice CyberSOC](../README.md)
