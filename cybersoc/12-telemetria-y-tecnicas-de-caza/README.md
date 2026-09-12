# 12. Telemetría y técnicas de caza en el SOC

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Elegir fuentes adecuadas, agrupar eventos, construir una línea base y convertir una caza exitosa en detección continua.

## Fuentes

Endpoint: Sysmon 1 para procesos, 3 para conexiones, 11 para archivos, 4104 para PowerShell y Wazuh Agent para FIM y auditoría.

Red: Suricata EVE JSON para DNS, HTTP, TLS y alertas; firewall o NetFlow para origen, destino, puerto, volumen y periodicidad.

## Técnicas

### Stacking y frecuencia

Agrupa por proceso, ruta, usuario o destino y cuenta ocurrencias. Lo raro prioriza la investigación, no confirma malicia.

### Baseline y peer grouping

Compara un host con su historial y con equipos pares. Un comando normal en una estación puede ser anómalo en un servidor web.

### Línea temporal

Ordena eventos antes, durante y después: proceso que creó el archivo, conexión externa previa, cuenta que inició sesión y cambios persistentes.

## Feedback loop

Si la caza confirma una técnica, activa respuesta si procede, documenta evidencia, crea una regla o consulta guardada y mide falsos positivos y cobertura.

## Práctica

~~~text
agent.name:"cyberrange-suricata" AND rule.id:100500
agent.name:"cyberrange-suricata" AND rule.id:100600
agent.name:"cyberrange-suricata" AND rule.groups:syscheck
~~~

Relaciona agente, timestamp, ruta, hash y run_id del laboratorio.

## Entrega

Tabla de fuentes y campos, un agrupamiento, línea temporal del archivo final y regla o búsqueda permanente derivada.

[Volver al índice CyberSOC](../README.md)
