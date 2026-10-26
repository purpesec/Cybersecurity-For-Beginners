# Defensa y monitoreo

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Ataques y explotación](../08-ataques-y-explotacion/README.md) · [Siguiente: Forense y respuesta](../10-forense-y-respuesta/README.md)

Si los ataques se entienden por lo que rompen, las defensas se entienden por lo que observan y bloquean. Este módulo reúne los controles que sostienen un SOC: antivirus y EDR, firewall, IDS/IPS, SIEM, SOAR y gestión de vulnerabilidades.

## Contenido

| # | Concepto |
|---|---|
| 9.1 | [Antimalware](#91-antimalware) |
| 9.2 | [Antivirus](#92-antivirus) |
| 9.3 | [Seguridad de endpoint](#93-seguridad-de-endpoint) |
| 9.4 | [EDR](#94-edr) |
| 9.5 | [HIPS](#95-hips) |
| 9.6 | [IDS e IPS](#96-ids-e-ips) |
| 9.7 | [NIDS](#97-nids) |
| 9.8 | [NIPS](#98-nips) |
| 9.9 | [Firewall y NGFW](#99-firewall-y-ngfw) |
| 9.10 | [Firewall de host](#910-firewall-de-host) |
| 9.11 | [Registros de firewall](#911-registros-de-firewall) |
| 9.12 | [Bloqueo de puertos](#912-bloqueo-de-puertos) |
| 9.13 | [SIEM](#913-siem) |
| 9.14 | [SOAR](#914-soar) |
| 9.15 | [Honeypots](#915-honeypots) |
| 9.16 | [Sinkholes](#916-sinkholes) |
| 9.17 | [DLP](#917-dlp) |
| 9.18 | [Patching](#918-patching) |
| 9.19 | [Gestión de vulnerabilidades](#919-gestión-de-vulnerabilidades) |
| 9.20 | [Syslog](#920-syslog) |

---

### 9.1 Antimalware

El antimalware agrupa las tecnologías que detectan y bloquean software malicioso: firmas, heurística, comportamiento, reputación y análisis en la nube.

**Claves:**
- Firma: coincide con un patrón conocido; rápida y precisa para lo viejo.
- Heurística y comportamiento: detectan variantes y amenazas nuevas.
- Reputación: consulta el historial del archivo o dominio.
- Cuarentena: aísla sin borrar, útil para el análisis.
- Ningún motor detecta todo; la telemetría y la respuesta importan.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-83 Rev. 1](https://csrc.nist.gov/pubs/sp/800/83/r1/final) · [MITRE ATT&CK — Defensive tools](https://attack.mitre.org/resources/) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.2 Antivirus

El antivirus es el componente clásico del antimalware: inspecciona archivos y procesos comparándolos con firmas y reglas. Sigue siendo útil como primera barrera, pero es insuficiente solo.

**Claves:**
- Depende de actualizaciones de firmas.
- Se evade con empaquetado, cifrado o polimorfismo.
- El análisis al acceder (*on-access*) y el programado se complementan.
- Sus cuarentenas y registros son fuente de investigación.
- En servidores debe planificarse para no degradar el servicio.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-83 Rev. 1](https://csrc.nist.gov/pubs/sp/800/83/r1/final) · [Microsoft — Defender](https://learn.microsoft.com/en-us/defender-endpoint/) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.3 Seguridad de endpoint

La seguridad de endpoint protege los dispositivos finales: equipos de usuario, servidores y móviles. Combina antivirus, firewall local, control de aplicaciones, cifrado y gestión de parches.

**Claves:**
- El endpoint es donde el usuario trabaja y donde aterrizan muchos ataques.
- La gestión centralizada (MDM, EMM) mantiene políticas homogéneas.
- El disco cifrado protege ante pérdida o robo.
- El control de dispositivos limita USB y periféricos.
- La telemetría del endpoint alimenta al EDR y al SIEM.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-124 Rev. 2](https://csrc.nist.gov/pubs/sp/800/124/r2/final) · [Microsoft — Endpoint security](https://learn.microsoft.com/en-us/defender-endpoint/) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.4 EDR

El EDR (*Endpoint Detection and Response*) registra actividad del endpoint (procesos, red, archivos, registro) y permite investigar y responder desde una consola central.

**Claves:**
- Detección por comportamiento, no solo por firma.
- Telemetría con contexto: línea de comandos, padre, usuario, hash.
- Respuesta: aislar el equipo, matar procesos, recoger artefactos.
- Permite *threat hunting* retrospectivo.
- Requiere ajuste para evitar ruido y coste de almacenamiento.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-137](https://csrc.nist.gov/pubs/sp/800/137/final) · [Microsoft — Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/) · [MITRE ATT&CK — Detection](https://attack.mitre.org/resources/)

---

### 9.5 HIPS

Un HIPS (*Host-based Intrusion Prevention System*) monitoriza el sistema y bloquea comportamientos sospechosos: escritura en rutas críticas, inyección, cambios de registro o ejecución anómala.

**Claves:**
- Actúa en el host, complementando al antivirus.
- Puede generar falsos positivos si es demasiado estricto.
- A menudo está integrado en el EDR.
- Reglas por comportamiento, no solo por firma.
- Su configuración requiere conocer las aplicaciones legítimas.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-94](https://csrc.nist.gov/pubs/sp/800/94/final) · [NIST SP 800-83](https://csrc.nist.gov/pubs/sp/800/83/r1/final) · [Microsoft — Attack surface reduction](https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction)

---

### 9.6 IDS e IPS

Un IDS detecta tráfico o actividad sospechosa y alerta; un IPS además bloquea. Pueden analizar red (NIDS/NIPS) o host (HIDS/HIPS).

**Claves:**
- Detección por firmas, anomalías o políticas.
- El IPS en línea puede cortar tráfico, pero también servicios legítimos.
- El IDS fuera de ruta no bloquea, pero no afecta al flujo.
- Requiere ajuste continuo para reducir falsos positivos.
- Sus alertas necesitan contexto para convertirse en incidentes.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-94](https://csrc.nist.gov/pubs/sp/800/94/final) · [Snort — Documentation](https://www.snort.org/documents) · [Suricata — Documentation](https://docs.suricata.io/)

---

### 9.7 NIDS

Un NIDS (*Network Intrusion Detection System*) inspecciona el tráfico de red y genera alertas ante patrones sospechosos. Puede analizar paquetes o flujos.

**Claves:**
- Se despliega en un puerto espejo o en un TAP.
- Detecta escaneos, exploits conocidos y tráfico de C2.
- No puede inspeccionar tráfico cifrado sin claves.
- La posición importa: en el borde ve menos tráfico interno.
- Sus reglas deben revisarse con cada cambio de red.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-94](https://csrc.nist.gov/pubs/sp/800/94/final) · [Suricata — Docs](https://docs.suricata.io/) · [Zeek — Documentation](https://docs.zeek.org/)

---

### 9.8 NIPS

Un NIPS (*Network Intrusion Prevention System*) está en línea y puede bloquear el tráfico que coincide con una firma o política. Gana capacidad de respuesta y añade riesgo de interrupción.

**Claves:**
- Bloqueo en tiempo real frente a detección pasiva.
- Un falso positivo puede cortar un servicio crítico.
- Requiere modo de aprendizaje y validación antes de bloquear.
- Se complementa con firewall y segmentación.
- La latencia añadida debe evaluarse.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-94](https://csrc.nist.gov/pubs/sp/800/94/final) · [NIST SP 800-41 Rev. 1](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.9 Firewall y NGFW

Un firewall filtra tráfico según reglas de dirección, puerto y protocolo. Un NGFW añade inspección de aplicación, IPS, control de usuarios y reputación.

**Claves:**
- Política por defecto: denegar y abrir lo necesario.
- Zonas: exterior, DMZ e interior con reglas distintas.
- NAT y VPN suelen integrarse en el mismo equipo.
- El NGFW identifica aplicaciones aunque usen puertos no estándar.
- Las reglas heredadas y duplicadas son un riesgo habitual.

**En el curso:** [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-41 Rev. 1](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [Cisco — Firewalls](https://www.cisco.com/c/en/us/products/security/firewalls/index.html) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.10 Firewall de host

El firewall de host protege un equipo concreto: decide qué procesos pueden escuchar o conectarse y desde qué redes.

**Claves:**
- Windows Defender Firewall, `ufw`, `firewalld`, `pf`.
- Complementa al firewall de red y cubre el tráfico local.
- Reglas por perfil (doméstico, trabajo, público).
- Un firewall de host mal configurado deja servicios expuestos.
- Es parte de la línea base de cualquier servidor.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-41 Rev. 1](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [Microsoft — Windows Firewall](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/) · [man7 — iptables(8)](https://man7.org/linux/man-pages/man8/iptables.8.html)

---

### 9.11 Registros de firewall

Los registros de firewall documentan conexiones permitidas y denegadas: origen, destino, puerto, acción y a veces aplicación y usuario.

**Claves:**
- Base para detectar escaneos, exfiltración y accesos no previstos.
- Sin fecha sincronizada, la correlación falla.
- El volumen obliga a agregar y retener con criterio.
- Las denegaciones repetidas pueden indicar reconocimiento.
- Exportarlos a un colector evita pérdida local.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-92](https://csrc.nist.gov/pubs/sp/800/92/final) · [NIST SP 800-41](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [CISA — Logging](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.12 Bloqueo de puertos

El bloqueo de puertos impide el acceso a servicios que no deben estar expuestos. Puede aplicarse en el host, en el firewall de red o en el proveedor cloud.

**Claves:**
- Primero cerrar todo; después abrir solo lo necesario.
- Un puerto abierto sin servicio es superficie innecesaria.
- El bloqueo saliente también limita C2 y exfiltración.
- Revisar periódicamente qué escucha y desde dónde.
- En cloud, los grupos de seguridad son la primera línea.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-41 Rev. 1](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [CIS — Benchmarks](https://www.cisecurity.org/cis-benchmarks) · [Microsoft — Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

---

### 9.13 SIEM

Un SIEM centraliza registros de múltiples fuentes, los normaliza, correlaciona y genera alertas. Es la memoria y el motor de detección del SOC.

**Claves:**
- Ingesta, parseo, normalización y correlación.
- Reglas y casos de uso convierten eventos en alertas.
- Retención y coste son decisiones de diseño.
- Sin fuentes relevantes, el SIEM solo acumula ruido.
- Se complementa con SOAR para automatizar respuestas.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-92](https://csrc.nist.gov/pubs/sp/800/92/final) · [Wazuh — Documentation](https://documentation.wazuh.com/) · [Gartner — SIEM glossary](https://www.gartner.com/en/information-technology/glossary/security-information-and-event-management-siem)

---

### 9.14 SOAR

SOAR (*Security Orchestration, Automation and Response*) automatiza tareas repetitivas del SOC: enriquecer alertas, consultar listas, aislar equipos y abrir casos.

**Claves:**
- Orquesta herramientas mediante integraciones y *playbooks*.
- Reduce el tiempo de respuesta en tareas deterministas.
- La automatización sin criterio puede amplificar errores.
- Requiere permisos acotados y trazabilidad.
- Su valor depende de procesos previamente definidos.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — Automation](https://www.cisa.gov/topics/cybersecurity-best-practices) · [Wazuh — Active response](https://documentation.wazuh.com/current/user-manual/capabilities/active-response/index.html)

---

### 9.15 Honeypots

Un honeypot es un señuelo que simula un servicio o sistema vulnerable para atraer y observar actividad adversaria sin riesgo para los activos reales.

**Claves:**
- Puede ser de baja interacción (simulado) o alta (real).
- Aporta inteligencia y alerta temprana.
- Debe aislarse para no convertirse en trampolín.
- Genera ruido si se expone sin control.
- Su valor depende del análisis posterior.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final) · [NIST SP 800-94](https://csrc.nist.gov/pubs/sp/800/94/final) · [CISA — Honeypots](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.16 Sinkholes

Un sinkhole redirige tráfico malicioso (habitualmente DNS) hacia un destino controlado para bloquearlo y observar quién intenta conectarse.

**Claves:**
- Se usa contra C2 y dominios maliciosos.
- Permite identificar equipos infectados que siguen resolviendo.
- Requiere coordinación con proveedores y equipos legales.
- No elimina el malware: solo corta una vía de comunicación.
- Su efectividad depende de la agilidad de publicación.

**En el curso:** [CyberSOC](../../cybersoc/09-threat-intelligence-en-el-soc/README.md).

**Fuentes:** [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final) · [CISA — Sinkholing](https://www.cisa.gov/topics/cyber-threats-and-advisories) · [MITRE ATT&CK — Impair defenses](https://attack.mitre.org/techniques/T1562/)

---

### 9.17 DLP

El DLP (*Data Loss Prevention*) detecta y bloquea la salida de información sensible: datos personales, financieros o propiedad intelectual.

**Claves:**
- Funciona en endpoint, red y cloud.
- Se apoya en clasificación de datos y patrones.
- Puede bloquear, alertar o solo registrar.
- El exceso de reglas genera falsos positivos y frustración.
- Se complementa con cifrado y control de accesos.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) · [NIST SP 800-171](https://csrc.nist.gov/pubs/sp/800/171/r3/final) · [CISA — Data protection](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 9.18 Patching

Aplicar parches corrige vulnerabilidades conocidas. Es el control con mejor relación coste-beneficio y, a la vez, uno de los más difíciles de sostener.

**Claves:**
- Priorizar por explotación activa y exposición, no solo por CVSS.
- Probar antes de desplegar en producción.
- Mantener inventario para saber qué falta.
- Los sistemas sin soporte no reciben parches.
- Un parche puede requerir reinicio: planificar la ventana.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [CISA — Known Exploited Vulnerabilities](https://www.cisa.gov/known-exploited-vulnerabilities-catalog) · [NIST SP 800-40 Rev. 4](https://csrc.nist.gov/pubs/sp/800/40/r4/final) · [Microsoft — Update management](https://learn.microsoft.com/en-us/windows/deployment/update/)

---

### 9.19 Gestión de vulnerabilidades

La gestión de vulnerabilidades identifica, clasifica, prioriza y corrige debilidades de forma continua. No es un escaneo puntual, sino un ciclo.

**Claves:**
- Inventario de activos como base.
- Escaneo autenticado y no autenticado.
- Priorización por contexto: exposición, criticidad y explotación.
- Seguimiento hasta el cierre y verificación.
- Métricas: tiempo medio de remediación y cobertura.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-40 Rev. 4](https://csrc.nist.gov/pubs/sp/800/40/r4/final) · [CISA — Vulnerability management](https://www.cisa.gov/topics/cybersecurity-best-practices) · [FIRST — CVSS](https://www.first.org/cvss/)

---

### 9.20 Syslog

Syslog es el estándar para enviar mensajes de registro a un servidor central. Define severidad, instalación, marca temporal y formato del mensaje.

**Claves:**
- UDP/514 clásico; TCP/6514 para syslog sobre TLS.
- Severidades de 0 (emergencia) a 7 (depuración).
- Centralizar evita que un atacante borre los logs locales.
- La normalización facilita la correlación.
- Un syslog mal configurado pierde mensajes o los duplica.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [RFC 5424 — Syslog](https://www.rfc-editor.org/rfc/rfc5424) · [RFC 5425 — TLS](https://www.rfc-editor.org/rfc/rfc5425) · [NIST SP 800-92](https://csrc.nist.gov/pubs/sp/800/92/final)

---

[Requisitos previos](../README.md) · [Siguiente: Forense y respuesta](../10-forense-y-respuesta/README.md)
