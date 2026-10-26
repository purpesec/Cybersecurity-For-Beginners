# Fundamentos de seguridad

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Sistemas operativos](../05-sistemas-operativos/README.md) · [Siguiente: Amenazas y malware](../07-amenazas-y-malware/README.md)

Este módulo fija el vocabulario con el que se razona sobre seguridad: qué se protege, contra qué, con qué criterios y cómo se mide si un control funciona. Sin estas definiciones, las herramientas y los ataques se explican como recetas.

## Contenido

| # | Concepto |
|---|---|
| 6.1 | [Habilidades y conocimientos de seguridad](#61-habilidades-y-conocimientos-de-seguridad) |
| 6.2 | [Tríada CIA](#62-tríada-cia) |
| 6.3 | [Definición de riesgo](#63-definición-de-riesgo) |
| 6.4 | [Defensa en profundidad](#64-defensa-en-profundidad) |
| 6.5 | [Aislamiento](#65-aislamiento) |
| 6.6 | [Zero Trust](#66-zero-trust) |
| 6.7 | [Amenazas conocidas y desconocidas](#67-amenazas-conocidas-y-desconocidas) |
| 6.8 | [Verdaderos positivos y negativos](#68-verdaderos-positivos-y-negativos) |
| 6.9 | [Falsos positivos y negativos](#69-falsos-positivos-y-negativos) |
| 6.10 | [Equipos azul, rojo y púrpura](#610-equipos-azul-rojo-y-púrpura) |
| 6.11 | [Autenticación frente a autorización](#611-autenticación-frente-a-autorización) |
| 6.12 | [Identificación](#612-identificación) |
| 6.13 | [Hashing](#613-hashing) |
| 6.14 | [Salting](#614-salting) |
| 6.15 | [MFA](#615-mfa) |
| 6.16 | [SSO](#616-sso) |

---

### 6.1 Habilidades y conocimientos de seguridad

La seguridad combina fundamentos (CIA, riesgo, cumplimiento), redes, sistemas, aplicaciones, respuesta a incidentes y habilidades de comunicación. La parte técnica sin criterio produce ruido; el criterio sin técnica produce informes vacíos.

**Claves:**
- El trabajo real es priorizar: no todo riesgo se corrige a la vez.
- Comunicar hallazgos a públicos distintos es parte del oficio.
- La curiosidad y la documentación sostienen la actualización continua.
- La ética y el alcance autorizado delimitan lo que se puede hacer.

**En el curso:** es el hilo de las cinco rutas; ver [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST NICE Framework](https://www.nist.gov/itl/applied-cybersecurity/nice) · [CISSP — Domain overview](https://www.isc2.org/certifications/cissp) · [CISA — Cybersecurity essentials](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 6.2 Tríada CIA

La tríada CIA describe tres propiedades de la información: confidencialidad (solo accede quien debe), integridad (el dato es exacto y no fue alterado) y disponibilidad (el servicio está cuando se necesita).

**Claves:**
- Cada ataque suele romper una o más: exposición, manipulación o interrupción.
- Los controles se diseñan según la propiedad que protegen.
- Existen tensiones: más cifrado puede complicar la disponibilidad.
- Es un modelo de guía, no una lista cerrada de controles.

**En el curso:** primera sesión de [CyberSOC](../../cybersoc/01-fundamentos-ciberseguridad-y-riesgo/README.md).

**Fuentes:** [NIST SP 800-12](https://csrc.nist.gov/pubs/sp/800/12/r1/final) · [NIST — Glossary](https://csrc.nist.gov/glossary) · [CISA — CIA triad](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 6.3 Definición de riesgo

El riesgo es la combinación de la probabilidad de que una amenaza aproveche una vulnerabilidad y el impacto que produciría. Se expresa cualitativa o cuantitativamente y se gestiona, no se elimina.

**Claves:**
- Riesgo = amenaza × vulnerabilidad × impacto (modelo simplificado).
- El riesgo residual es el que queda tras aplicar controles.
- Se prioriza por impacto y probabilidad, no por volumen de alertas.
- La aceptación del riesgo es una decisión documentada.

**En el curso:** [CyberSOC](../../cybersoc/01-fundamentos-ciberseguridad-y-riesgo/README.md).

**Fuentes:** [NIST SP 800-30 Rev. 1](https://csrc.nist.gov/pubs/sp/800/30/r1/final) · [ISO 31000](https://www.iso.org/standard/65694.html) · [NIST RMF](https://csrc.nist.gov/projects/risk-management/about-rmf)

---

### 6.4 Defensa en profundidad

La defensa en profundidad superpone controles independientes para que el fallo de uno no implique el compromiso total. Combina capas técnicas, administrativas y físicas.

**Claves:**
- Ejemplos: firewall, segmentación, EDR, autenticación fuerte, copias de seguridad.
- Cada capa debe aportar valor por sí misma.
- Un control redundante solo es útil si no comparte la misma debilidad.
- La detección y la respuesta también son capas.

**En el curso:** arquitectura de [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) · [CISA — Defense in depth](https://www.cisa.gov/topics/cybersecurity-best-practices) · [NSA — Defense in depth](https://media.defense.gov/2019/Jul/09/2002150499/-1/-1/0/CTR-DEFENSE-IN-DEPTH-20190709.PDF)

---

### 6.5 Aislamiento

El aislamiento separa recursos para limitar el impacto de un fallo o un ataque: procesos, contenedores, máquinas virtuales, redes o cuentas. Es el principio detrás de las sandboxes y de la segmentación.

**Claves:**
- Aislar no es solo técnico: también es separar entornos y credenciales.
- Un aislamiento débil convierte una prueba en un incidente real.
- Los canales laterales pueden atravesar aislamientos teóricos.
- En laboratorio, el aislamiento de red es obligatorio.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [NIST SP 800-190](https://csrc.nist.gov/pubs/sp/800/190/final) · [CISA — Segmentation](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 6.6 Zero Trust

Zero Trust propone no confiar por ubicación: cada acceso se autentica y autoriza según identidad, dispositivo y contexto. Elimina la idea de una red interna "de confianza".

**Claves:**
- Principios: verificar explícitamente, mínimo privilegio, asumir el compromiso.
- Requiere inventario, identidad fuerte, microsegmentación y registro.
- No es un producto único, sino una arquitectura.
- Su adopción es gradual y convive con modelos tradicionales.

**En el curso:** contexto de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) · [CISA — Zero Trust Maturity Model](https://www.cisa.gov/zero-trust-maturity-model) · [Microsoft — Zero Trust](https://learn.microsoft.com/en-us/security/zero-trust/)

---

### 6.7 Amenazas conocidas y desconocidas

Una amenaza conocida tiene firma, patrón o inteligencia asociada; una desconocida no. Los controles basados solo en firmas fallan ante lo nuevo, y los basados solo en comportamiento generan más ruido.

**Claves:**
- Las firmas son rápidas y precisas para lo conocido.
- El análisis de comportamiento detecta variantes y *zero-days*.
- La inteligencia de amenazas convierte lo desconocido en conocido con el tiempo.
- La combinación de ambos enfoques es la práctica habitual.

**En el curso:** detección en [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md) y en [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [NIST SP 800-83 Rev. 1](https://csrc.nist.gov/pubs/sp/800/83/r1/final) · [MITRE ATT&CK](https://attack.mitre.org/) · [CISA — Threat intelligence](https://www.cisa.gov/topics/cyber-threats-and-advisories)

---

### 6.8 Verdaderos positivos y negativos

Un verdadero positivo es una detección correcta de algo que realmente ocurrió; un verdadero negativo es la ausencia correcta de detección cuando no ocurrió nada. Ambos miden la exactitud de un control.

**Claves:**
- Se calculan sobre un conjunto con verdad conocida.
- Un sistema con muchos positivos no es necesariamente mejor.
- La tasa de detección y la de falsos positivos se interpretan juntas.
- En seguridad, el coste de cada tipo de error es distinto.

**En el curso:** evaluación de detecciones en [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST — Detection metrics](https://csrc.nist.gov/glossary) · [NIST SP 800-84](https://csrc.nist.gov/pubs/sp/800/84/final) · [MITRE — Detection engineering](https://attack.mitre.org/resources/)

---

### 6.9 Falsos positivos y negativos

Un falso positivo alerta de algo que no ocurrió; un falso negativo no alerta de algo que sí ocurrió. El primero consume tiempo; el segundo deja pasar el incidente.

**Claves:**
- Los falsos positivos erosionan la confianza en el sistema (*alert fatigue*).
- Los falsos negativos son invisibles hasta que se investiga el incidente.
- Ajustar reglas mejora una métrica y puede empeorar la otra.
- Las pruebas de detección y el *purple team* calibran ambas.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [NIST — Glossary](https://csrc.nist.gov/glossary) · [MITRE — Detection engineering](https://attack.mitre.org/resources/) · [SANS — Detection](https://www.sans.org/cyber-security-courses/)

---

### 6.10 Equipos azul, rojo y púrpura

El equipo rojo ataca, el azul defiende y el púrpura acerca a ambos para mejorar la detección. No son roles excluyentes: describen enfoques de trabajo.

**Claves:**
- Rojo: simula adversarios con alcance autorizado.
- Azul: monitoriza, detecta, responde y mejora controles.
- Púrpura: convierte hallazgos ofensivos en reglas y pruebas defensivas.
- La comunicación y las reglas de enfrentamiento son imprescindibles.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final) · [MITRE — Purple team](https://attack.mitre.org/resources/) · [CISA — Red team](https://www.cisa.gov/)

---

### 6.11 Autenticación frente a autorización

Autenticación responde "¿quién eres?"; autorización responde "¿qué puedes hacer?". Confundirlas produce fallos clásicos: un usuario autenticado sin permiso o un permiso concedido a una identidad no verificada.

**Claves:**
- Autenticación: contraseña, clave, certificado, biometría, MFA.
- Autorización: roles, ACL, políticas, atributos.
- El fallo de control de acceso (IDOR, escalada horizontal) es un problema de autorización.
- Ambas deben registrarse para poder auditar.

**En el curso:** [Pentesting Web](../../pentesting-web/02-sql-injection/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-63B](https://csrc.nist.gov/pubs/sp/800/63/b/upd2/final) · [OWASP — Authorization](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html) · [Microsoft — Authentication vs authorization](https://learn.microsoft.com/en-us/entra/identity-platform/authentication-vs-authorization)

---

### 6.12 Identificación

La identificación es la declaración de una identidad (un nombre de usuario, un número de cuenta). Precede a la autenticación y no la sustituye.

**Claves:**
- Un identificador es público o descubrible; una credencial no.
- Compartir cuentas rompe la trazabilidad.
- Los identificadores predecibles facilitan enumeración.
- La identidad debe ser única y verificable.

**En el curso:** fundamento de [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [NIST SP 800-63A](https://csrc.nist.gov/pubs/sp/800/63/a/final) · [NIST — Glossary](https://csrc.nist.gov/glossary/term/identification) · [OWASP — Authentication](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)

---

### 6.13 Hashing

Una función hash transforma datos en una huella de longitud fija. Es determinista, rápida y unidireccional: no se puede reconstruir la entrada a partir del hash.

**Claves:**
- SHA-256 es el estándar habitual para integridad y firmas.
- MD5 y SHA-1 están rotos para seguridad; se usan solo como identificadores heredados.
- Un hash verifica integridad, no identidad.
- Los hashes de contraseñas necesitan sal y un algoritmo lento (bcrypt, Argon2).

**En el curso:** [Análisis de malware](../../malware-analysis/02-fundamentos-del-malware/README.md).

**Fuentes:** [NIST FIPS 180-4](https://csrc.nist.gov/pubs/fips/180-4/upd1/final) · [NIST SP 800-107 Rev. 1](https://csrc.nist.gov/pubs/sp/800/107/r1/final) · [OWASP — Password storage](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)

---

### 6.14 Salting

Una sal es un valor aleatorio que se añade a cada contraseña antes de aplicarle el hash. Impide que dos contraseñas iguales produzcan el mismo hash y neutraliza las tablas precalculadas.

**Claves:**
- La sal no es secreta; debe ser única por contraseña.
- No sustituye a un algoritmo lento.
- Protege frente a *rainbow tables*, no frente a contraseñas débiles.
- El almacenamiento debe incluir algoritmo, sal y parámetros.

**En el curso:** [Privilege Escalation](../../privilege-escalation/07-secretos-y-priorizacion/README.md).

**Fuentes:** [NIST SP 800-63B](https://csrc.nist.gov/pubs/sp/800/63/b/upd2/final) · [OWASP — Password storage](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html) · [NIST — Glossary](https://csrc.nist.gov/glossary/term/salt)

---

### 6.15 MFA

La autenticación multifactor exige dos o más factores de tipos distintos: algo que sabes, algo que tienes y algo que eres. Contraseña sola es un solo factor.

**Claves:**
- Los factores deben ser independientes; dos contraseñas no son MFA.
- TOTP y claves físicas (FIDO2) resisten mejor el phishing que SMS.
- El MFA por SMS es vulnerable a SIM swapping.
- Su despliegue debe incluir recuperación y altas.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y accesos administrativos.

**Fuentes:** [NIST SP 800-63B](https://csrc.nist.gov/pubs/sp/800/63/b/upd2/final) · [CISA — MFA](https://www.cisa.gov/mfa) · [FIDO Alliance — Specifications](https://fidoalliance.org/specifications/)

---

### 6.16 SSO

El inicio de sesión único permite autenticarse una vez y acceder a varios servicios. Se apoya en un proveedor de identidad y en protocolos como SAML u OIDC.

**Claves:**
- Reduce contraseñas y centraliza políticas.
- El proveedor de identidad se convierte en punto crítico.
- Un token robado puede dar acceso a múltiples aplicaciones.
- Requiere cierre de sesión global y gestión de sesiones.

**En el curso:** identidad en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [OASIS — SAML](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.html) · [OpenID Connect — Specs](https://openid.net/connect/) · [NIST SP 800-63C](https://csrc.nist.gov/pubs/sp/800/63/c/final)

---

[Requisitos previos](../README.md) · [Siguiente: Amenazas y malware](../07-amenazas-y-malware/README.md)
