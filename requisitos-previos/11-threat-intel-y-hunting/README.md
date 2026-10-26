# Threat intel y hunting

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Forense y respuesta](../10-forense-y-respuesta/README.md) · [Siguiente: Índice](../README.md)

La inteligencia convierte datos dispersos en contexto sobre adversarios; la caza proactiva busca lo que las alertas no detectaron. Este módulo reúne las fuentes, los modelos y las herramientas que sostienen ambas actividades.

## Contenido

| # | Concepto |
|---|---|
| 11.1 | [Fundamentos de threat intel y OSINT](#111-fundamentos-de-threat-intel-y-osint) |
| 11.2 | [Conceptos de threat hunting](#112-conceptos-de-threat-hunting) |
| 11.3 | [Reconocimiento](#113-reconocimiento) |
| 11.4 | [WHOIS](#114-whois) |
| 11.5 | [urlscan.io](#115-urlscanio) |
| 11.6 | [URLVoid](#116-urlvoid) |
| 11.7 | [ANY.RUN](#117-anyrun) |
| 11.8 | [VirusTotal](#118-virustotal) |
| 11.9 | [Joe Sandbox](#119-joe-sandbox) |
| 11.10 | [MITRE ATT&CK](#1110-mitre-attck) |
| 11.11 | [Kill chain](#1111-kill-chain) |
| 11.12 | [Cyber kill chain](#1112-cyber-kill-chain) |
| 11.13 | [Diamond Model](#1113-diamond-model) |

---

### 11.1 Fundamentos de threat intel y OSINT

La inteligencia de amenazas recolecta, valida y contextualiza información sobre adversarios, campañas e indicadores. OSINT es la parte obtenida de fuentes públicas.

**Claves:**
- Niveles: estratégico (dirección), operacional (campañas) y táctico (IOC).
- Un indicador sin contexto caduca y engaña.
- Calidad sobre cantidad: fuente, fecha y confianza.
- Pirámide del dolor: TTP más útiles que hashes.
- OSINT exige respetar términos de uso y privacidad.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final) · [MITRE ATT&CK](https://attack.mitre.org/) · [CISA — Threat intelligence](https://www.cisa.gov/topics/cyber-threats-and-advisories)

---

### 11.2 Conceptos de threat hunting

La caza de amenazas es una búsqueda proactiva, guiada por hipótesis, de actividad adversaria que las alertas no detectaron. No es revisar paneles sin rumbo.

**Claves:**
- Hipótesis basada en TTP, inteligencia o anomalías.
- Requiere telemetría suficiente y retención.
- Ciclo: hipótesis, consulta, análisis, hallazgo y mejora.
- Un hallazgo se convierte en regla de detección.
- La ausencia de hallazgos también aporta información.

**En el curso:** [CyberSOC](../../cybersoc/10-threat-hunting-fundamentos/README.md).

**Fuentes:** [MITRE ATT&CK — Hunting](https://attack.mitre.org/resources/) · [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final) · [CISA — Threat hunting](https://www.cisa.gov/topics/cyber-threats-and-advisories)

---

### 11.3 Reconocimiento

El reconocimiento recopila información sobre un objetivo antes de actuar: dominios, correos, tecnologías, empleados y exposiciones. Puede ser pasivo (sin contacto) o activo.

**Claves:**
- Pasivo: OSINT, registros públicos, filtraciones.
- Activo: consultas directas que dejan rastro.
- Resultados típicos: superficie de ataque y posibles vectores.
- En defensa, el reconocimiento propio reduce la exposición.
- El alcance autorizado limita qué se puede consultar.

**En el curso:** [Ethical Hacking](../../ethical-hacking/03-reconocimiento-y-osint-tecnico/README.md).

**Fuentes:** [MITRE ATT&CK — Reconnaissance](https://attack.mitre.org/tactics/TA0043/) · [OWASP — WSTG](https://owasp.org/www-project-web-security-testing-guide/) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 11.4 WHOIS

WHOIS consulta los datos de registro de un dominio o rango IP: titular, registrador, fechas y servidores DNS. RDAP es su sucesor estructurado.

**Claves:**
- Útil para atribuir infraestructura y detectar dominios jóvenes.
- Gran parte de los datos está redactada por privacidad.
- Las fechas de creación y expiración son señales de riesgo.
- Los dominios recién registrados son sospechosos en campañas.
- RDAP devuelve JSON y es el estándar actual.

**En el curso:** [Ethical Hacking](../../ethical-hacking/03-reconocimiento-y-osint-tecnico/README.md).

**Fuentes:** [ICANN — Lookup](https://lookup.icann.org/) · [RFC 7480 — RDAP](https://www.rfc-editor.org/rfc/rfc7480) · [ICANN — Registration data](https://www.rfc-editor.org/rfc/rfc3912)

---

### 11.5 urlscan.io

urlscan.io analiza una URL en un navegador aislado y devuelve captura, peticiones, dominios contactados, tecnologías y recursos descargados.

**Claves:**
- Muestra redirecciones y contenido cargado dinámicamente.
- Permite buscar por dominio, hash o IP en análisis públicos.
- No sustituye un sandbox de malware completo.
- Los resultados públicos pueden alertar al atacante.
- Se puede usar la API para automatizar.

**En el curso:** [Ethical Hacking](../../ethical-hacking/03-reconocimiento-y-osint-tecnico/README.md).

**Fuentes:** [urlscan.io](https://urlscan.io/) · [urlscan.io — API](https://urlscan.io/docs/api/) · [MITRE ATT&CK — Phishing](https://attack.mitre.org/techniques/T1566/)

---

### 11.6 URLVoid

URLVoid consulta una URL o dominio contra múltiples listas de reputación y motores y resume el veredicto.

**Claves:**
- Agrega resultados de varios servicios en una sola consulta.
- Un veredicto limpio no garantiza legitimidad.
- Útil para triaje rápido, no para decisión final.
- Complementa el análisis del contenido y del certificado.
- Las URL pueden cambiar de comportamiento tras el análisis.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [URLVoid](https://www.urlvoid.com/) · [APWG](https://apwg.org/) · [CISA — Phishing](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 11.7 ANY.RUN

ANY.RUN es un sandbox interactivo en la nube que ejecuta muestras y permite observar procesos, tráfico y cambios en tiempo real.

**Claves:**
- Interacción en vivo con la máquina de análisis.
- Informe con procesos, conexiones, IOC y MITRE ATT&CK.
- Los análisis públicos pueden compartirse.
- El malware puede detectar el entorno y no ejecutarse.
- No subir muestras confidenciales sin autorización.

**En el curso:** [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [ANY.RUN](https://any.run/) · [ANY.RUN — Documentation](https://any.run/cybersecurity-blog/) · [MITRE ATT&CK — Software](https://attack.mitre.org/software/)

---

### 11.8 VirusTotal

VirusTotal analiza archivos y URL con decenas de motores y ofrece relaciones: dominios, IP, hashes, comportamientos y comentarios.

**Claves:**
- Un archivo puede tener 0 detecciones y ser malicioso (*zero-day*).
- Las relaciones permiten pivotar entre indicadores.
- Subir muestras las comparte con los motores y socios.
- La API gratuita tiene límites de uso.
- Los resultados son indicios, no veredictos.

**En el curso:** [Análisis de malware](../../malware-analysis/06-triaje-estatico/README.md).

**Fuentes:** [VirusTotal](https://www.virustotal.com/) · [VirusTotal — Docs](https://docs.virustotal.com/) · [MITRE ATT&CK — Indicators](https://attack.mitre.org/)

---

### 11.9 Joe Sandbox

Joe Sandbox ejecuta archivos y URL en un entorno aislado y genera informes detallados de comportamiento, con énfasis en evasión y análisis profundo.

**Claves:**
- Informes con procesos, memoria, red y técnicas detectadas.
- Distintos niveles de sigilo frente a la detección del malware.
- Disponible en versión cloud y on-premise.
- El análisis puede tardar varios minutos.
- Revisar el informe no sustituye la validación manual.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [Joe Sandbox](https://www.joesandbox.com/) · [Joe Security — Docs](https://www.joesecurity.org/) · [MITRE ATT&CK](https://attack.mitre.org/)

---

### 11.10 MITRE ATT&CK

ATT&CK es una base de conocimiento de tácticas y técnicas observadas en adversarios reales. Organiza el comportamiento en tácticas (el porqué) y técnicas (el cómo).

**Claves:**
- Tácticas: reconocimiento, acceso inicial, ejecución, persistencia, etc.
- Técnicas con identificadores (T1059) y subtécnicas.
- Permite mapear detecciones y evaluar cobertura.
- Se usa en informes de inteligencia y en *purple team*.
- No es un checklist: describe comportamiento, no herramientas.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [MITRE ATT&CK](https://attack.mitre.org/) · [MITRE ATT&CK — Enterprise](https://attack.mitre.org/matrices/enterprise/) · [CISA — ATT&CK](https://www.cisa.gov/topics/cyber-threats-and-advisories)

---

### 11.11 Kill chain

La *kill chain* describe las fases de un ataque (reconocimiento, armamento, entrega, explotación, instalación, C2 y acciones) y permite interrumpirlo en cualquiera de ellas.

**Claves:**
- Modelo lineal y fácil de comunicar.
- Cada fase ofrece oportunidades de detección.
- No describe bien ataques con múltiples vectores simultáneos.
- Se complementa con ATT&CK, más granular.
- Su valor está en priorizar controles por fase.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [Lockheed Martin — Kill chain](https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html) · [MITRE ATT&CK](https://attack.mitre.org/) · [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final)

---

### 11.12 Cyber kill chain

La *cyber kill chain* es la adaptación del modelo a operaciones cibernéticas. Añade énfasis en el mando, la infraestructura y la explotación sostenida.

**Claves:**
- Siete fases con acciones del defensor asociadas.
- Útil para explicar un incidente de principio a fin.
- El atacante puede repetir fases o saltarlas.
- La detección temprana reduce el coste de respuesta.
- Se usa junto a ATT&CK para mapear técnicas.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [Lockheed Martin — Cyber kill chain](https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html) · [MITRE ATT&CK](https://attack.mitre.org/) · [NIST SP 800-160 Vol. 1](https://csrc.nist.gov/pubs/sp/800/160/v1/r1/final)

---

### 11.13 Diamond Model

El Diamond Model describe un evento intrusivo con cuatro vértices: adversario, infraestructura, capacidad y víctima. Las relaciones entre ellos permiten pivotar.

**Claves:**
- Cada arista permite pasar de un indicador a otro.
- Se combina con ATT&CK y kill chain.
- Ayuda a atribuir y a agrupar campañas.
- El contexto (tiempo, país, sector) añade valor.
- No exige que todos los vértices sean conocidos.

**En el curso:** [CyberSOC](../../cybersoc/09-threat-intelligence-en-el-soc/README.md).

**Fuentes:** [Diamond Model — Paper](https://www.threatintel.academy/wp-content/uploads/2020/07/diamond-model.pdf) · [MITRE ATT&CK](https://attack.mitre.org/) · [NIST SP 800-150](https://csrc.nist.gov/pubs/sp/800/150/final)

---

[Requisitos previos](../README.md) · [Índice](../README.md)
