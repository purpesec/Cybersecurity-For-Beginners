# CyberSOC: Operación de un Centro de Operaciones de Seguridad

[Inicio](../README.md) | [Configurar laboratorio](../setup/README.md)

Ruta completa para comprender datos, amenazas, defensa, SOC, Threat Intelligence y Threat Hunting con Wazuh y Suricata.

> [!CAUTION]
> Practica solo en redes host-only y sistemas propios o expresamente autorizados. DVWA, Indexer y puertos de gestión no deben exponerse a Internet.

## Filosofía

Un SOC convierte telemetría en decisiones: comprender el riesgo, construir visibilidad, detectar, investigar, responder y mejorar.

~~~mermaid
flowchart LR
 A[Datos y riesgo] --> B[Amenazas]
 B --> C[Protección y defensa]
 C --> D[SOC y Wazuh]
 D --> E[Threat Intelligence]
 E --> F[Threat Hunting]
 F --> G[Reglas y mejora]
~~~

## Programa completo

| # | Sesión | Teoría | Práctica | Estado |
|---|---|---|---|---|
| 01 | [Datos y ciberseguridad](./01-fundamentos-ciberseguridad-y-riesgo/README.md) | Datos, CIA, estados, activos, amenazas, vulnerabilidades y riesgo | Clasificación de activos y tríada CIA | Disponible |
| 02 | [Amenazas y ataques](./02-amenazas-y-ataques/README.md) | Actores, malware, ingeniería social, credenciales, DoS y vulnerabilidades | Evidencias de una actividad controlada | Disponible |
| 03 | [Protección personal y de datos](./03-proteccion-personal-y-datos/README.md) | Dispositivos, cuentas, Wi-Fi, cifrado, respaldo y privacidad | Inventario y controles básicos | Disponible |
| 04 | [Defensa organizacional](./04-defensa-organizacional/README.md) | Defensa en profundidad, controles, evidencia y respuesta | Mapa de capas defensivas | Disponible |
| 05 | [SOC, SIEM y Wazuh](./05-soc-siem-y-wazuh/README.md) | SOC, SIEM, arquitectura Wazuh y flujo de eventos | Seguir una alerta de extremo a extremo | Disponible |
| 06 | [CyberSOC Lab](./06-cybersoc-lab/README.md) | Arquitectura completa del entorno | Wazuh + Suricata + TI + YARA + FIM | Disponible |
| 07 | [Threat Intelligence: fundamentos y niveles](./07-threat-intelligence-fundamentos/README.md) | Datos, niveles, confianza y acción | Ficha de inteligencia | Disponible |
| 08 | [Ciclo de vida de la inteligencia](./08-ciclo-de-vida-inteligencia/README.md) | Dirección, recolección, procesamiento, análisis, difusión y feedback | PIR y producto trazable | Disponible |
| 09 | [Threat Intelligence aplicada al SOC](./09-threat-intelligence-en-el-soc/README.md) | Enriquecimiento, priorización y límites | Comparar alertas base y TI | Disponible |
| 10 | [Threat Hunting: fundamentos y mentalidad](./10-threat-hunting-fundamentos/README.md) | Assume breach, dwell time y Pirámide del Dolor | Hipótesis de caza | Disponible |
| 11 | [Metodología e hipótesis](./11-metodologia-e-hipotesis/README.md) | Ciclo de caza y tipos de hipótesis | Ficha reproducible | Disponible |
| 12 | [Telemetría y técnicas de caza](./12-telemetria-y-tecnicas-de-caza/README.md) | Stacking, baseline, timeline y feedback loop | Caza y detección continua | Disponible |

## Laboratorio oficial del curso

La guía ejecutable está en [CyberSOC Lab](./06-cybersoc-lab/README.md) y se conserva técnicamente en [02-arquitectura-soc/lab](./02-arquitectura-soc/lab/README.md). Incluye VM 1 con Manager, Indexer y Dashboard; VM 2 con Agent, Suricata, DVWA y atacante; NIDS, Threat Intelligence, YARA, FIM y Threat Hunting.

## Cómo estudiar

1. Completa las sesiones 01 a 04.
2. Despliega la arquitectura en la sesión 05.
3. Ejecuta el laboratorio integrador de la sesión 06.
4. Usa las sesiones 07 a 09 para interpretar inteligencia.
5. Completa las sesiones 10 a 12 y convierte una caza en detección.

## Evidencias finales

Agente Active, evento EVE JSON, alerta TI 100500, YARA positiva y negativa, evento FIM, alerta 100600 con run_id y SHA256, detección automática y filtros del Dashboard.

[Volver al catálogo principal](../README.md)
