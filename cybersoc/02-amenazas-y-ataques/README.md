# 02. Amenazas y ataques

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Reconocer quién puede atacar, qué busca y qué señales deja una amenaza antes, durante y después de un ataque.

## Conceptos esenciales

- **Ciberdelincuencia:** dinero, fraude, extorsión o venta de acceso.
- **Actor estatal:** espionaje, influencia o interrupción estratégica.
- **Hacktivismo:** una causa política o social.
- **Amenaza interna:** uso accidental o abusivo de un acceso legítimo.
- **Investigador autorizado:** prueba controles con permiso y alcance definidos.

La etiqueta del actor es una hipótesis. La evidencia técnica debe sostenerla.

### Malware

| Tipo | Comportamiento observable |
|---|---|
| Virus | Se adjunta a archivos y requiere ejecución |
| Gusano | Se replica y propaga por la red |
| Troyano | Se presenta como software legítimo |
| Ransomware | Cifra o bloquea datos |
| Spyware | Recopila actividad, credenciales o hábitos |
| Backdoor/rootkit | Mantiene acceso u oculta actividad |

### Técnicas frecuentes

Ingeniería social, denegación de servicio, interceptación, ataques de credenciales y explotación de vulnerabilidades. Una vulnerabilidad es la debilidad; el exploit es la técnica que la aprovecha; el ataque persigue un objetivo.

## Cómo analizar una señal

1. Separa hechos observados de interpretaciones.
2. Identifica activo, cuenta, origen, destino y tiempo.
3. Busca evidencia complementaria en endpoint, red y autenticación.
4. Formula impacto posible y siguiente acción.
5. Registra también los controles negativos.

## Práctica guiada

Usa el laboratorio integrador para generar una petición controlada a DVWA. Documenta actor simulado, activo objetivo, evidencia de Suricata y la diferencia entre intento, alerta e incidente confirmado.

Laboratorio: [CyberSOC Lab](../06-cybersoc-lab/README.md).

## Evidencia

- Clasificación de tres amenazas y su evidencia observable.
- Tabla que distinga vulnerabilidad, exploit y ataque.
- Conclusión que no atribuya una campaña real a los artefactos ficticios.

[Volver al índice CyberSOC](../README.md)
