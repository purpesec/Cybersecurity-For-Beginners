# Fundamentos de IT

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Siguiente: Redes](../02-redes-fundamentos/README.md)

Antes de hablar de ataques, defensas o herramientas, el alumno necesita moverse con soltura por un sistema: entender qué componentes lo forman, cómo se navega por la interfaz y la terminal, cómo se instala software y cómo se manipulan archivos. Este módulo reúne ese sustrato. No es una certificación ni una lista de comandos para memorizar: es el vocabulario mínimo para que el resto de las rutas tenga sentido.

Cada concepto se presenta con una definición operativa, las ideas que conviene retener y fuentes oficiales para ampliar. Los enlaces marcados como "En el curso" indican dónde se aplica dentro de este repositorio.

## Contenido

| # | Concepto |
|---|---|
| 1.1 | [Habilidades fundamentales de IT](#11-habilidades-fundamentales-de-it) |
| 1.2 | [Componentes de hardware](#12-componentes-de-hardware) |
| 1.3 | [Navegación por GUI y CLI](#13-navegación-por-gui-y-cli) |
| 1.4 | [Instalación de software y aplicaciones](#14-instalación-de-software-y-aplicaciones) |
| 1.5 | [Operaciones CRUD sobre archivos](#15-operaciones-crud-sobre-archivos) |
| 1.6 | [Comandos comunes](#16-comandos-comunes) |
| 1.7 | [cat](#17-cat) |
| 1.8 | [head](#18-head) |
| 1.9 | [tail](#19-tail) |
| 1.10 | [grep](#110-grep) |
| 1.11 | [man](#111-man) |
| 1.12 | [Bash](#112-bash) |
| 1.13 | [PowerShell](#113-powershell) |
| 1.14 | [Instalación y configuración de sistemas](#114-instalación-y-configuración-de-sistemas) |
| 1.15 | [Versiones y diferencias entre sistemas](#115-versiones-y-diferencias-entre-sistemas) |
| 1.16 | [Resolución de problemas independiente del sistema](#116-resolución-de-problemas-independiente-del-sistema) |
| 1.17 | [Metodología de troubleshooting](#117-metodología-de-troubleshooting) |

---

### 1.1 Habilidades fundamentales de IT

Son el conjunto de conocimientos que permiten operar un equipo y razonar sobre él: componentes físicos, sistema operativo, archivos, permisos, redes básicas y línea de comandos. No sustituyen a la especialización en seguridad, pero sin ellas cada herramienta se vuelve una caja negra.

**Claves:**
- La seguridad se apoya en la administración de sistemas: quien no sabe qué es un servicio, un proceso o un permiso tampoco puede evaluar su exposición.
- Se demuestran haciendo, no leyendo: instalar un sistema, romperlo y repararlo enseña más que un temario.
- El error habitual del principiante es saltar a herramientas ofensivas sin entender el entorno donde se ejecutan.
- La curiosidad metódica y la lectura de documentación son parte de la habilidad.

**En el curso:** es el prerrequisito transversal de las cinco rutas; en particular, de [CyberSOC](../../cybersoc/README.md) y [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [Cisco Networking Academy — Introduction to Cybersecurity](https://www.netacad.com/courses/introduction-to-cybersecurity) · [Microsoft Learn — Training](https://learn.microsoft.com/en-us/training/) · [CompTIA — Certifications](https://www.comptia.org/certifications)

---

### 1.2 Componentes de hardware

El hardware es la parte física del sistema: CPU, memoria RAM, almacenamiento, placa base, buses, tarjetas de red y periféricos. Cada componente impone límites que afectan al rendimiento y a la seguridad, desde la memoria disponible para una máquina virtual hasta el firmware que se ejecuta antes del sistema operativo.

**Claves:**
- CPU: ejecuta instrucciones; su arquitectura (x86-64, ARM) determina el software compatible.
- RAM: almacena datos y programas en ejecución; se pierde al apagar.
- Almacenamiento: persistente (SSD, HDD, NVMe); contiene el sistema, los datos y los artefactos forenses.
- Firmware/UEFI: inicializa el hardware y arranca el sistema; es una superficie de ataque real.
- Periféricos y buses (PCIe, USB) amplían la superficie: todo lo conectado es un vector potencial.

**En el curso:** [Análisis de malware](../../malware-analysis/01-preparacion-del-entorno/README.md) dimensiona RAM y disco según estos componentes.

**Fuentes:** [Microsoft Learn — Windows hardware dev](https://learn.microsoft.com/en-us/windows-hardware/) · [Intel — Developer documentation](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html) · [Linux kernel — Documentation](https://www.kernel.org/doc/html/latest/)

---

### 1.3 Navegación por GUI y CLI

La GUI ofrece ventanas, iconos y menús; la CLI recibe texto y devuelve texto. Ambas permiten administrar el mismo sistema, pero la terminal es reproducible, automatizable y auditable, por eso domina en administración y en seguridad.

**Claves:**
- La CLI permite encadenar comandos, guardar historial y repetir una operación exacta.
- La GUI es útil para tareas exploratorias y para aplicaciones que no exponen todas sus funciones por terminal.
- En un laboratorio, la terminal es la fuente de evidencias: comandos y salidas se copian al informe.
- Saber moverse entre ambas evita depender de una sola herramienta.

**En el curso:** [Ethical Hacking](../../ethical-hacking/README.md) y [Privilege Escalation](../../privilege-escalation/README.md) se apoyan en la terminal.

**Fuentes:** [GNU — Coreutils manual](https://www.gnu.org/software/coreutils/manual/) · [Microsoft Learn — PowerShell](https://learn.microsoft.com/en-us/powershell/) · [The Linux Documentation Project](https://tldp.org/)

---

### 1.4 Instalación de software y aplicaciones

Instalar software es incorporar programas al sistema y dejarlos disponibles para el usuario. El proceso varía según el sistema: paquetes con dependencias en Linux, instaladores MSI/EXE en Windows, contenedores o tiendas de aplicaciones en otros entornos.

**Claves:**
- Un gestor de paquetes resuelve dependencias y registra versiones; instalarlo a mano suele romper el sistema.
- Verificar la fuente y la firma del paquete previene instalar software manipulado.
- Las instalaciones silenciosas son habituales en despliegues y también en malware.
- Registrar qué se instaló, desde dónde y con qué permisos facilita el mantenimiento y la respuesta a incidentes.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md) instala FLARE-VM y herramientas de análisis.

**Fuentes:** [Debian — APT](https://www.debian.org/doc/manuals/apt-guide/) · [Microsoft Learn — Windows Installer](https://learn.microsoft.com/en-us/windows/win32/msi/windows-installer-portal) · [Red Hat — DNF](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_software_with_the_dnf_tool/)

---

### 1.5 Operaciones CRUD sobre archivos

Crear, leer, actualizar y borrar (CRUD) son las cuatro operaciones básicas sobre archivos y registros. En un sistema operativo se expresan con comandos y con llamadas al sistema; en una base de datos, con SQL.

**Claves:**
- Crear: `touch`, `mkdir`, `New-Item`.
- Leer: `cat`, `less`, `Get-Content`.
- Actualizar: editores (`nano`, `vim`, `notepad`) o redirección (`>` y `>>`).
- Borrar: `rm`, `Remove-Item`; conviene saber si el borrado es recuperable.
- Los permisos determinan quién puede ejecutar cada operación.

**En el curso:** los laboratorios de [Pentesting Web](../../pentesting-web/README.md) manipulan archivos de configuración y bases de datos.

**Fuentes:** [GNU — Coreutils](https://www.gnu.org/software/coreutils/manual/) · [man7 — file system calls](https://man7.org/linux/man-pages/man2/read.2.html) · [Microsoft Learn — File and folder operations](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/)

---

### 1.6 Comandos comunes

Un repertorio reducido de comandos cubre la mayoría del trabajo diario: orientarse (`pwd`, `cd`, `ls`), inspeccionar (`file`, `stat`, `du`), buscar (`find`, `grep`), gestionar procesos (`ps`, `top`, `kill`) y revisar la red (`ip`, `ss`). Dominarlos ahorra tiempo y evita errores.

**Claves:**
- Cada comando tiene opciones; la combinación de pocas herramientas resuelve más que memorizar muchas.
- Las tuberías (`|`) conectan la salida de un comando con la entrada de otro.
- La redirección (`>`, `>>`, `2>`) separa salida estándar y errores.
- Antes de ejecutar algo destructivo, comprobar la ruta y el usuario.

**En el curso:** se usan en todos los laboratorios; [CyberSOC](../../cybersoc/README.md) los emplea para revisar servicios y logs.

**Fuentes:** [GNU — Coreutils](https://www.gnu.org/software/coreutils/manual/) · [man7 — Linux man pages](https://man7.org/linux/man-pages/) · [Microsoft Learn — Windows commands](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)

---

### 1.7 cat

`cat` (concatenate) lee archivos y escribe su contenido en la salida estándar. También concatena varios archivos y puede numerar líneas (`-n`) o mostrar caracteres no imprimibles (`-A`).

**Claves:**
- `cat archivo` es la forma rápida de ver un archivo pequeño.
- `cat a.txt b.txt > c.txt` concatena sin abrir un editor.
- En archivos grandes conviene `less`, porque `cat` vuelca todo y satura la terminal.
- `cat` sobre un dispositivo o un binario puede inundar la sesión; en su lugar, usar `file` o `xxd`.

**En el curso:** aparece en los laboratorios de Linux de [Privilege Escalation](../../privilege-escalation/README.md) para leer configuraciones y scripts.

**Fuentes:** [GNU — cat](https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html) · [man7 — cat(1)](https://man7.org/linux/man-pages/man1/cat.1.html) · [Ubuntu — manpages](https://manpages.ubuntu.com/manpages/noble/man1/cat.1.html)

---

### 1.8 head

`head` muestra las primeras líneas de un archivo o de una entrada; por defecto, diez. Es útil para inspeccionar cabeceras, CSV enormes o la salida inicial de un comando.

**Claves:**
- `head -n 20 archivo` limita la salida a veinte líneas.
- `head -c 512 archivo` lee solo los primeros bytes, útil para identificar formatos.
- Combinado con tuberías, permite ver el comienzo de un flujo sin esperar a que termine.
- No sirve para revisar el final de un archivo; para eso está `tail`.

**En el curso:** se usa para revisar cabeceras de logs y de archivos de configuración en los laboratorios.

**Fuentes:** [GNU — head](https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html) · [man7 — head(1)](https://man7.org/linux/man-pages/man1/head.1.html) · [Ubuntu — manpages](https://manpages.ubuntu.com/manpages/noble/man1/head.1.html)

---

### 1.9 tail

`tail` muestra las últimas líneas de un archivo; por defecto, diez. Su opción `-f` sigue el archivo en tiempo real, lo que la convierte en la herramienta habitual para observar logs mientras ocurre un evento.

**Claves:**
- `tail -n 50 archivo` muestra las últimas cincuenta líneas.
- `tail -f /var/log/syslog` sigue el archivo; `-F` resiste rotaciones.
- Es la contraparte natural de `head`: uno abre el archivo, el otro lo cierra.
- Al depurar, `tail -f` sobre el log correcto ahorra reinicios innecesarios.

**En el curso:** [CyberSOC](../../cybersoc/README.md) observa logs de servicios y de Wazuh con este patrón.

**Fuentes:** [GNU — tail](https://www.gnu.org/software/coreutils/manual/html_node/tail-invocation.html) · [man7 — tail(1)](https://man7.org/linux/man-pages/man1/tail.1.html) · [Ubuntu — manpages](https://manpages.ubuntu.com/manpages/noble/man1/tail.1.html)

---

### 1.10 grep

`grep` busca patrones de texto en archivos o flujos y devuelve las líneas que coinciden. Es la herramienta básica de filtrado y la puerta de entrada a las expresiones regulares.

**Claves:**
- `grep -i` ignora mayúsculas; `-v` invierte la selección; `-n` numera líneas; `-r` recorre directorios.
- `grep -E` habilita expresiones regulares extendidas.
- Buscar en logs es una de las operaciones más frecuentes en análisis y respuesta.
- Un patrón demasiado amplio produce ruido; conviene acotar con contexto (`-A`, `-B`, `-C`).

**En el curso:** se usa en [CyberSOC](../../cybersoc/README.md) y en el análisis de artefactos de [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [GNU — grep](https://www.gnu.org/software/grep/manual/grep.html) · [man7 — grep(1)](https://man7.org/linux/man-pages/man1/grep.1.html) · [Regular-Expressions.info](https://www.regular-expressions.info/)

---

### 1.11 man

`man` muestra el manual de un comando, llamada al sistema o archivo de configuración. Es la documentación local del sistema y la fuente primaria cuando no hay conexión.

**Claves:**
- `man 5 passwd` consulta la sección 5 (formatos de archivo); `man 2 open` la sección 2 (llamadas al sistema).
- `man -k palabra` busca en las descripciones y equivale a `apropos`.
- `man bash` contiene la referencia completa del intérprete.
- Leer la sección `SEE ALSO` suele llevar a la documentación relacionada.

**En el curso:** es la referencia para todos los laboratorios Linux del repositorio.

**Fuentes:** [man7 — Linux man pages](https://man7.org/linux/man-pages/) · [GNU — Manuals](https://www.gnu.org/manual/) · [Ubuntu — manpages](https://manpages.ubuntu.com/)

---

### 1.12 Bash

Bash (*Bourne Again Shell*) es el intérprete de comandos por defecto en la mayoría de distribuciones Linux. Ejecuta comandos, expande variables, controla el flujo con condicionales y bucles, y permite escribir scripts reproducibles.

**Claves:**
- Un script bash es un archivo de texto con órdenes; `chmod +x` lo hace ejecutable.
- Variables, comillas y expansión (`$VAR`, `"$VAR"`) cambian el comportamiento; las comillas dobles evitan sorpresas con espacios.
- Las tuberías y la redirección son parte del lenguaje, no del comando.
- `set -euo pipefail` ayuda a detectar errores en automatizaciones.
- Es una superficie de ataque: scripts mal citados permiten inyección de comandos.

**En el curso:** se usa para automatizar tareas en [CyberSOC](../../cybersoc/README.md) y en los laboratorios de Linux.

**Fuentes:** [GNU — Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html) · [Bash Hackers Wiki](https://mywiki.wooledge.org/BashGuide) · [ShellCheck](https://www.shellcheck.net/)

---

### 1.13 PowerShell

PowerShell es el intérprete y lenguaje de automatización de Windows. A diferencia de Bash, trabaja con objetos .NET en lugar de texto, lo que permite filtrar, ordenar y formatear resultados con cmdlets como `Get-Process`, `Where-Object` o `Select-Object`.

**Claves:**
- Los cmdlets siguen el patrón `Verbo-Sustantivo`.
- Las tuberías pasan objetos, no líneas de texto.
- `Get-Help` y `Get-Command` son la documentación integrada.
- Es clave en administración de Windows y en análisis de incidentes.
- También es un vector de ataque conocido: `-EncodedCommand`, políticas de ejecución y *living off the land*.

**En el curso:** [Análisis de malware](../../malware-analysis/README.md) y [CyberSOC](../../cybersoc/README.md) lo usan para inspección en Windows.

**Fuentes:** [Microsoft Learn — PowerShell](https://learn.microsoft.com/en-us/powershell/) · [Microsoft Learn — PowerShell Gallery](https://www.powershellgallery.com/) · [MITRE ATT&CK — PowerShell](https://attack.mitre.org/techniques/T1059/001/)

---

### 1.14 Instalación y configuración de sistemas

Instalar un sistema operativo implica preparar el disco, el arranque, los controladores y la configuración inicial. Configurar es ajustar ese sistema para un propósito: red, usuarios, servicios, actualizaciones y políticas.

**Claves:**
- El particionado y el esquema de arranque (BIOS/MBR frente a UEFI/GPT) condicionan el resto.
- La configuración inicial incluye zona horaria, idioma, usuarios y contraseñas.
- Las actualizaciones del sistema son parte de la instalación, no un paso opcional.
- Documentar la configuración permite reproducirla y compararla.
- En laboratorio, partir de una instantánea limpia ahorra horas de reinstalación.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md) y [Laboratorio](../../setup/README.md) describen este proceso.

**Fuentes:** [Microsoft Learn — Windows deployment](https://learn.microsoft.com/en-us/windows/deployment/) · [Ubuntu — Server installation](https://documentation.ubuntu.com/server/) · [Red Hat — Installation guide](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/performing_a_standard_rhel_9_installation/)

---

### 1.15 Versiones y diferencias entre sistemas

Cada sistema operativo tiene versiones con ciclos de vida, características y rutas de configuración distintas. Windows, Linux y macOS difieren en jerarquía de archivos, permisos, servicios y herramientas; además, las versiones antiguas sin soporte acumulan vulnerabilidades.

**Claves:**
- Un sistema fuera de soporte no recibe parches de seguridad.
- Los comandos y las rutas cambian entre versiones: no se copia un procedimiento sin comprobarlo.
- Las diferencias de permisos explican por qué un *exploit* funciona en un sistema y no en otro.
- Registrar la versión exacta es obligatorio en cualquier informe técnico.

**En el curso:** los laboratorios fijan versiones concretas (Ubuntu 22.04, Windows 11) en [setup](../../setup/README.md).

**Fuentes:** [Microsoft — Lifecycle](https://learn.microsoft.com/en-us/lifecycle/) · [Ubuntu — Release cycle](https://ubuntu.com/about/release-cycle) · [endoflife.date](https://endoflife.date/)

---

### 1.16 Resolución de problemas independiente del sistema

Es la capacidad de diagnosticar fallos con independencia del sistema operativo: aislar la causa, reproducir el problema, revisar registros, formular hipótesis y comprobarlas. El método importa más que el comando concreto.

**Claves:**
- Reproducir el fallo de forma controlada evita perseguir síntomas.
- Los logs suelen contener la causa exacta; leerlos antes de reiniciar.
- Cambiar una variable a la vez permite saber qué lo arregló.
- Documentar el estado inicial es imprescindible para volver atrás.
- Un fallo de seguridad se diagnostica igual: observando, no adivinando.

**En el curso:** se aplica en todos los laboratorios, especialmente en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft Learn — Troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/) · [Red Hat — Troubleshooting](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/configuring_basic_system_settings/) · [Ubuntu — Troubleshooting](https://documentation.ubuntu.com/server/how-to/)

---

### 1.17 Metodología de troubleshooting

La metodología convierte la resolución de problemas en un proceso repetible: identificar el síntoma, recopilar datos, plantear hipótesis, probar, corregir y verificar. En seguridad se añade la preservación de evidencias.

**Claves:**
- Síntoma no es causa: un servicio caído puede deberse a disco lleno, permisos o red.
- Recopilar antes de tocar: estado, logs, versiones y configuración.
- Probar en orden de probabilidad y de menor impacto.
- Verificar que la corrección no introduce otro problema.
- Registrar el diagnóstico y la solución para el siguiente caso.

**En el curso:** estructura los laboratorios de [CyberSOC](../../cybersoc/README.md) y sirve de base para la respuesta a incidentes.

**Fuentes:** [NIST SP 800-61 — Incident Handling](https://csrc.nist.gov/pubs/sp/800/61/r3/final) · [Microsoft Learn — Troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/) · [Cisco — Troubleshooting guide](https://www.cisco.com/c/en/us/support/docs/)

---

[Requisitos previos](../README.md) · [Siguiente: Redes](../02-redes-fundamentos/README.md)
