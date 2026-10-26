# Ataques y explotación

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Amenazas y malware](../07-amenazas-y-malware/README.md) · [Siguiente: Defensa y monitoreo](../09-defensa-y-monitoreo/README.md)

Aquí se describen las técnicas que aprovechan debilidades concretas: interceptación, suplantación, denegación de servicio, inyección y desbordamientos. Se explican a nivel conceptual, con el foco en reconocerlas y mitigarlas, no en ejecutarlas.

## Contenido

| # | Concepto |
|---|---|
| 8.1 | [Man in the middle](#81-man-in-the-middle) |
| 8.2 | [Ataque de repetición](#82-ataque-de-repetición) |
| 8.3 | [Spoofing](#83-spoofing) |
| 8.4 | [Envenenamiento DNS](#84-envenenamiento-dns) |
| 8.5 | [DoS frente a DDoS](#85-dos-frente-a-ddos) |
| 8.6 | [Ataque de desautenticación](#86-ataque-de-desautenticación) |
| 8.7 | [Evil twin](#87-evil-twin) |
| 8.8 | [Punto de acceso no autorizado](#88-punto-de-acceso-no-autorizado) |
| 8.9 | [VLAN hopping](#89-vlan-hopping) |
| 8.10 | [Inyección SQL](#810-inyección-sql) |
| 8.11 | [XSS](#811-xss) |
| 8.12 | [CSRF](#812-csrf) |
| 8.13 | [Directory traversal](#813-directory-traversal) |
| 8.14 | [Desbordamiento de búfer](#814-desbordamiento-de-búfer) |
| 8.15 | [Escalada de privilegios](#815-escalada-de-privilegios) |
| 8.16 | [Drive-by attack](#816-drive-by-attack) |
| 8.17 | [Watering hole](#817-watering-hole) |
| 8.18 | [Ataques web y OWASP Top 10](#818-ataques-web-y-owasp-top-10) |

---

### 8.1 Man in the middle

En un ataque *man in the middle* (MITM) el adversario se sitúa entre dos partes y puede leer, modificar o retransmitir su comunicación. La confianza entre extremos se rompe sin que lo noten.

**Claves:**
- Requiere colocarse en la ruta: ARP spoofing, DNS falso, Wi-Fi malicioso o proxy.
- TLS con validación de certificado lo dificulta; sin validación, no protege.
- También existe MITM legítimo: proxies corporativos con inspección.
- La detección se apoya en certificados inesperados y cambios de red.
- *Pinning* y HSTS reducen la exposición en clientes.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [MITRE ATT&CK — Adversary-in-the-Middle](https://attack.mitre.org/techniques/T1557/) · [OWASP — TLS cheat sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html) · [NIST SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)

---

### 8.2 Ataque de repetición

Un ataque de repetición (*replay*) captura un mensaje válido y lo vuelve a enviar para que el sistema lo acepte como nuevo. Funciona cuando no hay nonce, marca temporal o número de secuencia.

**Claves:**
- Objetivo típico: autenticación, pagos y protocolos de red.
- La defensa usa valores únicos por sesión y ventanas de tiempo.
- TLS incorpora protección contra repetición en sus registros.
- Kerberos incluye marcas de tiempo y números de secuencia.
- Reenviar tráfico capturado sin modificarlo ya es un ataque.

**En el curso:** [Ethical Hacking](../../ethical-hacking/05-explotacion-controlada-y-reportes/README.md).

**Fuentes:** [RFC 8446 — TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446) · [OWASP — Authentication](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html) · [MITRE ATT&CK — Replay](https://attack.mitre.org/techniques/T1557/)

---

### 8.3 Spoofing

El spoofing falsifica un identificador para hacerse pasar por otro: dirección IP, MAC, DNS, correo o número de teléfono. No siempre implica interceptar la respuesta.

**Claves:**
- IP spoofing: origen falso; la respuesta va al destino real.
- MAC spoofing: elude filtros basados en hardware.
- Email spoofing: depende de SPF, DKIM y DMARC para detectarse.
- Caller ID spoofing: frecuente en fraudes telefónicos.
- La defensa combina autenticación de origen y filtrado.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [RFC 7208 — SPF](https://www.rfc-editor.org/rfc/rfc7208) · [RFC 7489 — DMARC](https://www.rfc-editor.org/rfc/rfc7489) · [NIST SP 800-177](https://csrc.nist.gov/pubs/sp/800/177/r1/final)

---

### 8.4 Envenenamiento DNS

El envenenamiento DNS introduce respuestas falsas en la caché de un resolver para redirigir a las víctimas a un destino controlado por el atacante.

**Claves:**
- Puede afectar a un cliente, a un resolver o a un dominio completo.
- Consecuencias: robo de credenciales, malware y MITM.
- DNSSEC autentica la respuesta y dificulta la falsificación.
- DNS over HTTPS/TLS protege la confidencialidad, no la autenticidad.
- Revisar resolvers y cachés es parte de la respuesta.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [RFC 4033 — DNSSEC](https://www.rfc-editor.org/rfc/rfc4033) · [NIST SP 800-81-2](https://www.nist.gov/publications/secure-domain-name-system-dns-deployment-guide) · [MITRE ATT&CK — DNS](https://attack.mitre.org/techniques/T1071/004/)

---

### 8.5 DoS frente a DDoS

Una denegación de servicio (DoS) agota un recurso para que el servicio deje de responder. La versión distribuida (DDoS) usa muchas fuentes, a menudo una botnet.

**Claves:**
- Capas: volumétrica (ancho de banda), protocolo (SYN flood) y aplicación (HTTP flood).
- El DDoS distribuido es difícil de filtrar por origen.
- Defensas: mitigación en el borde, *rate limiting*, CDN y *scrubbing*.
- Un DoS puede ser una cortina de humo para otra acción.
- La disponibilidad es parte de la tríada CIA.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [CISA — DDoS](https://www.cisa.gov/topics/cybersecurity-best-practices) · [MITRE ATT&CK — Network DoS](https://attack.mitre.org/techniques/T1498/) · [NIST SP 800-189](https://csrc.nist.gov/pubs/sp/800/189/final)

---

### 8.6 Ataque de desautenticación

El ataque de desautenticación envía tramas de gestión Wi-Fi falsas para expulsar a un cliente de la red. Se usa para forzar la reconexión y capturar el *handshake*.

**Claves:**
- Aprovecha que las tramas de gestión no iban cifradas en WPA2.
- WPA3 y PMF (*protected management frames*) lo mitigan.
- Su objetivo habitual es obtener el handshake para cracking sin conexión.
- También sirve para interrumpir servicio.
- La monitorización de tramas de gestión ayuda a detectarlo.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [IEEE 802.11](https://standards.ieee.org/ieee/802.11/10549/) · [Wi-Fi Alliance — WPA3](https://www.wi-fi.org/discover-wi-fi/security) · [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final)

---

### 8.7 Evil twin

Un *evil twin* es un punto de acceso falso que imita el SSID legítimo. Los clientes se conectan a él y el atacante intercepta o redirige su tráfico.

**Claves:**
- Funciona mejor con redes abiertas o con portales cautivos falsos.
- La víctima no distingue el AP falso del real por el nombre.
- 802.1X con validación de certificado del servidor protege.
- Los usuarios deben desconfiar de redes abiertas con nombre conocido.
- Se detecta comparando BSSID y canales con el inventario.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final) · [Wi-Fi Alliance — Security](https://www.wi-fi.org/discover-wi-fi/security) · [CISA — Wi-Fi](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 8.8 Punto de acceso no autorizado

Un punto de acceso no autorizado (*rogue AP*) conecta una red inalámbrica a la red cableada sin aprobación. Puede ser un router mal instalado o un dispositivo malicioso.

**Claves:**
- Extiende la red fuera del perímetro físico y sin control.
- Puede eludir la segmentación y las políticas de firewall.
- Se detecta con monitorización inalámbrica y control de switches.
- La política debe prohibir AP no gestionados.
- Los puertos de acceso deben deshabilitarse si no se usan.

**En el curso:** [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final) · [CISA — Wi-Fi](https://www.cisa.gov/topics/cybersecurity-best-practices) · [IEEE 802.1X](https://standards.ieee.org/ieee/802.1X/7345/)

---

### 8.9 VLAN hopping

El *VLAN hopping* permite a un equipo alcanzar VLAN a las que no pertenece, mediante *switch spoofing* o *double tagging*.

**Claves:**
- El *double tagging* explota la manipulación de etiquetas 802.1Q.
- El *switch spoofing* abusa de puertos mal configurados como trunk.
- La defensa: deshabilitar DTP, fijar VLAN nativa y restringir trunks.
- La segmentación pierde valor si se puede saltar.
- Es un ejemplo de control de red mal configurado.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [IEEE 802.1Q](https://standards.ieee.org/ieee/802.1Q/10323/) · [Cisco — VLAN security](https://www.cisco.com/c/en/us/tech/lan-switching/vlan/index.html) · [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final)

---

### 8.10 Inyección SQL

La inyección SQL inserta instrucciones en una consulta para alterar su lógica: leer datos ajenos, modificarlos o ejecutar comandos en el gestor.

**Claves:**
- Causa: concatenar entrada del usuario en la consulta.
- Variantes: *union-based*, *error-based*, *blind* y *time-based*.
- La defensa principal son consultas parametrizadas.
- Validar y escapar ayuda, pero no sustituye la parametrización.
- Un usuario con privilegios mínimos limita el daño.

**En el curso:** [Pentesting Web](../../pentesting-web/02-sql-injection/README.md).

**Fuentes:** [OWASP — SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection) · [OWASP — SQLi Prevention](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html) · [MITRE CWE-89](https://cwe.mitre.org/data/definitions/89.html)

---

### 8.11 XSS

El XSS (*cross-site scripting*) ejecuta JavaScript del atacante en el navegador de la víctima, dentro del origen del sitio. Permite robar sesiones, modificar el DOM o realizar acciones en su nombre.

**Claves:**
- Reflejado: el payload viaja en la petición y se devuelve sin escapar.
- Almacenado: se guarda en el servidor y afecta a otros usuarios.
- DOM-based: la vulnerabilidad está en el JavaScript del cliente.
- Defensas: escapar la salida según el contexto y usar CSP.
- Las cookies `HttpOnly` limitan el robo de sesión.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [OWASP — XSS](https://owasp.org/www-community/attacks/xss/) · [OWASP — XSS Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html) · [MDN — CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)

---

### 8.12 CSRF

El CSRF (*cross-site request forgery*) hace que el navegador de la víctima envíe una petición autenticada a un sitio donde tiene sesión, sin que lo sepa.

**Claves:**
- Aprovecha que el navegador adjunta cookies automáticamente.
- La defensa principal es un token anti-CSRF por sesión.
- `SameSite` en cookies reduce el riesgo.
- Verificar `Origin`/`Referer` añade protección.
- No debe confundirse con XSS: aquí el atacante no ejecuta código en el sitio.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [OWASP — CSRF](https://owasp.org/www-community/attacks/csrf) · [OWASP — CSRF Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) · [MITRE CWE-352](https://cwe.mitre.org/data/definitions/352.html)

---

### 8.13 Directory traversal

El *directory traversal* (o *path traversal*) manipula rutas con `../` para salir del directorio previsto y leer archivos del sistema.

**Claves:**
- El fallo está en confiar en la ruta enviada por el cliente.
- Se combina con descarga de archivos y plantillas.
- Defensas: normalizar la ruta, listas blancas y permisos mínimos.
- La codificación (`%2e%2e%2f`) intenta evadir filtros simples.
- Un contenedor bien aislado limita el alcance.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [OWASP — Path Traversal](https://owasp.org/www-community/attacks/Path_Traversal) · [MITRE CWE-22](https://cwe.mitre.org/data/definitions/22.html) · [OWASP — File Upload](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html)

---

### 8.14 Desbordamiento de búfer

El desbordamiento de búfer escribe más datos de los que caben en una región de memoria, sobrescribiendo datos adyacentes como direcciones de retorno.

**Claves:**
- Puede provocar caída, corrupción o ejecución de código.
- Los lenguajes con comprobaciones y los *stack canaries* lo dificultan.
- ASLR y DEP/NX complican la explotación.
- Su explotación requiere conocer la arquitectura y el binario.
- En análisis de malware explica muchas vulnerabilidades de memoria.

**En el curso:** [Análisis de malware](../../malware-analysis/04-arquitectura-x86-y-memoria/README.md).

**Fuentes:** [MITRE CWE-121](https://cwe.mitre.org/data/definitions/121.html) · [OWASP — Buffer Overflow](https://owasp.org/www-community/vulnerabilities/Buffer_Overflow) · [NIST SP 800-123](https://csrc.nist.gov/pubs/sp/800/123/final)

---

### 8.15 Escalada de privilegios

La escalada de privilegios pasa de una cuenta con permisos limitados a otra con más control, ya sea horizontal (otro usuario) o vertical (administrador).

**Claves:**
- Horizontal: acceder a datos de otro usuario del mismo nivel.
- Vertical: obtener root/SYSTEM o permisos administrativos.
- Vectores: SUID, sudo mal configurado, tareas programadas, servicios, credenciales.
- La enumeración local es la fase clave.
- Defensas: mínimo privilegio, parches y revisión de configuraciones.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [MITRE ATT&CK — Privilege Escalation](https://attack.mitre.org/tactics/TA0004/) · [GTFOBins](https://gtfobins.github.io/) · [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final)

---

### 8.16 Drive-by attack

En un *drive-by attack* basta con visitar un sitio comprometido para que el navegador descargue y ejecute código malicioso, a menudo explotando una vulnerabilidad del navegador o de un plugin.

**Claves:**
- No requiere interacción explícita del usuario.
- Suele usar *exploit kits* y redirecciones maliciosas.
- Navegador y plugins actualizados reducen el riesgo.
- La publicidad maliciosa (*malvertising*) es un vector habitual.
- La detección se apoya en reputación de dominios y comportamiento.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [MITRE ATT&CK — Drive-by Compromise](https://attack.mitre.org/techniques/T1189/) · [CISA — Malvertising](https://www.cisa.gov/topics/cyber-threats-and-advisories) · [NIST SP 800-83](https://csrc.nist.gov/pubs/sp/800/83/r1/final)

---

### 8.17 Watering hole

En un ataque *watering hole* el adversario compromete un sitio que su objetivo visita con frecuencia y lo usa para distribuir malware.

**Claves:**
- Requiere reconocimiento previo de los hábitos del objetivo.
- El sitio legítimo se convierte en vector de confianza.
- Puede afectar a muchos visitantes o solo a un perfil concreto.
- La monitorización de terceros y la integridad web ayudan.
- Se relaciona con *supply chain* y con *drive-by*.

**En el curso:** [CyberSOC](../../cybersoc/07-threat-intelligence-fundamentos/README.md).

**Fuentes:** [MITRE ATT&CK — Drive-by Compromise](https://attack.mitre.org/techniques/T1189/) · [NIST SP 800-161 Rev. 1](https://csrc.nist.gov/pubs/sp/800/161/r1/final) · [CISA — Threat advisories](https://www.cisa.gov/topics/cyber-threats-and-advisories)

---

### 8.18 Ataques web y OWASP Top 10

El OWASP Top 10 resume las categorías de riesgo más relevantes en aplicaciones web: control de acceso, criptografía, inyección, diseño inseguro, configuración, componentes vulnerables, autenticación, integridad, registro y SSRF.

**Claves:**
- Es un documento de concienciación, no una metodología de prueba.
- El control de acceso roto suele ser el riesgo número uno.
- Las categorías cambian con cada edición.
- Se complementa con ASVS para verificación técnica.
- Cada categoría incluye ejemplos y mitigaciones.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [OWASP Top 10](https://owasp.org/www-project-top-ten/) · [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/) · [OWASP WSTG](https://owasp.org/www-project-web-security-testing-guide/)

---

[Requisitos previos](../README.md) · [Siguiente: Defensa y monitoreo](../09-defensa-y-monitoreo/README.md)
