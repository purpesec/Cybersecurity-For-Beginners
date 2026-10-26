# Herramientas de análisis

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Cloud y servicios](../12-cloud-y-servicios/README.md) · [Siguiente: Plataformas y laboratorios](../14-plataformas-y-laboratorios/README.md)

Las herramientas no sustituyen el criterio, pero un analista necesita saber qué hace cada una para elegir la correcta. Este módulo repasa las utilidades que aparecen en reconocimiento, captura, diagnóstico y explotación controlada.

## Contenido

| # | Concepto |
|---|---|
| 13.1 | [Nmap](#131-nmap) |
| 13.2 | [Escáneres de puertos](#132-escáneres-de-puertos) |
| 13.3 | [Wireshark](#133-wireshark) |
| 13.4 | [tcpdump](#134-tcpdump) |
| 13.5 | [hping](#135-hping) |
| 13.6 | [netstat](#136-netstat) |
| 13.7 | [ipconfig](#137-ipconfig) |
| 13.8 | [curl](#138-curl) |
| 13.9 | [dig](#139-dig) |
| 13.10 | [nslookup](#1310-nslookup) |
| 13.11 | [tracert](#1311-tracert) |
| 13.12 | [ping](#1312-ping) |
| 13.13 | [dd](#1313-dd) |
| 13.14 | [iptables](#1314-iptables) |
| 13.15 | [GTFOBins](#1315-gtfobins) |
| 13.16 | [LOLBAS](#1316-lolbas) |
| 13.17 | [WADComs](#1317-wadcoms) |
| 13.18 | [Herramientas de hacking comunes](#1318-herramientas-de-hacking-comunes) |
| 13.19 | [Frameworks de explotación](#1319-frameworks-de-explotación) |
| 13.20 | [Capturas de paquetes](#1320-capturas-de-paquetes) |
| 13.21 | [Analizadores de protocolos](#1321-analizadores-de-protocolos) |
| 13.22 | [Sniffers](#1322-sniffers) |

---

### 13.1 Nmap

Nmap descubre hosts y servicios en una red. Envía sondas y clasifica la respuesta para determinar puertos abiertos, servicios, versiones y sistema operativo.

**Claves:**
- Descubrimiento de hosts (`-sn`) y escaneo de puertos (`-p`).
- Detección de versión (`-sV`) y de sistema (`-O`).
- Scripts NSE para comprobaciones específicas.
- Los escaneos agresivos dejan rastro y pueden afectar servicios.
- Solo debe usarse con autorización explícita.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [Nmap — Documentation](https://nmap.org/docs.html) · [Nmap — Book](https://nmap.org/book/) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 13.2 Escáneres de puertos

Un escáner de puertos determina qué servicios aceptan conexiones en un host. Nmap es el más conocido; existen alternativas como Masscan o Netcat.

**Claves:**
- TCP connect, SYN, UDP y escaneos sigilosos.
- La diferencia entre puerto abierto, cerrado y filtrado.
- Un escaneo rápido puede pasar desapercibido; uno completo, no.
- Los resultados envejecen: repetir antes de concluir.
- La detección de escaneos es parte de la defensa.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [Nmap — Port scanning](https://nmap.org/book/man-port-scanning-techniques.html) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 13.3 Wireshark

Wireshark captura y analiza tráfico de red con decodificación de cientos de protocolos. Es la herramienta de referencia para entender una comunicación.

**Claves:**
- Captura en vivo o lectura de un `.pcap`.
- Filtros de visualización (`http`, `dns`, `tcp.port==443`).
- Permite seguir flujos TCP y extraer objetos.
- El tráfico cifrado no se descifra sin claves.
- La captura requiere privilegios y puede ser masiva.

**En el curso:** [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [Wireshark — User guide](https://www.wireshark.org/docs/) · [Wireshark — Display filters](https://www.wireshark.org/docs/dfref/) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.4 tcpdump

tcpdump captura paquetes desde la línea de comandos. Es ligero, ubicuo y fácil de usar en servidores remotos.

**Claves:**
- `tcpdump -i eth0 -w captura.pcap` guarda para analizar después.
- Filtros BPF: `port 443`, `host 10.0.0.5`, `tcp[tcpflags] & tcp-syn != 0`.
- Requiere privilegios (root o capabilities).
- Escribir a disco demasiado tiempo llena el disco.
- Es la pareja natural de Wireshark.

**En el curso:** [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [tcpdump — Manual](https://www.tcpdump.org/manpages/tcpdump.1.html) · [pcap-filter — Man page](https://www.tcpdump.org/manpages/pcap-filter.7.html) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.5 hping

hping construye y envía paquetes personalizados (TCP, UDP, ICMP) y permite sondear firewalls, medir respuestas y probar filtros.

**Claves:**
- Control de flags, puertos y TTL.
- Útil para entender cómo responde un filtro.
- Puede realizar trazado de rutas por TCP.
- Como toda herramienta de sondeo, requiere autorización.
- No es un escáner completo de servicios.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [hping — Documentation](https://www.hping.org/) · [Nmap — Firewall evasion](https://nmap.org/book/man-bypass-firewalls-ids.html) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 13.6 netstat

netstat muestra conexiones, puertos en escucha, tablas de rutas y estadísticas. Es útil para saber qué servicios están activos y quién está conectado.

**Claves:**
- `netstat -tulpn` lista puertos en escucha con proceso.
- En sistemas modernos compite con `ss` y `Get-NetTCPConnection`.
- Permite detectar conexiones salientes sospechosas.
- La salida cambia entre sistemas operativos.
- Requiere privilegios para ver procesos de otros usuarios.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [man7 — netstat(8)](https://man7.org/linux/man-pages/man8/netstat.8.html) · [Microsoft — netstat](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netstat) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.7 ipconfig

ipconfig muestra y gestiona la configuración de red en Windows: direcciones, puerta de enlace, DNS, DHCP y adaptadores.

**Claves:**
- `ipconfig /all` muestra el detalle completo.
- `/release` y `/renew` reinician la concesión DHCP.
- `/flushdns` limpia la caché de resolución.
- `/displaydns` muestra la caché actual.
- Equivale a `ip` en Linux, no a `ifconfig` solamente.

**En el curso:** [setup](../../setup/README.md) y diagnóstico de red.

**Fuentes:** [Microsoft — ipconfig](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ipconfig) · [Microsoft — TCP/IP](https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/tcpip-addressing-and-subnetting) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 13.8 curl

curl transfiere datos con múltiples protocolos (HTTP, HTTPS, FTP, SMTP). Permite probar APIs, seguir redirecciones, usar cookies y medir tiempos.

**Claves:**
- `curl -I` obtiene solo cabeceras.
- `-X` cambia el método; `-d` envía cuerpo.
- `-k` ignora la validación del certificado: solo en laboratorio.
- `-w` muestra métricas de la petición.
- Es imprescindible para depurar aplicaciones web y APIs.

**En el curso:** [Pentesting Web](../../pentesting-web/01-fundamentos-web-y-http/README.md).

**Fuentes:** [curl — Documentation](https://curl.se/docs/) · [curl — Man page](https://curl.se/docs/manpage.html) · [MDN — HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP)

---

### 13.9 dig

dig consulta servidores DNS y muestra la respuesta completa: registros, autoridad, tiempos y flags. Es la herramienta de referencia para diagnosticar DNS.

**Claves:**
- `dig ejemplo.com A` consulta un tipo concreto.
- `+short` resume; `+trace` sigue la delegación.
- `@8.8.8.8` elige el servidor a consultar.
- Muestra si la respuesta fue autoritativa o cacheada.
- Es más verbosa y precisa que nslookup.

**En el curso:** [Ethical Hacking](../../ethical-hacking/03-reconocimiento-y-osint-tecnico/README.md).

**Fuentes:** [ISC — dig](https://bind9.readthedocs.io/en/latest/manpages.html) · [RFC 1035](https://www.rfc-editor.org/rfc/rfc1035) · [IANA — DNS](https://www.iana.org/assignments/dns-parameters/)

---

### 13.10 nslookup

nslookup consulta DNS con un formato simple, disponible en Windows y Unix. Permite consultas directas e inversas y elegir servidor.

**Claves:**
- `nslookup dominio` devuelve la dirección.
- `nslookup IP` intenta la resolución inversa.
- Modo interactivo con `set type=MX`.
- Menos informativo que dig, pero universal.
- Útil cuando no hay herramientas adicionales instaladas.

**En el curso:** diagnóstico en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft — nslookup](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/nslookup) · [RFC 1035](https://www.rfc-editor.org/rfc/rfc1035) · [IANA — DNS](https://www.iana.org/assignments/dns-parameters/)

---

### 13.11 tracert

tracert (Windows) y traceroute (Unix) muestran el camino que sigue un paquete hasta un destino, salto a salto, usando TTL crecientes.

**Claves:**
- Identifica dónde se pierde la conectividad.
- Los routers pueden no responder ICMP y aparecer como `*`.
- En Linux, `traceroute` usa UDP por defecto; `-T` usa TCP.
- La ruta puede cambiar entre ejecuciones.
- No revela el camino de vuelta.

**En el curso:** diagnóstico de red en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft — tracert](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tracert) · [man7 — traceroute(8)](https://man7.org/linux/man-pages/man8/traceroute.8.html) · [RFC 792 — ICMP](https://www.rfc-editor.org/rfc/rfc792)

---

### 13.12 ping

ping envía ICMP Echo Request y mide si el destino responde y cuánto tarda. Es la prueba básica de conectividad.

**Claves:**
- `ping -c 4 host` en Linux; `ping -n 4 host` en Windows.
- Un fallo de ping no implica que el servicio esté caído: ICMP puede estar filtrado.
- El TTL informa de forma indirecta sobre saltos y sistema.
- Sirve para medir latencia y pérdida.
- Algunos firewalls bloquean ICMP por política.

**En el curso:** [setup](../../setup/README.md) y diagnóstico.

**Fuentes:** [RFC 792 — ICMP](https://www.rfc-editor.org/rfc/rfc792) · [Microsoft — ping](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ping) · [man7 — ping(8)](https://man7.org/linux/man-pages/man8/ping.8.html)

---

### 13.13 dd

dd copia datos bloque a bloque. Se usa para crear imágenes forenses, clonar dispositivos y generar archivos de prueba.

**Claves:**
- `dd if=/dev/sdb of=imagen.img bs=4M status=progress`.
- Un destino equivocado destruye datos sin confirmación.
- No verifica por sí mismo: hay que calcular hashes aparte.
- `conv=noerror,sync` ayuda con medios dañados.
- Para forense se prefiere una herramienta con cadena de custodia.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y análisis forense.

**Fuentes:** [GNU — dd](https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html) · [man7 — dd(1)](https://man7.org/linux/man-pages/man1/dd.1.html) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.14 iptables

iptables configura el filtrado de paquetes en Linux mediante tablas y cadenas. Es la base histórica de los firewalls de host.

**Claves:**
- Tablas: filter, nat, mangle.
- Cadenas: INPUT, OUTPUT, FORWARD.
- Política por defecto y reglas ordenadas.
- nftables es su sucesor moderno.
- Un error puede dejar el servidor inaccesible.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [man7 — iptables(8)](https://man7.org/linux/man-pages/man8/iptables.8.html) · [Netfilter — Documentation](https://www.netfilter.org/documentation/) · [NIST SP 800-41](https://csrc.nist.gov/pubs/sp/800/41/r1/final)

---

### 13.15 GTFOBins

GTFOBins documenta binarios Unix legítimos que pueden usarse para eludir restricciones, escalar privilegios o ejecutar comandos cuando están mal configurados.

**Claves:**
- Se consulta por binario y por técnica (shell, lectura, escritura, SUID).
- Es una referencia defensiva y ofensiva.
- Ayuda a detectar configuraciones peligrosas de sudo y SUID.
- No es malware: son herramientas del sistema.
- Revisar la lista es parte del endurecimiento.

**En el curso:** [Privilege Escalation](../../privilege-escalation/03-privilegios-delegados-sudo/README.md).

**Fuentes:** [GTFOBins](https://gtfobins.github.io/) · [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) · [MITRE ATT&CK — Unix shell](https://attack.mitre.org/techniques/T1059/004/)

---

### 13.16 LOLBAS

LOLBAS documenta binarios y scripts legítimos de Windows que un atacante puede abusar (*living off the land*) para ejecutar código o descargar archivos.

**Claves:**
- Ejemplos: `certutil`, `mshta`, `rundll32`, `regsvr32`.
- Dificultan la detección porque el binario es legítimo.
- La detección se apoya en líneas de comandos y contexto.
- Las reglas de bloqueo deben probarse antes de aplicarlas.
- Complementa a GTFOBins en Unix.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [LOLBAS](https://lolbas-project.github.io/) · [MITRE ATT&CK — Signed binary](https://attack.mitre.org/techniques/T1218/) · [Microsoft — Defender](https://learn.microsoft.com/en-us/defender-endpoint/)

---

### 13.17 WADComs

WADComs reúne comandos para entornos Windows y Active Directory, organizados por objetivo: enumeración, credenciales, movimiento lateral y persistencia.

**Claves:**
- Es una chuleta, no una herramienta.
- Incluye el contexto necesario para cada comando.
- Útil para recordar sintaxis bajo presión.
- Requiere entender qué hace cada comando.
- Solo en entornos autorizados.

**En el curso:** [Ethical Hacking](../../ethical-hacking/05-explotacion-controlada-y-reportes/README.md).

**Fuentes:** [WADComs](https://wadcoms.github.io/) · [Microsoft — Active Directory](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-domain-services) · [MITRE ATT&CK](https://attack.mitre.org/)

---

### 13.18 Herramientas de hacking comunes

El arsenal ofensivo incluye reconocimiento (Nmap, Amass), explotación (Metasploit), contraseñas (Hashcat, John), redes (Responder, Bettercap) y post-explotación (BloodHound, Impacket).

**Claves:**
- Cada herramienta resuelve una fase concreta.
- Saber qué hace importa más que la sintaxis.
- Las distribuciones las agrupan por categoría.
- Su uso requiere autorización y alcance definido.
- La defensa debe reconocer su huella.

**En el curso:** [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [Kali — Tools](https://www.kali.org/tools/) · [MITRE ATT&CK — Software](https://attack.mitre.org/software/) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 13.19 Frameworks de explotación

Un framework de explotación reúne exploits, payloads y módulos de post-explotación bajo una interfaz común. Metasploit es el más conocido.

**Claves:**
- Estructura: exploit, payload, encoder y módulo auxiliar.
- Permite reproducir y documentar una prueba.
- No sustituye el entendimiento de la vulnerabilidad.
- Sus módulos se actualizan con frecuencia.
- Su tráfico tiene firmas reconocibles.

**En el curso:** [Ethical Hacking](../../ethical-hacking/05-explotacion-controlada-y-reportes/README.md).

**Fuentes:** [Metasploit — Documentation](https://docs.metasploit.com/) · [Rapid7 — Metasploit](https://www.metasploit.com/) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final)

---

### 13.20 Capturas de paquetes

Una captura de paquetes (*pcap*) conserva el tráfico para analizarlo después. Es evidencia y material de estudio.

**Claves:**
- Formatos: pcap y pcapng.
- Contiene direcciones, puertos, tiempos y contenido no cifrado.
- Su tamaño exige filtrar o rotar.
- La captura debe documentar interfaz y ventana temporal.
- Puede contener datos personales: tratarla con cuidado.

**En el curso:** [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [Wireshark — pcap](https://www.wireshark.org/docs/) · [tcpdump — Man page](https://www.tcpdump.org/manpages/tcpdump.1.html) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.21 Analizadores de protocolos

Un analizador de protocolos interpreta el contenido de una captura y muestra campos con significado. Wireshark es el ejemplo principal; Zeek genera registros estructurados.

**Claves:**
- Descodifica capas y resalta anomalías.
- Los filtros de visualización aíslan conversaciones.
- Zeek produce logs útiles para el SIEM.
- El tráfico cifrado limita el análisis al exterior.
- Interpretar requiere conocer el protocolo.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md).

**Fuentes:** [Wireshark — Documentation](https://www.wireshark.org/docs/) · [Zeek — Documentation](https://docs.zeek.org/) · [NIST SP 800-86](https://csrc.nist.gov/pubs/sp/800/86/final)

---

### 13.22 Sniffers

Un sniffer captura el tráfico que pasa por una interfaz. Puede ser pasivo (puerto espejo) o requerir envenenamiento para ver tráfico ajeno.

**Claves:**
- En redes conmutadas no se ve todo el tráfico sin un espejo.
- ARP spoofing permite interceptar en la LAN.
- El tráfico cifrado limita lo que se puede leer.
- Su uso no autorizado es interceptación ilegal.
- En defensa, detectar sniffers es difícil: son pasivos.

**En el curso:** [Ethical Hacking](../../ethical-hacking/04-redes-descubrimiento-y-enumeracion/README.md).

**Fuentes:** [Wireshark — Capture setup](https://www.wireshark.org/docs/wsug_html_chunked/ChapterCapture.html) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final) · [MITRE ATT&CK — Network sniffing](https://attack.mitre.org/techniques/T1040/)

---

[Requisitos previos](../README.md) · [Siguiente: Plataformas y laboratorios](../14-plataformas-y-laboratorios/README.md)
