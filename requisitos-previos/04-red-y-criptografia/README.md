# Red y criptografía aplicada

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Protocolos](../03-protocolos-y-servicios/README.md) · [Siguiente: Sistemas operativos](../05-sistemas-operativos/README.md)

Este módulo cubre cómo se separa y se protege el tráfico: segmentación lógica, perímetros, redes inalámbricas, túneles y criptografía. Son conceptos que aparecen tanto al diseñar una red como al explicar por qué un ataque funcionó.

## Contenido

| # | Concepto |
|---|---|
| 4.1 | [VLAN](#41-vlan) |
| 4.2 | [DMZ](#42-dmz) |
| 4.3 | [Perímetro, DMZ y segmentación](#43-perímetro-dmz-y-segmentación) |
| 4.4 | [Control de acceso a red](#44-control-de-acceso-a-red) |
| 4.5 | [Control por MAC](#45-control-por-mac) |
| 4.6 | [WPA, WPA2, WPA3 y WEP](#46-wpa-wpa2-wpa3-y-wep) |
| 4.7 | [WPS](#47-wps) |
| 4.8 | [Wi-Fi](#48-wi-fi) |
| 4.9 | [WLAN](#49-wlan) |
| 4.10 | [Bluetooth](#410-bluetooth) |
| 4.11 | [NFC](#411-nfc) |
| 4.12 | [Infrarrojo](#412-infrarrojo) |
| 4.13 | [NetFlow](#413-netflow) |
| 4.14 | [Jump server](#414-jump-server) |
| 4.15 | [DNSSEC](#415-dnssec) |
| 4.16 | [IPsec](#416-ipsec) |
| 4.17 | [VPN](#417-vpn) |
| 4.18 | [PKI](#418-pki) |
| 4.19 | [Certificados](#419-certificados) |
| 4.20 | [Intercambio de claves](#420-intercambio-de-claves) |
| 4.21 | [Claves públicas y privadas](#421-claves-públicas-y-privadas) |
| 4.22 | [S/MIME](#422-smime) |
| 4.23 | [SRTP](#423-srtp) |

---

### 4.1 VLAN

Una VLAN es una red local lógica construida sobre infraestructura física compartida. El switch etiqueta las tramas (802.1Q) y las mantiene separadas aunque usen los mismos cables.

**Claves:**
- Cada VLAN es un dominio de broadcast independiente.
- Los enlaces entre switches se configuran como *trunk* para transportar varias VLAN.
- La separación lógica reduce el movimiento lateral, pero no sustituye un firewall.
- Un puerto mal asignado o un *trunk* mal filtrado expone segmentos completos.

**En el curso:** base de la segmentación de [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [IEEE 802.1Q](https://standards.ieee.org/ieee/802.1Q/10323/) · [Cisco — VLANs](https://www.cisco.com/c/en/us/tech/lan-switching/vlan/index.html) · [Cloudflare — VLAN](https://www.iana.org/assignments/ieee-802-numbers/)

---

### 4.2 DMZ

La DMZ (*zona desmilitarizada*) es un segmento intermedio entre Internet y la red interna donde se publican servicios accesibles desde fuera. Si un servicio se compromete, el atacante no está directamente dentro.

**Claves:**
- Se implementa con dos firewalls o con un firewall de múltiples zonas.
- Solo se abre el tráfico estrictamente necesario hacia la red interna.
- Los servicios publicados deben parchearse con prioridad.
- Una DMZ mal diseñada se convierte en trampolín hacia dentro.

**En el curso:** arquitectura de [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-41 — Firewalls](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [Cisco — DMZ](https://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/110117-asa-dmz-00.html) · [Cloudflare — DMZ](https://learn.microsoft.com/en-us/azure/firewall/overview)

---

### 4.3 Perímetro, DMZ y segmentación

El perímetro es la frontera entre lo confiable y lo no confiable; la DMZ es el segmento publicado; la segmentación divide la red interna en zonas con políticas distintas.

**Claves:**
- El perímetro tradicional se diluye con cloud, teletrabajo y SaaS.
- Segmentar limita el impacto: un equipo comprometido no alcanza todo.
- Las políticas se aplican en firewalls, VLAN, ACL y autenticación de red.
- Zero Trust lleva la idea al extremo: no hay red "de confianza".

**En el curso:** diseño de red y respuesta a incidentes.

**Fuentes:** [NIST SP 800-207 — Zero Trust](https://csrc.nist.gov/pubs/sp/800/207/final) · [NIST SP 800-41](https://csrc.nist.gov/pubs/sp/800/41/r1/final) · [CISA — Segmentation](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 4.4 Control de acceso a red

NAC (*Network Access Control*) decide si un dispositivo puede entrar en la red y con qué nivel de acceso, antes de asignarle una dirección. Combina autenticación, evaluación del estado del equipo y políticas.

**Claves:**
- Puede usar 802.1X, portales cautivos o agentes.
- Evalúa parches, antivirus y configuración antes de admitir.
- Permite cuarentena en lugar de denegación total.
- Un NAC mal desplegado bloquea equipos legítimos o deja pasar los no gestionados.

**En el curso:** contexto empresarial de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-53 — Access control](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) · [Cisco — NAC](https://www.cisco.com/c/en/us/products/security/identity-services-engine/index.html) · [IEEE 802.1X](https://standards.ieee.org/ieee/802.1X/7345/)

---

### 4.5 Control por MAC

El filtrado por MAC permite o bloquea dispositivos según su dirección física. Es fácil de configurar y fácil de eludir, porque la MAC se puede falsificar.

**Claves:**
- Se usa en redes pequeñas o como capa adicional, no como control principal.
- La MAC se cambia con software en la mayoría de sistemas.
- Las tablas de conmutación se construyen aprendiendo MAC de origen.
- MAC flooding satura esa tabla y convierte el switch en un hub.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [IEEE 802](https://standards.ieee.org/ieee/802/7333/) · [NIST — Guide to LAN security](https://csrc.nist.gov/pubs/sp/800/97/final) · [Cisco — Port security](https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst9300/software/release/17-9/configuration_guide/sec/b_179_sec_9300_cg/configuring_port_security.html)

---

### 4.6 WPA, WPA2, WPA3 y WEP

Son protocolos de seguridad Wi-Fi. WEP está roto; WPA fue una corrección intermedia; WPA2 (AES-CCMP) sigue siendo común; WPA3 añade SAE y mejora la protección en redes abiertas.

**Claves:**
- WEP se rompe en minutos; nunca debe usarse.
- WPA2-PSK es vulnerable a ataques de diccionario sobre el handshake.
- WPA3-SAE resiste esos ataques sin conexión.
- WPA2-Enterprise usa 802.1X y RADIUS, con credenciales por usuario.

**En el curso:** seguridad inalámbrica en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Wi-Fi Alliance — Security](https://www.wi-fi.org/discover-wi-fi/security) · [IEEE 802.11](https://standards.ieee.org/ieee/802.11/10549/) · [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final)

---

### 4.7 WPS

WPS (*Wi-Fi Protected Setup*) simplifica la conexión con PIN o botón. El PIN de ocho dígitos se valida en dos mitades, lo que reduce drásticamente el espacio de búsqueda.

**Claves:**
- El ataque de PIN permite recuperar la clave en horas o menos.
- Muchos routers lo dejan activo por comodidad.
- Se recomienda deshabilitarlo.
- WPS no aporta seguridad; solo facilidad de configuración.

**En el curso:** auditoría Wi-Fi en [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [Wi-Fi Alliance — WPS](https://www.wi-fi.org/discover-wi-fi/wi-fi-protected-setup) · [CISA — Wi-Fi security](https://www.cisa.gov/topics/cybersecurity-best-practices) · [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final)

---

### 4.8 Wi-Fi

Wi-Fi es la tecnología inalámbrica basada en IEEE 802.11. El medio es compartido y abierto: cualquiera dentro del alcance puede escuchar tramas y intentar asociarse.

**Claves:**
- Bandas de 2,4, 5 y 6 GHz con alcance y capacidad distintos.
- La seguridad depende del protocolo (WPA2/WPA3) y de la configuración.
- Puntos de acceso falsos y *evil twins* explotan la confianza del usuario.
- La cobertura debe planificarse para no filtrar señal fuera del perímetro.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y pruebas inalámbricas.

**Fuentes:** [IEEE 802.11](https://standards.ieee.org/ieee/802.11/10549/) · [Wi-Fi Alliance](https://www.wi-fi.org/) · [NIST SP 800-153](https://csrc.nist.gov/pubs/sp/800/153/final)

---

### 4.9 WLAN

Una WLAN es una red local inalámbrica: un conjunto de dispositivos que se comunican por radio usando 802.11. Puede ser independiente (*ad hoc*) o infraestructura con puntos de acceso.

**Claves:**
- El SSID identifica la red; ocultarlo no aporta seguridad real.
- Los puntos de acceso se conectan a la red cableada y extienden el dominio.
- La autenticación empresarial usa 802.1X frente a la clave compartida.
- Un AP no autorizado crea un puente hacia la red interna.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [IEEE 802.11](https://standards.ieee.org/ieee/802.11/10549/) · [Cisco — WLAN](https://www.cisco.com/c/en/us/tech/wireless/index.html) · [Wi-Fi Alliance](https://www.wi-fi.org/)

---

### 4.10 Bluetooth

Bluetooth es un estándar de radio de corto alcance para conectar periféricos y dispositivos cercanos. Evoluciona por versiones (hasta Bluetooth 5.x) con mejoras de alcance, velocidad y seguridad.

**Claves:**
- Emparejamiento: intercambio de claves y confirmación del vínculo.
- Riesgos: *bluejacking*, *bluesnarfing* y dispositivos en modo descubrible.
- BLE (*Bluetooth Low Energy*) se usa en sensores y *beacons*.
- Mantener el dispositivo no descubrible reduce la exposición.

**En el curso:** superficie de ataque de dispositivos en [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [Bluetooth SIG — Specifications](https://www.bluetooth.com/specifications/) · [NIST — Bluetooth security](https://csrc.nist.gov/pubs/sp/800/121/final) · [CISA — Bluetooth](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 4.11 NFC

NFC (*Near Field Communication*) permite intercambio de datos a pocos centímetros. Se usa en pagos, control de acceso y emparejamiento rápido.

**Claves:**
- Alcance muy corto, lo que limita la interceptación a distancia.
- Riesgo de *relay*: un atacante extiende la distancia con dos dispositivos.
- Los datos pueden leerse sin contacto si la tarjeta no está protegida.
- Su seguridad depende de la aplicación, no solo del estándar.

**En el curso:** cultura de superficies de ataque físicas.

**Fuentes:** [NFC Forum — Specifications](https://nfc-forum.org/our-work/specifications-and-application-documents/) · [ISO/IEC 18092](https://www.iso.org/standard/56692.html) · [NIST — Mobile security](https://csrc.nist.gov/pubs/sp/800/163/final)

---

### 4.12 Infrarrojo

El infrarrojo es una tecnología de comunicación óptica de muy corto alcance que requiere línea de visión. Fue común en mandos y periféricos; hoy es residual.

**Claves:**
- No atraviesa paredes ni obstáculos.
- No hay cifrado por defecto en los usos domésticos.
- Su superficie de ataque es física y local.
- Aparece en inventarios de conectividad y en preguntas de certificación.

**En el curso:** complemento de conceptos de conectividad.

**Fuentes:** [IrDA — Standards](https://www.cisco.com/c/en/us/tech/wireless/index.html) · [IEEE 802.11 — Wireless](https://standards.ieee.org/ieee/802.11/10549/) · [NIST — Wireless security](https://csrc.nist.gov/pubs/sp/800/153/final)

---

### 4.13 NetFlow

NetFlow (y sus equivalentes IPFIX, sFlow y J-Flow) resume el tráfico en registros: origen, destino, puertos, protocolo, bytes y tiempo. No guarda el contenido, pero describe el comportamiento.

**Claves:**
- Permite detectar volumen anómalo, destinos raros y escaneos.
- IPFIX es el estándar IETF derivado de NetFlow v9.
- Los registros se exportan a colectores y se correlacionan en el SIEM.
- Sin retención suficiente, el análisis retrospectivo es imposible.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [RFC 7011 — IPFIX](https://www.rfc-editor.org/rfc/rfc7011) · [Cisco — NetFlow](https://www.cisco.com/c/en/us/products/ios-nx-os-software/ios-netflow/index.html) · [NIST SP 800-92 — Log management](https://csrc.nist.gov/pubs/sp/800/92/final)

---

### 4.14 Jump server

Un *jump server* (o bastión) es un equipo intermedio obligatorio para administrar sistemas en una red protegida. Centraliza el acceso, la autenticación y la auditoría.

**Claves:**
- Reduce el número de rutas directas hacia los servidores.
- Registra comandos y sesiones para auditoría.
- Debe endurecerse y monitorizarse como activo crítico.
- Comprometerlo equivale a comprometer el acceso administrativo.

**En el curso:** administración de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-53 — Access control](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) · [CISA — Zero Trust](https://www.cisa.gov/zero-trust-maturity-model) · [Microsoft — Bastion](https://learn.microsoft.com/en-us/azure/bastion/bastion-overview)

---

### 4.15 DNSSEC

DNSSEC firma criptográficamente los registros DNS para que el resolver pueda verificar que la respuesta es auténtica y no fue alterada.

**Claves:**
- No cifra las consultas: añade autenticidad e integridad.
- Usa claves de zona (ZSK y KSK) y una cadena de confianza desde la raíz.
- Un fallo de firma o de configuración puede dejar un dominio inaccesible.
- No sustituye a DNS over HTTPS/TLS, que aporta confidencialidad.

**En el curso:** seguridad de resolución en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 4033](https://www.rfc-editor.org/rfc/rfc4033) · [ICANN — DNSSEC](https://www.icann.org/resources/pages/dnssec-what-is-it-why-important-2019-03-05-en) · [NIST SP 800-81-2](https://www.nist.gov/publications/secure-domain-name-system-dns-deployment-guide)

---

### 4.16 IPsec

IPsec protege el tráfico IP a nivel de red. Autentica y cifra paquetes mediante dos protocolos: AH (autenticación) y ESP (cifrado). Se usa en VPN de sitio a sitio y de acceso remoto.

**Claves:**
- Modo transporte protege extremo a extremo; modo túnel protege entre pasarelas.
- IKE negocia las asociaciones de seguridad (SA).
- Funciona en capa 3, por lo que es transparente a las aplicaciones.
- Una configuración débil de IKE permite degradar o romper la seguridad.

**En el curso:** VPN y arquitectura de [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [RFC 4301 — IPsec](https://www.rfc-editor.org/rfc/rfc4301) · [RFC 7296 — IKEv2](https://www.rfc-editor.org/rfc/rfc7296) · [NIST SP 800-77 Rev. 1](https://csrc.nist.gov/pubs/sp/800/77/r1/final)

---

### 4.17 VPN

Una VPN crea un túnel cifrado entre un cliente y una red, o entre dos redes, para transportar tráfico sobre una infraestructura no confiable. No anonimiza por sí sola.

**Claves:**
- VPN de acceso remoto frente a VPN de sitio a sitio.
- Protocolos habituales: IPsec/IKEv2, WireGuard, OpenVPN, SSL-VPN.
- El proveedor o el concentrador ve el tráfico del cliente.
- Una VPN corporativa puede convertirse en el punto de entrada si no se segmenta.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-77 Rev. 1](https://csrc.nist.gov/pubs/sp/800/77/r1/final) · [WireGuard — Documentation](https://www.wireguard.com/) · [OpenVPN — Documentation](https://openvpn.net/community-resources/)

---

### 4.18 PKI

La infraestructura de clave pública (PKI) gestiona identidades digitales: emite, renueva y revoca certificados, y define autoridades de certificación y políticas.

**Claves:**
- Una CA raíz firma certificados de CAs intermedias.
- Las políticas (CP/CPS) definen cómo se valida una identidad.
- La revocación (CRL/OCSP) gestiona certificados comprometidos.
- Toda la confianza de TLS depende de esta cadena.

**En el curso:** TLS y certificados en [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [RFC 5280 — PKIX](https://www.rfc-editor.org/rfc/rfc5280) · [NIST SP 800-32](https://csrc.nist.gov/pubs/sp/800/32/final) · [Let's Encrypt — How it works](https://letsencrypt.org/how-it-works/)

---

### 4.19 Certificados

Un certificado digital vincula una clave pública a una identidad y a un periodo de validez. Incluye nombre, emisor, usos permitidos y la firma de la CA.

**Claves:**
- Campos clave: sujeto, emisor, validez, clave pública, extensiones (SAN, EKU).
- Un certificado caducado o con nombre incorrecto rompe TLS.
- Las extensiones determinan si sirve para servidor, cliente o firma de código.
- La validación incluye cadena, nombre, fecha y revocación.

**En el curso:** revisión de HTTPS en [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [RFC 5280](https://www.rfc-editor.org/rfc/rfc5280) · [CA/Browser Forum — Baseline Requirements](https://cabforum.org/working-groups/server/baseline-requirements/) · [Microsoft — Certificate overview](https://learn.microsoft.com/en-us/windows-server/security/windows-authentication/windows-authentication-overview)

---

### 4.20 Intercambio de claves

El intercambio de claves permite a dos partes acordar una clave secreta sin transmitirla. Diffie-Hellman y sus variantes (ECDHE) son la base de las sesiones TLS modernas.

**Claves:**
- Diffie-Hellman clásico es vulnerable a intermediarios si no se autentica.
- ECDHE aporta *forward secrecy*: comprometer la clave privada no descifra sesiones pasadas.
- TLS 1.3 usa exclusivamente intercambio efímero.
- Una implementación débil o parámetros pequeños comprometen todo el canal.

**En el curso:** fundamento de TLS en [Pentesting Web](../../pentesting-web/README.md).

**Fuentes:** [RFC 7748 — X25519](https://www.rfc-editor.org/rfc/rfc7748) · [RFC 8446 — TLS 1.3](https://www.rfc-editor.org/rfc/rfc8446) · [NIST SP 800-56A](https://csrc.nist.gov/pubs/sp/800/56/a/r3/final)

---

### 4.21 Claves públicas y privadas

En criptografía asimétrica hay dos claves relacionadas: la privada se guarda y la pública se distribuye. Lo cifrado con una se descifra con la otra.

**Claves:**
- Firmar: se firma con la privada y se verifica con la pública.
- Cifrar: se cifra con la pública del destinatario y él descifra con su privada.
- La privada nunca se comparte ni se exporta sin protección.
- La integridad de la pública se garantiza con certificados.

**En el curso:** SSH y TLS en [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [NIST SP 800-57 Part 1](https://csrc.nist.gov/pubs/sp/800/57/pt1/r5/final) · [RFC 5280](https://www.rfc-editor.org/rfc/rfc5280) · [OpenSSH — Key management](https://www.openssh.com/manual.html)

---

### 4.22 S/MIME

S/MIME firma y cifra correo electrónico usando certificados X.509. La firma acredita el origen y la integridad; el cifrado protege el contenido en tránsito y en reposo.

**Claves:**
- Requiere certificados de usuario emitidos por una CA.
- La firma no cifra; el cifrado no autentica por sí solo.
- Un certificado caducado impide verificar correctamente.
- Su despliegue es complejo, por eso compite con soluciones de puerta de enlace.

**En el curso:** seguridad del correo en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 8551 — S/MIME 4.0](https://www.rfc-editor.org/rfc/rfc8551) · [RFC 5751 — S/MIME 3.2](https://www.rfc-editor.org/rfc/rfc5751) · [NIST SP 800-177](https://csrc.nist.gov/pubs/sp/800/177/r1/final)

---

### 4.23 SRTP

SRTP (*Secure Real-time Transport Protocol*) cifra y autentica flujos de audio y vídeo en tiempo real, añadiendo protección a RTP. Se usa en VoIP y videoconferencia.

**Claves:**
- Cifra la carga útil y autentica el paquete; no protege la señalización.
- La clave se negocia con SDES o, preferiblemente, con DTLS-SRTP.
- Sin SRTP, una llamada puede escucharse o manipularse en la red.
- La señalización (SIP) debe protegerse aparte con TLS.

**En el curso:** comunicaciones en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 3711 — SRTP](https://www.rfc-editor.org/rfc/rfc3711) · [RFC 5764 — DTLS-SRTP](https://www.rfc-editor.org/rfc/rfc5764) · [NIST SP 800-58](https://csrc.nist.gov/pubs/sp/800/58/final)

---

[Requisitos previos](../README.md) · [Siguiente: Sistemas operativos](../05-sistemas-operativos/README.md)
