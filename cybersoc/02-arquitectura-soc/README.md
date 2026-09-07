# Capítulo 02: Arquitectura SOC y Threat Intelligence con Wazuh CDB Lists

[Inicio](../../README.md) | [CyberSOC](../README.md) | [Laboratorio Completo](./lab/)

---

## Objetivo

Construir una arquitectura SOC de laboratorio con **Wazuh** como plataforma SIEM/XDR y **Suricata** como IDS de red, validar el recorrido completo de telemetría de eventos EVE JSON y enriquecer las alertas de red mediante feeds locales de **Threat Intelligence** utilizando listas CDB en Wazuh para correlacionar y priorizar IOCs maliciosos.

---

## Resultados de aprendizaje

Al finalizar este capítulo podrás:

- Identificar y desplegar los roles de Wazuh Manager, Indexer, Dashboard y Agent en entornos contenerizados y hosts.
- Explicar cómo Suricata inspecciona interfaces de red y transforma tráfico HTTP en eventos estructurados `eve.json`.
- Configurar el módulo `localfile` del agente de Wazuh para la recolección e ingesta de logs en formato JSON.
- Definir Requerimientos Prioritarios de Inteligencia (PIR) y modelar feeds de indicadores de compromiso (IOCs).
- Crear, compilar y registrar listas **CDB (Constant Database)** en Wazuh Manager para búsquedas de alto rendimiento en memoria.
- Diseñar reglas personalizadas de correlación XML para elevar severidades (Regla `100500` Nivel 12 para IOCs maliciosos y Regla `100501` Nivel 7 para sospechosos).
- Validar la lógica de decodificación y filtrado con `wazuh-logtest` antes de procesar eventos reales.
- Investigar y filtrar alertas enriquecidas en **Wazuh Dashboard (Threat Hunting)**.

---

## Fundamentos Técnicos

Un Security Operations Center (SOC) no se limita a recibir alertas aisladas; su valor reside en **contextualizar, enriquecer y priorizar** la telemetría para responder oportunamente ante amenazas reales.

```mermaid
flowchart TD
    subgraph Detección Base
        A["Tráfico de Red Atacante"] -->|Puerto 80| B["Aplicación Web (DVWA)"]
        B -.->|Inspección de interfaz| S["Suricata NIDS"]
        S -->|Genera evento| E["/var/log/suricata/eve.json"]
        E -->|Log Collector| AG["Wazuh Agent"]
        AG -->|Transmisión cifrada| WM["Wazuh Manager"]
    end

    subgraph Correlación con Threat Intelligence
        TI["Threat Intelligence Feed\n(threat-intel-ip)"] -->|Compilación O(1)| CDB[("CDB List")]
        CDB -->|Lookup src_ip| WM
        WM -->|Coincidencia ^malicious-| R12["Regla 100500\n(Level 12 - Crítica)"]
        WM -->|Sin coincidencia| R3["Regla 86601\n(Level 3 - Informativa)"]
        R12 --> WI["Wazuh Indexer"]
        WI --> WD["Wazuh Dashboard\n(Threat Hunting)"]
    end
```

### De la detección a la inteligencia de amenazas
1. **Detección Pura (Suricata)**: Identifica que un host (`172.30.0.20`) realizó una petición HTTP. Severidad baja/rutinaria (Level 3).
2. **Enriquecimiento con Threat Intel (Wazuh CDB)**: La dirección IP de origen es contrastada instantáneamente contra la base de datos CDB. Al detectar que coincide con `malicious-PurpleWolf-C2-high`, el motor de correlación transforma un evento genérico en un incidente de **alta prioridad (Level 12)**, aportando contexto del adversario al analista.

---

## Arquitectura del Laboratorio

| Equipo | Dirección / Subred | Componentes desplegados |
|---|---:|---|
| **VM 1: CyberSOC** | `192.168.56.10` | Wazuh Manager, Indexer y Dashboard (Docker single-node) |
| **VM 2: CyberRange** | `192.168.56.20` | Wazuh Agent, Suricata (host), DVWA (`172.30.0.10`) y Atacante (`172.30.0.20`) |

---

## Laboratorio Práctico

El laboratorio se divide en dos fases secuenciales complementarias:

👉 [**Abrir la guía completa del laboratorio**](./lab/README.md)

1. [**Parte 1: Despliegue de la Infraestructura y Regla Base (Pasos 0 a 13)**](./lab/README.md#0-configuración-rápida-de-ips):
   - Conectividad de red en red aislada Host-Only.
   - Despliegue de Wazuh en VM 1 mediante Docker Compose.
   - Despliegue del CyberRange (DVWA + Attacker) en VM 2.
   - Instalación y configuración de Suricata y del agente de Wazuh.
   - Verificación del pipeline base: `Attacker -> DVWA -> Suricata -> eve.json -> Agent -> Manager -> Dashboard`.
2. [**Parte 2: Threat Intelligence con Wazuh CDB Lists (Pasos 14 a 60)**](./lab/README.md#parte-2-threat-intelligence-con-wazuh-cdb-lists):
   - Definición del PIR y creación del feed de IOCs en `/var/ossec/etc/lists/threat-intel-ip`.
   - Permisos y registro de la lista en `wazuh_manager.conf`.
   - Creación de reglas personalizadas `cybersoc_threat_intel.xml` (Regla 100500 de Nivel 12 y 100501 de Nivel 7).
   - Validación de lógica con `wazuh-logtest` (Phase 2 Decoding y Phase 3 Rules).
   - Generación de eventos reales, inspección de `alerts.json` y análisis forense en Wazuh Dashboard.

---

## Evidencias requeridas

- Estado de los servicios y contenedores en ambas VMs (`docker compose ps`, `agent_control -lc`).
- Registro EVE JSON local con el SID `1000001`.
- Compilación confirmada de la lista CDB (`threat-intel-ip.cdb`).
- Prueba exitosa en `wazuh-logtest` mostrando el disparo de la regla `100500` a Nivel 12.
- Captura de la alerta enriquecida en **Wazuh Dashboard (Threat Hunting)** filtrando por `rule.id: 100500` y `data.src_ip: 172.30.0.20`.
- Breve informe analítico explicando por qué un IOC Match no implica automáticamente un compromiso consumado y qué pasos de investigación deben seguirse.

---

## Criterio de finalización

La práctica está completa cuando puedes generar una petición HTTP controlada desde el contenedor atacante y observar cómo Wazuh la correlaciona automáticamente con la base de Threat Intelligence, elevando la severidad de nivel 3 a nivel 12 en el Dashboard.

---

[Volver a CyberSOC](../README.md) | [Abrir laboratorio](./lab/README.md) | [Inicio](../../README.md)
