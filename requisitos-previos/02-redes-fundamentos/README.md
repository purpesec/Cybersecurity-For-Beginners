# Redes: fundamentos y direccionamiento

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Fundamentos IT](../01-fundamentos-it/README.md) · [Siguiente: Protocolos](../03-protocolos-y-servicios/README.md)

Casi todo ataque y casi toda defensa atraviesan una red. Antes de hablar de puertos, protocolos o firewalls conviene entender cómo se identifican los equipos, cómo se agrupan y cómo viaja un paquete. Este módulo cubre ese nivel: direccionamiento, subredes, dispositivos y topologías.

## Contenido

| # | Concepto |
|---|---|
| 2.1 | [Conocimientos de redes](#21-conocimientos-de-redes) |
| 2.2 | [Fundamentos de redes](#22-fundamentos-de-redes) |
| 2.3 | [Modelo OSI](#23-modelo-osi) |
| 2.4 | [Direcciones IP](#24-direcciones-ip) |
| 2.5 | [Direcciones públicas y privadas](#25-direcciones-públicas-y-privadas) |
| 2.6 | [localhost](#26-localhost) |
| 2.7 | [Loopback](#27-loopback) |
| 2.8 | [Puerta de enlace predeterminada](#28-puerta-de-enlace-predeterminada) |
| 2.9 | [Máscara de subred](#29-máscara-de-subred) |
| 2.10 | [CIDR](#210-cidr) |
| 2.11 | [Subnetting](#211-subnetting) |
| 2.12 | [IPAM](#212-ipam) |
| 2.13 | [LAN](#213-lan) |
| 2.14 | [WAN](#214-wan) |
| 2.15 | [Ruta](#215-ruta) |
| 2.16 | [Router](#216-router) |
| 2.17 | [Switch](#217-switch) |
| 2.18 | [NAT](#218-nat) |
| 2.19 | [Tipos de conexión](#219-tipos-de-conexión) |
| 2.20 | [Topología en bus](#220-topología-en-bus) |
| 2.21 | [Topología en anillo](#221-topología-en-anillo) |
| 2.22 | [Topología en estrella](#222-topología-en-estrella) |
| 2.23 | [Topología en malla](#223-topología-en-malla) |

---

### 2.1 Conocimientos de redes

Saber redes significa entender cómo dos equipos se encuentran, se identifican y se comunican: direcciones, rutas, protocolos, puertos y dispositivos intermedios. Es la base para leer un escaneo, interpretar una captura o diseñar una segmentación.

**Claves:**
- Sin direccionamiento no hay comunicación; sin rutas, no hay alcance.
- Los protocolos definen el formato y el orden de los mensajes.
- La seguridad de red se apoya en conocer qué tráfico es normal.
- Un error de red se diagnostica por capas: enlace, IP, transporte y aplicación.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Cisco — Networking basics](https://www.cisco.com/c/en/us/solutions/small-business/resource-center/networking/networking-basics.html) · [Cloudflare Learning — Network layer](https://www.cloudflare.com/learning/network-layer/) · [IANA — Protocol registries](https://www.iana.org/protocols)

---

### 2.2 Fundamentos de redes

Una red es un conjunto de dispositivos conectados que intercambian datos mediante reglas comunes. Los elementos mínimos son el medio (cable o radio), la dirección (quién es quién), el protocolo (cómo se habla) y el dispositivo que encamina (cómo se llega).

**Claves:**
- Un paquete lleva origen, destino y datos; los dispositivos intermedios deciden por dónde enviarlo.
- La comunicación se divide en capas para que cada problema se resuelva por separado.
- Ancho de banda, latencia y pérdida de paquetes explican la mayoría de los síntomas.
- En laboratorio se usa una red aislada para que el tráfico no escape a Internet.

**En el curso:** [setup](../../setup/README.md) define la red host-only de los laboratorios.

**Fuentes:** [Cisco — What is networking?](https://www.cisco.com/c/en/us/solutions/enterprise-networks/what-is-computer-networking.html) · [RFC 1122 — Internet hosts](https://www.rfc-editor.org/rfc/rfc1122) · [Cloudflare Learning — What is a network?](https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/)

---

### 2.3 Modelo OSI

El modelo OSI divide la comunicación en siete capas: física, enlace de datos, red, transporte, sesión, presentación y aplicación. No es un protocolo, sino un marco para razonar sobre dónde falla o dónde actúa una tecnología.

**Claves:**
- Capa 2 (enlace): MAC, Ethernet, VLAN, switches.
- Capa 3 (red): IP, ICMP, routers.
- Capa 4 (transporte): TCP y UDP, puertos.
- Capas 5-7: sesiones, cifrado y aplicaciones (HTTP, DNS, SSH).
- Un firewall puede filtrar por capa 3, 4 o 7 según su tipo.

**En el curso:** se usa para ubicar herramientas y ataques en [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [ISO/IEC 7498-1](https://www.iso.org/standard/20269.html) · [Cloudflare — OSI model](https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/) · [Cisco — OSI model](https://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/113601-asa-osi-model-00.html)

---

### 2.4 Direcciones IP

Una dirección IP identifica una interfaz en una red. IPv4 usa 32 bits en cuatro octetos (`192.168.1.10`); IPv6 usa 128 bits en notación hexadecimal. La dirección se compone de red y host según la máscara.

**Claves:**
- IPv4 tiene ~4.300 millones de direcciones; IPv6 nació para ampliar ese espacio.
- Una interfaz puede tener varias direcciones (IPv4, IPv6, alias).
- La dirección identifica la interfaz, no a la persona ni al equipo físico.
- En un incidente, la IP es un dato de correlación, no una identidad.

**En el curso:** base de los escaneos de [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md) y de los logs de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [RFC 791 — IPv4](https://www.rfc-editor.org/rfc/rfc791) · [RFC 8200 — IPv6](https://www.rfc-editor.org/rfc/rfc8200) · [IANA — IPv4/IPv6 registries](https://www.iana.org/numbers)

---

### 2.5 Direcciones públicas y privadas

Las direcciones privadas (RFC 1918) se usan dentro de redes internas y no son enrutables en Internet: `10.0.0.0/8`, `172.16.0.0/12` y `192.168.0.0/16`. Las públicas son asignadas globalmente y permiten alcanzar destinos externos.

**Claves:**
- NAT traduce privadas a públicas para salir a Internet.
- Un equipo interno no es accesible desde fuera salvo que se publique un puerto.
- Muchos rangos privados repetidos en distintas organizaciones complican la correlación.
- `127.0.0.0/8` es reservado para loopback, no es privado en el sentido de RFC 1918.

**En el curso:** los laboratorios usan `192.168.56.0/24` en [setup](../../setup/README.md).

**Fuentes:** [RFC 1918](https://www.rfc-editor.org/rfc/rfc1918) · [IANA — IPv4 special registry](https://www.iana.org/assignments/iana-ipv4-special-registry/) · [Cloudflare — Private IP](https://www.cloudflare.com/learning/network-layer/what-is-an-ip-address/)

---

### 2.6 localhost

`localhost` es el nombre que resuelve a la dirección de loopback del propio equipo, convencionalmente `127.0.0.1` en IPv4 y `::1` en IPv6. Se usa para acceder a servicios que escuchan solo en la máquina local.

**Claves:**
- No pasa por la red física: el tráfico se queda en el equipo.
- Un servicio en `127.0.0.1` no es accesible desde otra máquina, salvo túnel o proxy.
- Es habitual en paneles de administración y bases de datos locales.
- En un servidor comprometido, servicios en localhost pueden alcanzarse mediante *port forwarding*.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md) ejecuta aplicaciones locales en este modo.

**Fuentes:** [RFC 6761 — Special-use names](https://www.rfc-editor.org/rfc/rfc6761) · [RFC 1122 — Loopback](https://www.rfc-editor.org/rfc/rfc1122) · [man7 — hosts(5)](https://man7.org/linux/man-pages/man5/hosts.5.html)

---

### 2.7 Loopback

La interfaz de loopback es una interfaz virtual que devuelve el tráfico a la propia máquina. En Linux suele llamarse `lo` y siempre está activa; permite probar servicios sin depender de la red externa.

**Claves:**
- `127.0.0.1/8` y `::1/128` son rangos reservados para loopback.
- Sirve para diagnosticar la pila TCP/IP sin salir del equipo.
- El tráfico de loopback no aparece en la red, pero sí en las capturas de la interfaz `lo`.
- Herramientas que escuchan en `0.0.0.0` aceptan conexiones de cualquier interfaz, incluida la externa.

**En el curso:** se usa al probar servicios de laboratorio y al analizar malware en [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [RFC 1122](https://www.rfc-editor.org/rfc/rfc1122) · [man7 — loopback(4)](https://man7.org/linux/man-pages/man8/ip-address.8.html) · [Linux kernel — Networking](https://www.kernel.org/doc/html/latest/networking/index.html)

---

### 2.8 Puerta de enlace predeterminada

La puerta de enlace (*default gateway*) es el router al que el equipo envía el tráfico cuyo destino no está en su propia red. Sin ella, solo se puede comunicar dentro de la subred local.

**Claves:**
- Se consulta con `ip route` en Linux o `ipconfig` en Windows.
- Debe pertenecer a la misma subred que la interfaz.
- Si falta o es incorrecta, hay conectividad local pero no salida a otras redes.
- Es un punto crítico: comprometerla permite interceptar o redirigir tráfico.

**En el curso:** se configura en [setup](../../setup/README.md) para la red host-only.

**Fuentes:** [RFC 1122](https://www.rfc-editor.org/rfc/rfc1122) · [Microsoft Learn — ipconfig](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ipconfig) · [man7 — ip-route(8)](https://man7.org/linux/man-pages/man8/ip-route.8.html)

---

### 2.9 Máscara de subred

La máscara indica cuántos bits de una dirección IPv4 identifican la red y cuántos el host. `255.255.255.0` equivale a `/24`: 24 bits de red y 8 de host.

**Claves:**
- La máscara se aplica con AND lógico para obtener la dirección de red.
- Define el tamaño del rango: `/24` admite 254 hosts utilizables.
- Una máscara incorrecta produce fallos de comunicación difíciles de diagnosticar.
- En IPv6 el concepto equivalente es el prefijo (`/64` habitual en LAN).

**En el curso:** se practica con [basics-of-subnetting](#211-subnetting) y en [setup](../../setup/README.md).

**Fuentes:** [RFC 950](https://www.rfc-editor.org/rfc/rfc950) · [Cisco — Subnet masks](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html) · [Microsoft Learn — TCP/IP addressing](https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/tcpip-addressing-and-subnetting)

---

### 2.10 CIDR

CIDR (*Classless Inter-Domain Routing*) sustituyó las clases A, B y C por prefijos de longitud variable. Se escribe como `192.168.1.0/24`; el número tras la barra indica los bits de red.

**Claves:**
- Permite asignar bloques ajustados a la necesidad real.
- Agrega rutas: un solo prefijo puede representar muchos rangos contiguos.
- `/31` se usa en enlaces punto a punto; `/32` identifica un host.
- Un prefijo mal calculado puede incluir direcciones ajenas o excluir las propias.

**En el curso:** base para entender alcances de escaneo en [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [RFC 4632 — CIDR](https://www.rfc-editor.org/rfc/rfc4632) · [RFC 1519](https://www.rfc-editor.org/rfc/rfc1519) · [Cloudflare — What is CIDR?](https://www.cloudflare.com/learning/network-layer/what-is-cidr/)

---

### 2.11 Subnetting

Subnetting es dividir una red en subredes más pequeñas tomando bits del campo de host. Se usa para separar tráfico, reducir dominios de broadcast y aplicar políticas de seguridad.

**Claves:**
- Cada subred tiene dirección de red y de broadcast; en IPv4 clásico no se asignan a hosts.
- La fórmula `2^n` indica cuántas subredes se crean al tomar `n` bits.
- La segmentación limita el movimiento lateral de un atacante.
- En IPv6 no se usa broadcast y la práctica habitual es asignar `/64` por segmento.

**En el curso:** se aplica al diseñar la red host-only y al interpretar escaneos.

**Fuentes:** [RFC 950](https://www.rfc-editor.org/rfc/rfc950) · [Cisco — Subnetting](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html) · [Microsoft Learn — Subnetting](https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/tcpip-addressing-and-subnetting)

---

### 2.12 IPAM

IPAM (*IP Address Management*) es la disciplina y las herramientas para planificar, asignar y documentar direcciones IP, subredes, VLAN y nombres. Evita duplicados, rangos huérfanos y conflictos.

**Claves:**
- Mantiene el inventario de qué dirección pertenece a qué equipo y desde cuándo.
- Se integra con DHCP y DNS para asignar y resolver automáticamente.
- Sin IPAM, un escaneo puede atribuir tráfico a un equipo equivocado.
- En respuesta a incidentes, el histórico de asignaciones es evidencia.

**En el curso:** útil para documentar la topología de [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [RFC 4007](https://www.rfc-editor.org/rfc/rfc4007) · [Microsoft Learn — IPAM](https://learn.microsoft.com/en-us/windows-server/networking/technologies/ipam/ipam-top) · [Infoblox — What is IPAM?](https://www.iana.org/assignments/ipv4-address-space)

---

### 2.13 LAN

Una LAN (*Local Area Network*) conecta dispositivos dentro de un área limitada, como una oficina o un laboratorio. Suele ser de alta velocidad, baja latencia y administración propia.

**Claves:**
- Los equipos comparten un dominio de broadcast salvo que se segmenten con VLAN.
- Ethernet y Wi-Fi son las tecnologías dominantes.
- La seguridad depende de la segmentación, el control de acceso y la monitorización.
- Un laboratorio de prácticas es una LAN aislada por diseño.

**En el curso:** [setup](../../setup/README.md) define la LAN de laboratorio.

**Fuentes:** [Cisco — What is a LAN?](https://www.cisco.com/c/en/us/products/switches/what-is-a-lan-local-area-network.html) · [IEEE 802.3](https://standards.ieee.org/ieee/802.3/7071/) · [Cloudflare — LAN](https://www.cloudflare.com/learning/network-layer/what-is-a-lan/)

---

### 2.14 WAN

Una WAN (*Wide Area Network*) interconecta redes separadas geográficamente. Internet es la WAN más grande; las organizaciones usan también enlaces dedicados, MPLS o VPN sobre Internet.

**Claves:**
- La latencia y la pérdida de paquetes son mayores que en una LAN.
- El tráfico cruza infraestructura de terceros; el cifrado es habitual.
- Las VPN extienden la LAN sobre la WAN.
- Un enlace WAN comprometido permite interceptar o alterar comunicaciones.

**En el curso:** explica por qué los laboratorios se aíslan de Internet.

**Fuentes:** [Cisco — What is a WAN?](https://www.cisco.com/c/en/us/products/routers/what-is-a-wan-wide-area-network.html) · [Cloudflare — WAN](https://www.cloudflare.com/learning/network-layer/what-is-a-wan/) · [RFC 791](https://www.rfc-editor.org/rfc/rfc791)

---

### 2.15 Ruta

Una ruta es la regla que indica por qué interfaz o vecino enviar el tráfico hacia un destino. La tabla de rutas contiene redes conocidas, máscaras, puertas de enlace y métricas.

**Claves:**
- La ruta más específica (prefijo más largo) gana.
- `ip route` (Linux) y `route print` (Windows) muestran la tabla.
- Las rutas pueden ser estáticas o aprendidas por protocolos dinámicos.
- Una ruta mal configurada puede enviar tráfico sensible por un camino no previsto.

**En el curso:** se inspecciona en [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md) y en [setup](../../setup/README.md).

**Fuentes:** [RFC 1812 — Routers](https://www.rfc-editor.org/rfc/rfc1812) · [man7 — ip-route(8)](https://man7.org/linux/man-pages/man8/ip-route.8.html) · [Microsoft Learn — route](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/route_ws2008)

---

### 2.16 Router

El router conecta redes distintas y decide el siguiente salto de cada paquete según su tabla de rutas. Trabaja en capa 3 y es la frontera natural entre segmentos.

**Claves:**
- Mantiene la tabla de rutas y aplica políticas (NAT, ACL, firewall).
- Un router doméstico suele integrar switch, DHCP, DNS y firewall.
- Su configuración es un objetivo de ataque de alto valor.
- En un laboratorio, la puerta de enlace de la red host-only la cumple el hipervisor.

**En el curso:** [setup](../../setup/README.md) y [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [RFC 1812](https://www.rfc-editor.org/rfc/rfc1812) · [Cisco — What is a router?](https://www.cisco.com/c/en/us/solutions/small-business/resource-center/networking/what-is-a-router.html) · [Cloudflare — Router](https://www.cloudflare.com/learning/network-layer/what-is-a-router/)

---

### 2.17 Switch

El switch conecta dispositivos dentro de una LAN y reenvía tramas según la dirección MAC de destino. Aprende qué MAC está en qué puerto y evita enviar el tráfico a todos.

**Claves:**
- Trabaja en capa 2; los switches de capa 3 también enrutan.
- Las VLAN se configuran en el switch y separan dominios de broadcast.
- Un puerto espejo permite capturar tráfico para análisis.
- Ataques como MAC flooding o VLAN hopping explotan su funcionamiento.

**En el curso:** contexto para [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [IEEE 802.1Q — VLAN](https://standards.ieee.org/ieee/802.1Q/10323/) · [Cisco — What is a switch?](https://www.cisco.com/c/en/us/solutions/small-business/resource-center/networking/network-switch-vs-router.html) · [Cloudflare — Switch](https://www.cloudflare.com/learning/network-layer/what-is-a-network-switch/)

---

### 2.18 NAT

NAT (*Network Address Translation*) reescribe direcciones (y a veces puertos) al atravesar un router. Permite que muchos equipos privados compartan una IP pública y oculta la topología interna.

**Claves:**
- SNAT/DNAT y PAT (masquerade) son las variantes habituales.
- No es un mecanismo de seguridad, aunque dificulta la conexión entrante.
- Rompe protocolos que incluyen direcciones en la carga útil si no hay ALG.
- Los registros de traducción son clave para atribuir tráfico a un host interno.

**En el curso:** explica por qué un servicio interno no es alcanzable desde fuera.

**Fuentes:** [RFC 3022 — NAT](https://www.rfc-editor.org/rfc/rfc3022) · [RFC 4787 — NAT behavioral requirements](https://www.rfc-editor.org/rfc/rfc4787) · [Cisco — NAT](https://www.cisco.com/c/en/us/support/docs/ip/network-address-translation-nat/26704-nat-faq-00.html)

---

### 2.19 Tipos de conexión

Los medios de conexión determinan velocidad, alcance y exposición: Ethernet (cable), Wi-Fi (radio), fibra, enlaces móviles, Bluetooth y NFC. Cada uno tiene sus riesgos y sus herramientas de análisis.

**Claves:**
- Cable: más estable y difícil de interceptar sin acceso físico.
- Wi-Fi: cómodo, pero el medio es compartido y admite ataques de radio.
- Fibra: largo alcance y alta capacidad; requiere equipos específicos.
- Móvil: depende de un operador; la cobertura y la latencia varían.
- Bluetooth y NFC: alcance corto, útiles en pagos y periféricos.

**En el curso:** [setup](../../setup/README.md) elige una red cableada host-only.

**Fuentes:** [IEEE 802.3](https://standards.ieee.org/ieee/802.3/7071/) · [IEEE 802.11](https://standards.ieee.org/ieee/802.11/10549/) · [Bluetooth SIG — Specifications](https://www.bluetooth.com/specifications/)

---

### 2.20 Topología en bus

En una topología en bus todos los dispositivos comparten un único medio. Si el bus se corta o un extremo falla, la red puede quedar inutilizable; las colisiones son frecuentes.

**Claves:**
- Es un diseño histórico, hoy reemplazado por la estrella.
- Un fallo en el cable afecta a todos los nodos.
- El diagnóstico requiere revisar terminadores y continuidad.
- Sigue apareciendo en documentación y en preguntas de certificación.

**En el curso:** cultura general de redes; se menciona en [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [Cisco — Network topologies](https://www.cisco.com/c/en/us/support/docs/availability/high-availability/15114-netwkhw.html) · [CompTIA — Network+ objectives](https://www.comptia.org/certifications/network) · [IEEE 802.3](https://standards.ieee.org/ieee/802.3/7071/)

---

### 2.21 Topología en anillo

En un anillo cada dispositivo se conecta al siguiente y el último cierra el círculo. Los datos circulan en un sentido; tecnologías como Token Ring usaban un testigo para ordenar el acceso.

**Claves:**
- Un corte puede romper todo el anillo o aislarse con mecanismos de redundancia.
- El acceso ordenado evita colisiones, pero añade latencia.
- Hoy sobrevive en redes de fibra con anillos protectores (SONET/SDH, FDDI histórico).
- Su lógica aparece en arquitecturas de alta disponibilidad.

**En el curso:** cultura general; útil para leer diagramas de red.

**Fuentes:** [Cisco — Network topologies](https://www.cisco.com/c/en/us/support/docs/availability/high-availability/15114-netwkhw.html) · [IEEE 802.5](https://standards.ieee.org/ieee/802.5/1015/) · [Cloudflare — Network topology](https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/)

---

### 2.22 Topología en estrella

En una estrella todos los dispositivos se conectan a un nodo central (switch o hub). Es la topología dominante en LAN porque un fallo en un cable solo afecta a ese equipo.

**Claves:**
- El nodo central concentra el tráfico y es un punto único de fallo si no hay redundancia.
- Facilita el mantenimiento y la sustitución de equipos.
- Las VLAN permiten construir varias estrellas lógicas sobre la misma física.
- El puerto espejo del switch central habilita la captura de tráfico.

**En el curso:** es la topología de los laboratorios.

**Fuentes:** [Cisco — Network topologies](https://www.cisco.com/c/en/us/support/docs/availability/high-availability/15114-netwkhw.html) · [Cloudflare — Star topology](https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/) · [IEEE 802.3](https://standards.ieee.org/ieee/802.3/7071/)

---

### 2.23 Topología en malla

En una malla cada nodo se conecta con varios otros. Si es completa, todos se conectan con todos; si es parcial, existen rutas alternativas. El resultado es alta disponibilidad a costa de más enlaces.

**Claves:**
- La redundancia permite sobrevivir a la caída de un enlace.
- Los protocolos de enrutamiento eligen el mejor camino disponible.
- Se usa en backbones, centros de datos y redes inalámbricas mesh.
- Más enlaces implican más superficie y más complejidad de configuración.

**En el curso:** contexto para segmentación y alta disponibilidad en [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [Cisco — Network topologies](https://www.cisco.com/c/en/us/support/docs/availability/high-availability/15114-netwkhw.html) · [Cloudflare — Mesh topology](https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/) · [RFC 6550 — RPL](https://www.rfc-editor.org/rfc/rfc6550)

---

[Requisitos previos](../README.md) · [Siguiente: Protocolos y servicios](../03-protocolos-y-servicios/README.md)
