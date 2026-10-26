# Programación y automatización

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Plataformas y laboratorios](../14-plataformas-y-laboratorios/README.md) · [Siguiente: Marcos y certificaciones](../16-marcos-y-certificaciones/README.md)

Programar no es imprescindible para empezar, pero separa al que usa herramientas del que las entiende y las adapta. Este módulo resume los lenguajes que aparecen en el día a día de la seguridad y para qué sirve cada uno.

## Contenido

| # | Concepto |
|---|---|
| 15.1 | [Habilidades de programación](#151-habilidades-de-programación) |
| 15.2 | [Python](#152-python) |
| 15.3 | [JavaScript](#153-javascript) |
| 15.4 | [C](#154-c) |
| 15.5 | [Go](#155-go) |

---

### 15.1 Habilidades de programación

Programar permite automatizar tareas, leer código ajeno, entender un *exploit* y escribir herramientas pequeñas. En seguridad, el objetivo no es ser desarrollador, sino resolver problemas con código.

**Claves:**
- Leer código es tan importante como escribirlo.
- Automatizar consultas a APIs ahorra horas de trabajo manual.
- Entender estructuras de datos mejora el análisis de binarios y protocolos.
- Los scripts deben manejar errores y no exponer secretos.
- Se aprende con ejercicios pequeños y reales.

**En el curso:** herramientas de apoyo en todas las rutas.

**Fuentes:** [Python — Documentation](https://docs.python.org/3/) · [MDN — Learn](https://developer.mozilla.org/en-US/docs/Learn) · [NIST NICE](https://www.nist.gov/itl/applied-cybersecurity/nice)

---

### 15.2 Python

Python es un lenguaje de alto nivel, legible y con un ecosistema enorme. En seguridad se usa para automatización, análisis de datos, scripting de red y prototipos.

**Claves:**
- Sintaxis simple y biblioteca estándar amplia.
- Bibliotecas habituales: `requests`, `scapy`, `pwntools`, `impacket`.
- Los entornos virtuales aíslan dependencias.
- No debe usarse para tareas pesadas de CPU sin optimización.
- Revisar dependencias evita introducir paquetes maliciosos.

**En el curso:** automatización de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Python — Documentation](https://docs.python.org/3/) · [Python — Packaging](https://packaging.python.org/) · [OWASP — Dependency check](https://owasp.org/www-project-dependency-check/)

---

### 15.3 JavaScript

JavaScript es el lenguaje del navegador y de gran parte del backend moderno (Node.js). En seguridad es clave para entender XSS, CSRF y el comportamiento del cliente.

**Claves:**
- Se ejecuta en el navegador y en servidor (Node.js).
- El modelo de seguridad del navegador (origen, CSP, cookies) es fundamental.
- Herramientas de análisis: DevTools, Burp, ZAP.
- La ofuscación es común en muestras y en código legítimo.
- Revisar dependencias de npm es crítico.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [MDN — JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) · [Node.js — Documentation](https://nodejs.org/en/docs) · [OWASP — XSS](https://owasp.org/www-community/attacks/xss/)

---

### 15.4 C

C es un lenguaje de bajo nivel usado en sistemas operativos, controladores y malware. Entenderlo explica la gestión de memoria y muchas vulnerabilidades.

**Claves:**
- Punteros y memoria manual explican desbordamientos y fugas.
- Se compila a binarios nativos; su análisis requiere ensamblador.
- Es la base de Linux y de gran parte del software crítico.
- Errores comunes: `strcpy`, `sprintf`, falta de comprobaciones.
- Herramientas: compiladores, depuradores y sanitizadores.

**En el curso:** [Análisis de malware](../../malware-analysis/04-arquitectura-x86-y-memoria/README.md).

**Fuentes:** [ISO/IEC 9899](https://www.iso.org/standard/74528.html) · [GCC — Documentation](https://gcc.gnu.org/onlinedocs/) · [MITRE CWE-121](https://cwe.mitre.org/data/definitions/121.html)

---

### 15.5 Go

Go es un lenguaje compilado, con concurrencia integrada y binarios estáticos. Se usa en herramientas de red y en malware reciente por su facilidad de despliegue.

**Claves:**
- Binarios autocontenidos y multiplataforma.
- Concurrencia con goroutines y canales.
- Muy usado en herramientas cloud y de seguridad.
- El análisis de binarios Go requiere reconocer su runtime.
- Su creciente uso en malware dificulta la detección por firma.

**En el curso:** contexto de [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [Go — Documentation](https://go.dev/doc/) · [Go — Security](https://go.dev/security/) · [MITRE ATT&CK — Software](https://attack.mitre.org/software/)

---

[Requisitos previos](../README.md) · [Siguiente: Marcos y certificaciones](../16-marcos-y-certificaciones/README.md)
