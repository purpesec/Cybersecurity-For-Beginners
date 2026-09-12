# 06. CyberSOC Lab: laboratorio integrador del curso

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Propósito

Este es el laboratorio oficial del curso. Integra dos VMs, DVWA, Suricata, Wazuh, Threat Intelligence, FIM, YARA y Threat Hunting.

La guía ejecutable completa se conserva en [02-arquitectura-soc/lab/README.md](../02-arquitectura-soc/lab/README.md). Incluye topología, instalación, Parte 1, Parte 2 y la Parte 3 de Threat Hunting.

## Topología

| Equipo | Componentes | Función |
|---|---|---|
| VM 1 - CyberSOC | Manager, Indexer, Dashboard | Centralizar y analizar |
| VM 2 - CyberRange | Agent, Suricata, DVWA, atacante | Generar y observar |
| Red host-only | 192.168.56.0/24 | Aislar la práctica |

~~~text
Atacante → DVWA → Suricata → eve.json → Agent
                                      ↓
Dashboard ← Indexer ← Manager ←──────┘
                                      ↓
                        TI / FIM / YARA / Threat Hunting
~~~

## Orden de ejecución

1. Despliega y valida conectividad.
2. Genera el evento base de Suricata.
3. Comprueba la llegada del agente al Manager.
4. Añade Threat Intelligence y la regla 100500.
5. Ejecuta YARA, FIM, la regla 100600 y el timer.
6. Guarda evidencias y detén el timer.

## Evidencias mínimas

Agente Active, EVE JSON con SID 1000001, alerta TI 100500, coincidencias positiva y negativa de YARA, evento FIM, alerta YARA 100600 con run_id y SHA256, detección automática y consulta del Dashboard.

## Reglas

Red host-only y objetivos autorizados. No expongas DVWA, Indexer ni gestión a Internet. Los artefactos PurpleWolf son simulaciones. Restaura snapshots y detén el timer al terminar.

[Ir a la guía ejecutable](../02-arquitectura-soc/lab/README.md)

[Volver al índice CyberSOC](../README.md)
