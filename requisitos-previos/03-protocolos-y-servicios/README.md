# Protocolos y servicios

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Redes](../02-redes-fundamentos/README.md) · [Siguiente: Red y criptografía](../04-red-y-criptografia/README.md)

Si las direcciones dicen *quién* y *dónde*, los protocolos dicen *cómo* se habla. Este módulo reúne los servicios que aparecen en cualquier análisis: resolución de nombres, asignación de direcciones, transferencia de archivos, acceso remoto y autenticación. Reconocer un puerto y un protocolo es el primer paso para interpretar un escaneo o una captura.

## Contenido

| # | Concepto |
|---|---|
| 3.1 | [Puertos comunes](#31-puertos-comunes) |
| 3.2 | [Protocolos comunes](#32-protocolos-comunes) |
| 3.3 | [Handshakes](#33-handshakes) |
| 3.4 | [DNS](#34-dns) |
| 3.5 | [DHCP](#35-dhcp) |
| 3.6 | [ARP](#36-arp) |
| 3.7 | [NTP](#37-ntp) |
| 3.8 | [HTTP y HTTPS](#38-http-y-https) |
| 3.9 | [FTP](#39-ftp) |
| 3.10 | [SFTP](#310-sftp) |
| 3.11 | [FTP frente a SFTP](#311-ftp-frente-a-sftp) |
| 3.12 | [SSH](#312-ssh) |
| 3.13 | [RDP](#313-rdp) |
| 3.14 | [SSL y TLS](#314-ssl-y-tls) |
| 3.15 | [SSL frente a TLS](#315-ssl-frente-a-tls) |
| 3.16 | [SSL/TLS en la práctica](#316-ssltls-en-la-práctica) |
| 3.17 | [Kerberos](#317-kerberos) |
| 3.18 | [LDAP](#318-ldap) |
| 3.19 | [LDAPS](#319-ldaps) |
| 3.20 | [RADIUS](#320-radius) |
| 3.21 | [EAP frente a PEAP](#321-eap-frente-a-peap) |

---

### 3.1 Puertos comunes

Un puerto identifica un servicio dentro de un equipo. Los puertos bien conocidos (0-1023) tienen asignaciones registradas: 22 SSH, 25 SMTP, 53 DNS, 80 HTTP, 443 HTTPS, 445 SMB, 3389 RDP.

**Claves:**
- El puerto no garantiza el servicio: cualquiera puede escuchar en el 80.
- TCP y UDP tienen espacios de puertos independientes.
- `nmap` identifica servicios probando y comparando respuestas.
- Un servicio en un puerto inesperado suele indicar configuración manual o evasión.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md) y [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [IANA — Service Name and Transport Protocol Port Registry](https://www.iana.org/assignments/service-names-port-numbers/) · [RFC 6335](https://www.rfc-editor.org/rfc/rfc6335) · [Nmap — Port scanning basics](https://nmap.org/book/man-port-scanning-basics.html)

---

### 3.2 Protocolos comunes

Un protocolo define el formato, el orden y las reglas de los mensajes. Los más frecuentes en análisis son IP, TCP, UDP, ICMP, DNS, HTTP, TLS, SSH, SMB, LDAP y Kerberos.

**Claves:**
- TCP orienta a conexión y garantiza entrega; UDP no.
- ICMP transporta diagnóstico y errores (`ping`, `traceroute`).
- Muchos protocolos antiguos viajan en claro y exponen credenciales.
- Conocer el protocolo permite leer una captura sin adivinar.

**En el curso:** base para [CyberSOC](../../cybersoc/README.md) y para el análisis de tráfico de [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [IANA — Protocol registries](https://www.iana.org/protocols) · [RFC 1122](https://www.rfc-editor.org/rfc/rfc1122) · [Cloudflare — Network protocols](https://www.iana.org/protocols)

---

### 3.3 Handshakes

Un *handshake* es el intercambio inicial que acuerda parámetros antes de transmitir datos. TCP usa un saludo de tres pasos (SYN, SYN-ACK, ACK); TLS negocia versiones, cifrados y certificados; otros protocolos tienen sus propios saludos.

**Claves:**
- TCP: SYN → SYN/ACK → ACK establece la conexión.
- TLS: ClientHello → ServerHello → certificado → claves de sesión.
- Un saludo incompleto o repetido puede indicar escaneo o denegación de servicio.
- Los identificadores de sesión permiten seguir una conversación en la captura.

**En el curso:** se observa en [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [RFC 9293 — TCP](https://www.rfc-editor.org/rfc/rfc9293) · [RFC 8446 — TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446) · [Cloudflare — TLS handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/)

---

### 3.4 DNS

DNS traduce nombres a direcciones y publica otros registros (MX, TXT, CNAME). Es un sistema jerárquico y distribuido; sin él, la mayoría de servicios sería inutilizable.

**Claves:**
- Resolución: cliente → resolver → raíz → TLD → autoritativo.
- Registros habituales: A, AAAA, CNAME, MX, TXT, NS, SOA, PTR.
- UDP/53 para consultas y TCP/53 para respuestas grandes o transferencias de zona.
- Es un canal habitual de *command and control* y de exfiltración.

**En el curso:** [Ethical Hacking](../../ethical-hacking/03-reconocimiento-y-osint-tecnico/README.md) y análisis de C2 en [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [RFC 1034](https://www.rfc-editor.org/rfc/rfc1034) · [RFC 1035](https://www.rfc-editor.org/rfc/rfc1035) · [IANA — DNS parameters](https://www.iana.org/assignments/dns-parameters/)

---

### 3.5 DHCP

DHCP asigna automáticamente direcciones IP, máscara, puerta de enlace y servidores DNS. El cliente descubre servidores, solicita una oferta y confirma la concesión.

**Claves:**
- Proceso DORA: Discover, Offer, Request, Acknowledge.
- La concesión tiene duración y debe renovarse.
- Un servidor DHCP no autorizado puede entregar una puerta de enlace maliciosa.
- Sus registros permiten saber qué equipo tuvo qué IP y cuándo.

**En el curso:** relevante para atribuir actividad a un host en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 2131](https://www.rfc-editor.org/rfc/rfc2131) · [RFC 8415 — DHCPv6](https://www.rfc-editor.org/rfc/rfc8415) · [Microsoft Learn — DHCP](https://learn.microsoft.com/en-us/windows-server/networking/technologies/dhcp/dhcp-top)

---

### 3.6 ARP

ARP resuelve una dirección IP a una MAC dentro de la red local. El equipo pregunta quién tiene una IP y el propietario responde con su MAC.

**Claves:**
- Sin ARP no se puede entregar una trama Ethernet a un vecino.
- ARP no tiene autenticación: es vulnerable a *spoofing* y envenenamiento de caché.
- La tabla ARP (`arp -a`, `ip neigh`) muestra las correspondencias actuales.
- El envenenamiento ARP habilita ataques de intermediario en la LAN.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [RFC 826](https://www.rfc-editor.org/rfc/rfc826) · [man7 — arp(8)](https://man7.org/linux/man-pages/man8/arp.8.html) · [Microsoft Learn — arp](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/arp)

---

### 3.7 NTP

NTP sincroniza los relojes de los equipos con una referencia de tiempo. Una diferencia de segundos puede invalidar autenticaciones, romper TLS o desordenar la correlación de logs.

**Claves:**
- Usa UDP/123 y una jerarquía de estratos (*stratum*).
- Kerberos tolera desfases pequeños; superarlos impide autenticar.
- Los logs con relojes distintos no se pueden ordenar sin normalizar.
- NTP puede ser falsificado para alterar la percepción del tiempo.

**En el curso:** crítico para correlacionar eventos en [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [RFC 5905 — NTPv4](https://www.rfc-editor.org/rfc/rfc5905) · [NIST — Time and frequency](https://www.nist.gov/pml/time-and-frequency-division) · [Microsoft Learn — Windows Time](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-top)

---

### 3.8 HTTP y HTTPS

HTTP es el protocolo de la web: el cliente envía una petición (método, ruta, cabeceras) y el servidor responde con un código de estado y un cuerpo. HTTPS es HTTP sobre TLS.

**Claves:**
- Métodos: GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS.
- Códigos: 2xx éxito, 3xx redirección, 4xx error del cliente, 5xx del servidor.
- Las cabeceras transportan cookies, autenticación, tipos de contenido y políticas.
- Sin TLS, todo el contenido viaja en claro y es interceptable.

**En el curso:** [Pentesting Web](../../pentesting-web/01-fundamentos-web-y-http/README.md).

**Fuentes:** [RFC 9110 — HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110) · [RFC 9112 — HTTP/1.1](https://www.rfc-editor.org/rfc/rfc9112) · [MDN — HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP)

---

### 3.9 FTP

FTP transfiere archivos entre cliente y servidor mediante dos canales: control (21) y datos. Modo activo y pasivo cambian quién inicia la conexión de datos.

**Claves:**
- Credenciales y contenido viajan en claro.
- El modo pasivo es el habitual detrás de NAT y firewalls.
- Admite usuarios anónimos, una exposición frecuente en servidores mal configurados.
- Sigue presente en equipos industriales y sistemas legacy.

**En el curso:** aparece en enumeración de servicios de [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [RFC 959 — FTP](https://www.rfc-editor.org/rfc/rfc959) · [RFC 1579 — Passive mode](https://www.rfc-editor.org/rfc/rfc1579) · [IANA — FTP](https://www.iana.org/assignments/service-names-port-numbers/)

---

### 3.10 SFTP

SFTP transfiere archivos sobre SSH y cifra tanto credenciales como contenido. Usa un único canal (TCP/22) y ofrece operaciones de sistema de archivos, reanudación y permisos.

**Claves:**
- No es FTP sobre TLS; es un subsistema distinto dentro de SSH.
- Permite autenticación con clave pública, más segura que una contraseña.
- Se puede restringir a un directorio (*chroot*) y a operaciones concretas.
- Es el reemplazo recomendado de FTP en entornos nuevos.

**En el curso:** alternativa segura en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 4253 — SSH](https://www.rfc-editor.org/rfc/rfc4253) · [OpenSSH — sftp](https://man.openbsd.org/sftp) · [SSH.com — SFTP](https://www.ssh.com/academy/ssh/sftp)

---

### 3.11 FTP frente a SFTP

FTP y SFTP resuelven el mismo problema con garantías distintas. FTP es antiguo, simple y sin cifrado; SFTP reutiliza SSH y hereda su autenticación y su cifrado.

**Claves:**
- FTP: puertos 20/21, credenciales en claro, dos canales.
- SFTP: puerto 22, canal cifrado único, autenticación fuerte.
- FTP puede endurecerse con FTPS (TLS), pero mantiene su arquitectura.
- Migrar a SFTP elimina la exposición de credenciales en la red.

**En el curso:** criterio de selección al revisar servicios.

**Fuentes:** [RFC 959](https://www.rfc-editor.org/rfc/rfc959) · [RFC 4253](https://www.rfc-editor.org/rfc/rfc4253) · [NIST SP 800-45](https://csrc.nist.gov/pubs/sp/800/45/ver2/final)

---

### 3.12 SSH

SSH permite administrar un equipo remoto mediante una sesión cifrada. Autentica al servidor con su clave de host y al usuario con contraseña o clave pública, y puede transportar túneles y otros protocolos.

**Claves:**
- Por defecto usa TCP/22; conviene restringir origen y deshabilitar contraseñas.
- La clave privada nunca se comparte; la pública se instala en el servidor.
- `~/.ssh/authorized_keys` define quién entra y con qué restricciones.
- Los túneles (`-L`, `-R`, `-D`) permiten pivotar entre redes.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md) y administración de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 4251 — SSH architecture](https://www.rfc-editor.org/rfc/rfc4251) · [OpenSSH — Manuals](https://www.openssh.com/manual.html) · [NIST SP 800-53 — Access control](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final)

---

### 3.13 RDP

RDP (*Remote Desktop Protocol*) permite controlar gráficamente un equipo Windows. Usa TCP/3389 (y UDP en versiones modernas) y soporta redirección de recursos, portapapeles y unidades.

**Claves:**
- Es un objetivo habitual de fuerza bruta y de *ransomware*.
- Exponerlo a Internet multiplica el riesgo; debe ir tras VPN o pasarela.
- NLA añade autenticación previa a la sesión.
- Los eventos de inicio de sesión son clave en la investigación.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y respuesta a incidentes.

**Fuentes:** [Microsoft — RDP protocol](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-rdpbcgr/) · [Microsoft — Remote Desktop](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/welcome-to-rds) · [CISA — RDP security](https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-144a)

---

### 3.14 SSL y TLS

SSL y TLS son protocolos criptográficos que dan confidencialidad, integridad y autenticación a una conexión. TLS es el sucesor de SSL y el que se usa hoy.

**Claves:**
- Negocian versión, algoritmos y claves de sesión.
- El certificado del servidor vincula una identidad a una clave pública.
- TLS 1.2 y 1.3 son las versiones aceptables; SSLv3 y TLS 1.0/1.1 están obsoletos.
- Un certificado válido no garantiza que el sitio sea legítimo.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md) y análisis de tráfico.

**Fuentes:** [RFC 8446 — TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446) · [RFC 5246 — TLS 1.2](https://www.rfc-editor.org/rfc/rfc5246) · [NIST SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)

---

### 3.15 SSL frente a TLS

SSL (*Secure Sockets Layer*) fue el protocolo original de Netscape; TLS (*Transport Layer Security*) es su estandarización en la IETF. Las versiones SSL están rotas y no deben usarse.

**Claves:**
- SSL 2.0 y 3.0 están prohibidos; TLS 1.0 y 1.1 también se consideran obsoletos.
- La gente sigue diciendo "SSL" por costumbre, aunque hable de TLS.
- Los nombres de las herramientas conservan "ssl" (`openssl`, `sslyze`).
- Verificar la versión y los cifrados es parte de cualquier auditoría.

**En el curso:** aparece al revisar configuraciones de servidores web.

**Fuentes:** [RFC 8446](https://www.rfc-editor.org/rfc/rfc8446) · [RFC 7568 — Deprecating SSLv3](https://www.rfc-editor.org/rfc/rfc7568) · [NIST SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)

---

### 3.16 SSL/TLS en la práctica

En la práctica, "SSL/TLS" designa el conjunto de decisiones que hacen segura una conexión: versión, cifrados, certificados, validación de nombre y confianza en la cadena.

**Claves:**
- `openssl s_client -connect host:443` muestra versión, cifrado y certificado.
- Una cadena incompleta provoca errores en algunos clientes y no en otros.
- La validación del nombre evita aceptar un certificado válido para otro dominio.
- La revocación (CRL/OCSP) y la fijación de certificados (*pinning*) añaden control.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md) al evaluar HTTPS.

**Fuentes:** [OpenSSL — Documentation](https://docs.openssl.org/master/man1/openssl-s_client/) · [RFC 5280 — PKIX](https://www.rfc-editor.org/rfc/rfc5280) · [OWASP — TLS cheat sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html)

---

### 3.17 Kerberos

Kerberos es un protocolo de autenticación basado en tickets. Un centro de distribución de claves (KDC) emite un ticket de concesión (TGT) y, con él, tickets de servicio para acceder a recursos.

**Claves:**
- El TGT se obtiene tras autenticarse; los tickets de servicio se piden al KDC.
- Los tickets están cifrados con claves derivadas de contraseñas o cuentas de servicio.
- Ataques clásicos: Kerberoasting, AS-REP roasting, *pass-the-ticket*.
- Depende de una sincronización horaria razonable.

**En el curso:** aparece en [CyberSOC](../../cybersoc/README.md) y en entornos Windows.

**Fuentes:** [RFC 4120 — Kerberos V5](https://www.rfc-editor.org/rfc/rfc4120) · [MIT Kerberos — Documentation](https://web.mit.edu/kerberos/krb5-latest/doc/) · [Microsoft — Kerberos](https://learn.microsoft.com/en-us/windows-server/security/kerberos/kerberos-authentication-overview)

---

### 3.18 LDAP

LDAP es un protocolo para consultar y modificar directorios jerárquicos, como Active Directory u OpenLDAP. Representa objetos (usuarios, grupos, equipos) con atributos y un nombre distinguido (DN).

**Claves:**
- Operaciones: bind, search, add, modify, delete.
- El filtro de búsqueda (`(objectClass=user)`) determina qué se devuelve.
- Un *bind* anónimo o con credenciales débiles expone el directorio.
- Los atributos pueden revelar cuentas, grupos y relaciones de confianza.

**En el curso:** enumeración en [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [RFC 4511 — LDAP](https://www.rfc-editor.org/rfc/rfc4511) · [Microsoft — AD LDAP](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/identity/azure-ad) · [OpenLDAP — Admin guide](https://www.openldap.org/doc/admin26/)

---

### 3.19 LDAPS

LDAPS es LDAP sobre TLS. Cifra la sesión y protege credenciales y consultas frente a la interceptación.

**Claves:**
- Puerto convencional 636, frente al 389 de LDAP en claro.
- El servidor debe presentar un certificado válido para el nombre usado.
- También existe StartTLS, que negocia TLS sobre el 389.
- Un cliente mal configurado puede degradar a texto claro sin avisar.

**En el curso:** endurecimiento de directorios y revisión de servicios.

**Fuentes:** [RFC 4513 — LDAP authentication](https://www.rfc-editor.org/rfc/rfc4513) · [RFC 4511](https://www.rfc-editor.org/rfc/rfc4511) · [Microsoft — LDAP over SSL](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)

---

### 3.20 RADIUS

RADIUS centraliza la autenticación, autorización y auditoría (AAA) de accesos a red: VPN, Wi-Fi empresarial, switches y accesos remotos. El cliente (NAS) envía las credenciales al servidor RADIUS.

**Claves:**
- Usa UDP/1812 (autenticación) y UDP/1813 (contabilidad).
- El secreto compartido protege la comunicación entre NAS y servidor.
- Puede consultar directorios (LDAP/AD) para validar usuarios.
- Los registros de contabilidad permiten auditar quién se conectó y cuándo.

**En el curso:** contexto de [CyberSOC](../../cybersoc/README.md) y redes empresariales.

**Fuentes:** [RFC 2865 — RADIUS](https://www.rfc-editor.org/rfc/rfc2865) · [RFC 2866 — Accounting](https://www.rfc-editor.org/rfc/rfc2866) · [FreeRADIUS — Documentation](https://freeradius.org/documentation/)

---

### 3.21 EAP frente a PEAP

EAP (*Extensible Authentication Protocol*) es un marco de autenticación usado en redes; PEAP (*Protected EAP*) es un método concreto que encapsula EAP dentro de TLS.

**Claves:**
- EAP define el intercambio; los métodos (EAP-TLS, EAP-TTLS, PEAP) definen cómo.
- PEAP protege la autenticación con un túnel TLS, normalmente con certificado de servidor.
- Sin validar el certificado del servidor, el cliente es vulnerable a un punto de acceso falso.
- EAP-TLS exige certificado en cliente y servidor; es el método más fuerte.

**En el curso:** seguridad Wi-Fi empresarial en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 3748 — EAP](https://www.rfc-editor.org/rfc/rfc3748) · [RFC 4017 — EAP method requirements](https://www.rfc-editor.org/rfc/rfc4017) · [Microsoft — PEAP](https://learn.microsoft.com/en-us/windows-server/networking/technologies/nps/nps-top)

---

[Requisitos previos](../README.md) · [Siguiente: Red y criptografía](../04-red-y-criptografia/README.md)
