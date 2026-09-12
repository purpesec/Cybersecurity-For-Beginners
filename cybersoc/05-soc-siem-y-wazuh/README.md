# 05. SOC, SIEM y Wazuh

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Entender cómo un SOC convierte telemetría dispersa en decisiones y seguir un evento desde el sensor hasta el Dashboard.

## SOC y SIEM

Un SOC combina personas, procesos y tecnología para monitorear, detectar, investigar y coordinar respuesta. Un SIEM centraliza registros, normaliza datos, correlaciona señales y permite búsquedas históricas.

La fuente produce telemetría; el colector la transporta; el motor la decodifica y aplica reglas; el indexador la almacena; el analista decide qué significa.

## Arquitectura Wazuh

| Componente | Función |
|---|---|
| Agent | Recolecta logs, cambios y telemetría |
| Manager | Recibe, decodifica, correlaciona y alerta |
| Indexer | Indexa eventos para búsquedas |
| Dashboard | Visualiza, filtra e investiga |

Suricata añade telemetría de red en EVE JSON.

## Flujo de análisis

evento crudo → decoder → regla base → enriquecimiento → alerta → búsqueda → decisión

Una alerta es una señal investigable. No demuestra por sí sola compromiso ni atribución.

## Práctica

En [CyberSOC Lab](../06-cybersoc-lab/README.md), verifica el agente Active, comprueba EVE JSON, sigue una alerta hasta alerts.json y usa wazuh-logtest para distinguir una prueba de regla de un evento real.

~~~bash
: VM 2
sudo systemctl status wazuh-agent --no-pager
sudo /var/ossec/bin/wazuh-logcollector -t

: VM 1
cd /opt/wazuh-docker/single-node
sudo docker compose ps
sudo docker compose exec -T wazuh.manager /var/ossec/bin/agent_control -lc
~~~

## Entrega

Diagrama del flujo, una alerta base y explicación de la diferencia entre wazuh-logtest y una alerta real.

[Volver al índice CyberSOC](../README.md)
