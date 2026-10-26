# Forense y respuesta

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Defensa y monitoreo](../09-defensa-y-monitoreo/README.md) · [Siguiente: Threat intel y hunting](../11-threat-intel-y-hunting/README.md)

Cuando la prevención falla, empieza la respuesta: preservar evidencia, contener, erradicar, recuperar y aprender. Este módulo presenta el ciclo de respuesta a incidentes y las herramientas básicas del análisis forense.

## Contenido

| # | Concepto |
|---|---|
| 10.1 | [Fundamentos de forense](#101-fundamentos-de-forense) |
| 10.2 | [Autopsy](#102-autopsy) |
| 10.3 | [FTK Imager](#103-ftk-imager) |
| 10.4 | [Volcado de memoria](#104-volcado-de-memoria) |
| 10.5 | [WinHex](#105-winhex) |
| 10.6 | [Preparación](#106-preparación) |
| 10.7 | [Contención](#107-contención) |
| 10.8 | [Erradicación](#108-erradicación) |
| 10.9 | [Recuperación](#109-recuperación) |
| 10.10 | [Lecciones aprendidas](#1010-lecciones-aprendidas) |
| 10.11 | [Runbooks](#1011-runbooks) |
| 10.12 | [Copias de seguridad y resiliencia](#1012-copias-de-seguridad-y-resiliencia) |

---

### 10.1 Fundamentos de forense

La forense digital reconstruye qué ocurrió a partir de artefactos: discos, memoria, registros, tráfico y metadatos. Su valor depende de la integridad y de la cadena de custodia.

**Claves:**
- Orden de volatilidad: memoria y conexiones antes que disco.
- Cadena de custodia: quién, cuándo y cómo manipuló la evidencia.
- Hash de la imagen para demostrar que no cambió.
- Se trabaja sobre copias, nunca sobre el original.
- El informe debe separar hechos, inferencias y conclusiones.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final) · [SWGDE — Best practices](https://www.swgde.org/) · [NIST — Digital forensics](https://www.nist.gov/programs-projects/digital-forensics)

---

### 10.2 Autopsy

Autopsy es una plataforma forense de código abierto con interfaz gráfica. Permite analizar imágenes de disco, recuperar archivos borrados y revisar artefactos como historial y línea de tiempo.

**Claves:**
- Se apoya en The Sleuth Kit.
- Ingesta módulos: hash, palabras clave, EXIF, navegador, sistema.
- Genera línea de tiempo y extrae archivos eliminados.
- Exporta informes y hallazgos.
- Trabaja sobre imágenes, no sobre el dispositivo original.

**En el curso:** análisis forense de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Autopsy — Documentation](https://www.autopsy.com/support/) · [The Sleuth Kit](https://www.sleuthkit.org/) · [NIST — Forensic tools](https://www.nist.gov/programs-projects/digital-forensics)

---

### 10.3 FTK Imager

FTK Imager crea imágenes forenses de discos y memoria, y permite explorar su contenido sin montarlas. Es una herramienta habitual para adquirir evidencia en Windows.

**Claves:**
- Formatos de imagen: E01, RAW, AFF.
- Verificación por hash al crear la imagen.
- Permite montar y previsualizar archivos.
- También captura memoria RAM en versiones compatibles.
- La imagen debe almacenarse en un medio controlado.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Exterro — FTK](https://www.exterro.com/digital-forensics-software/ftk-imager) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final) · [SWGDE — Best practices](https://www.swgde.org/)

---

### 10.4 Volcado de memoria

Un volcado de memoria captura el contenido de la RAM en un momento dado. Contiene procesos, conexiones, credenciales en claro y malware que no toca el disco.

**Claves:**
- Herramientas: WinPmem, DumpIt, LiME, `avml`.
- El orden de volatilidad exige capturarla primero.
- El análisis busca procesos ocultos, inyecciones y claves.
- El tamaño puede ser enorme; conviene planificar almacenamiento.
- La captura altera mínimamente el sistema, pero no es invisible.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final) · [Volatility — Documentation](https://volatility3.readthedocs.io/) · [Microsoft — Memory dumps](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/)

---

### 10.5 WinHex

WinHex es un editor hexadecimal y herramienta forense para inspeccionar discos, archivos y memoria a nivel de byte. Permite recuperar datos y calcular hashes.

**Claves:**
- Lectura y edición de sectores y estructuras de disco.
- Búsqueda por patrones y cálculo de checksums.
- Útil para reparar o interpretar formatos binarios.
- La edición sobre evidencia invalida la prueba: trabajar sobre copias.
- Se complementa con herramientas de análisis de PE.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [X-Ways — WinHex](https://www.x-ways.net/winhex/) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final) · [SWGDE — Best practices](https://www.swgde.org/)

---

### 10.6 Preparación

La fase de preparación define cómo se responderá antes de que ocurra el incidente: roles, contactos, herramientas, accesos, plantillas y criterios de escalado.

**Claves:**
- Plan escrito y probado con simulacros.
- Contactos y canales alternativos si la red falla.
- Herramientas y credenciales disponibles sin depender del sistema afectado.
- Criterios claros de qué es un incidente y quién decide.
- La preparación incluye aspectos legales y de comunicación.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — Incident response](https://www.cisa.gov/topics/cybersecurity-best-practices) · [SANS — Incident handler](https://www.sans.org/cyber-security-courses/)

---

### 10.7 Contención

Contener significa limitar el alcance del incidente: aislar equipos, bloquear cuentas, segmentar red o detener procesos, con el menor daño operativo posible.

**Claves:**
- Contención a corto plazo (aislar) y a largo plazo (reconstruir).
- Aislar puede alertar al atacante: valorar el momento.
- Preservar evidencia antes de apagar o reinstalar.
- Documentar cada acción y su justificación.
- Coordinar con negocio para no romper servicios críticos.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — Incident response](https://www.cisa.gov/topics/cybersecurity-best-practices) · [Microsoft — Containment](https://learn.microsoft.com/en-us/security/operations/incident-response-playbooks)

---

### 10.8 Erradicación

Erradicar es eliminar la causa del incidente: malware, cuentas comprometidas, persistencia y vulnerabilidades explotadas.

**Claves:**
- Identificar todos los mecanismos de persistencia.
- Rotar credenciales y revocar sesiones.
- Aplicar parches y corregir configuraciones.
- Verificar que no quedan artefactos ocultos.
- Reinstalar cuando la confianza en el sistema no se puede recuperar.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — Incident response](https://www.cisa.gov/topics/cybersecurity-best-practices) · [MITRE ATT&CK — Persistence](https://attack.mitre.org/tactics/TA0003/)

---

### 10.9 Recuperación

La recuperación devuelve los sistemas a la operación normal, con verificación de que el servicio funciona y de que el atacante no vuelve a entrar.

**Claves:**
- Restaurar desde copias verificadas, no solo recientes.
- Validar integridad y configuración antes de reconectar.
- Monitorizar de cerca durante el periodo posterior.
- Comunicar el estado a usuarios y dirección.
- Documentar el proceso y los datos perdidos.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [NIST SP 800-34 Rev. 1](https://csrc.nist.gov/pubs/sp/800/34/r1/upd1/final) · [CISA — Recovery](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 10.10 Lecciones aprendidas

Tras el incidente se revisa qué funcionó y qué falló. El objetivo es corregir controles, procesos y detecciones, no buscar culpables.

**Claves:**
- Reunión sin reproches con cronología y evidencias.
- Comparar lo esperado con lo ocurrido.
- Convertir hallazgos en acciones con responsable y fecha.
- Actualizar reglas, playbooks y formación.
- Medir si las acciones se completaron.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — After-action review](https://www.cisa.gov/topics/cybersecurity-best-practices) · [NIST SP 800-84](https://csrc.nist.gov/pubs/sp/800/84/final)

---

### 10.11 Runbooks

Un runbook es un procedimiento paso a paso para una tarea operativa o una alerta concreta. Reduce la improvisación y hace la respuesta reproducible.

**Claves:**
- Define disparador, alcance, pasos, validación y escalado.
- Incluye comandos exactos y criterios de decisión.
- Debe probarse y actualizarse tras cada uso.
- Se automatiza con SOAR cuando es estable.
- No sustituye el criterio: indica cuándo parar y escalar.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST SP 800-61 Rev. 3](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [CISA — Playbooks](https://www.cisa.gov/topics/cybersecurity-best-practices) · [Microsoft — Incident response playbooks](https://learn.microsoft.com/en-us/security/operations/incident-response-playbooks)

---

### 10.12 Copias de seguridad y resiliencia

Las copias de seguridad permiten recuperar datos tras un borrado, un cifrado o un fallo. La resiliencia añade capacidad de seguir operando durante el incidente.

**Claves:**
- Regla 3-2-1: tres copias, dos medios, una fuera del sitio.
- Copias inmutables o *air-gapped* frente a ransomware.
- Probar la restauración, no solo la copia.
- Definir RPO (pérdida aceptable) y RTO (tiempo de recuperación).
- Una copia no verificada no es una copia.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-34 Rev. 1](https://csrc.nist.gov/pubs/sp/800/34/r1/upd1/final) · [CISA — StopRansomware](https://www.cisa.gov/stopransomware) · [CISA — Backup](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

[Requisitos previos](../README.md) · [Siguiente: Threat intel y hunting](../11-threat-intel-y-hunting/README.md)
