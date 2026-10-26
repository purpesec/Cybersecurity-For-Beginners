# Sistemas operativos

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Red y criptografía](../04-red-y-criptografia/README.md) · [Siguiente: Fundamentos de seguridad](../06-fundamentos-seguridad/README.md)

El sistema operativo es donde ocurre casi todo: procesos, archivos, usuarios, permisos, servicios y registros. Este módulo repasa qué hace un sistema operativo, cómo difieren Windows, Linux y macOS, y cómo se ejecutan varios sistemas sobre una misma máquina.

## Contenido

| # | Concepto |
|---|---|
| 5.1 | [Sistemas operativos](#51-sistemas-operativos) |
| 5.2 | [Windows](#52-windows) |
| 5.3 | [Linux](#53-linux) |
| 5.4 | [macOS](#54-macos) |
| 5.5 | [Endurecimiento del sistema operativo](#55-endurecimiento-del-sistema-operativo) |
| 5.6 | [Directivas de grupo](#56-directivas-de-grupo) |
| 5.7 | [Registros de eventos](#57-registros-de-eventos) |
| 5.8 | [Listas de control de acceso](#58-listas-de-control-de-acceso) |
| 5.9 | [ACL en la práctica](#59-acl-en-la-práctica) |
| 5.10 | [Autenticación local](#510-autenticación-local) |
| 5.11 | [Permisos](#511-permisos) |
| 5.12 | [Sistema operativo invitado](#512-sistema-operativo-invitado) |
| 5.13 | [Sistema operativo anfitrión](#513-sistema-operativo-anfitrión) |
| 5.14 | [Hipervisor](#514-hipervisor) |
| 5.15 | [Máquina virtual](#515-máquina-virtual) |
| 5.16 | [VMware](#516-vmware) |
| 5.17 | [VirtualBox](#517-virtualbox) |
| 5.18 | [Proxmox](#518-proxmox) |
| 5.19 | [ESXi](#519-esxi) |
| 5.20 | [Sandboxing](#520-sandboxing) |

---

### 5.1 Sistemas operativos

Un sistema operativo administra el hardware y ofrece servicios a los programas: planifica procesos, gestiona memoria, organiza archivos, controla dispositivos y aplica permisos. Es la capa que hace usable la máquina.

**Claves:**
- Núcleo (*kernel*) frente a espacio de usuario: los programas no tocan el hardware directamente.
- Interfaz de llamadas al sistema (*syscalls*) como contrato entre ambos.
- Gestión de usuarios, grupos y permisos.
- Registro de eventos para diagnóstico y auditoría.

**En el curso:** base de [CyberSOC](../../cybersoc/README.md) y de [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [Linux kernel — Documentation](https://www.kernel.org/doc/html/latest/) · [Microsoft Learn — Windows](https://learn.microsoft.com/en-us/windows/) · [Apple — macOS](https://support.apple.com/guide/mac-help/welcome/mac)

---

### 5.2 Windows

Windows es el sistema de escritorio y servidor más extendido en empresas. Su ecosistema incluye Active Directory, Group Policy, el Registro y una gran superficie de compatibilidad.

**Claves:**
- Estructura: `C:\Windows`, `C:\Users`, Registro y servicios.
- Active Directory centraliza identidades y políticas en dominios.
- El Registro guarda configuración y es fuente de artefactos forenses.
- Herramientas: Event Viewer, Task Manager, PowerShell, Sysinternals.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft Learn — Windows Server](https://learn.microsoft.com/en-us/windows-server/) · [Microsoft — Sysinternals](https://learn.microsoft.com/en-us/sysinternals/) · [Microsoft — Security baselines](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines)

---

### 5.3 Linux

Linux es una familia de sistemas basados en el núcleo Linux, con distribuciones como Debian, Ubuntu, Red Hat o Arch. Domina servidores, contenedores y dispositivos.

**Claves:**
- Jerarquía única: `/etc`, `/var`, `/home`, `/proc`, `/dev`.
- Permisos por propietario, grupo y otros; `chmod`, `chown`.
- Gestión de servicios con `systemd`.
- Registros en `/var/log` y en el *journal*.
- Gran parte de la administración se hace por terminal.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [The Linux Documentation Project](https://tldp.org/) · [kernel.org — Documentation](https://www.kernel.org/doc/html/latest/) · [Ubuntu — Server docs](https://documentation.ubuntu.com/server/)

---

### 5.4 macOS

macOS es el sistema de Apple, basado en Darwin (Unix) con interfaz propia. Incluye protección integrada (SIP, Gatekeeper, XProtect) y un ecosistema cerrado.

**Claves:**
- Base Unix con terminal `zsh` y utilidades BSD.
- SIP protege rutas críticas del sistema.
- Gatekeeper valida la firma y notarización de aplicaciones.
- Los registros unificados se consultan con `log show`.
- La gestión empresarial se apoya en MDM.

**En el curso:** cultura de sistemas y análisis multiplataforma.

**Fuentes:** [Apple — macOS Security](https://support.apple.com/guide/security/welcome/web) · [Apple — Platform Deployment](https://support.apple.com/guide/deployment/welcome/web) · [Apple — Developer documentation](https://developer.apple.com/documentation/)

---

### 5.5 Endurecimiento del sistema operativo

Endurecer es reducir la superficie de ataque de un sistema: quitar servicios innecesarios, cerrar puertos, limitar privilegios, aplicar políticas y mantener parches.

**Claves:**
- Principio de mínimo privilegio en cuentas y servicios.
- Deshabilitar protocolos y funciones heredadas.
- Aplicar líneas base (CIS, STIG) y verificar desviaciones.
- Restringir ejecución (AppLocker, SELinux, AppArmor).
- Registrar y monitorizar cambios de configuración.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [CIS — Benchmarks](https://www.cisecurity.org/cis-benchmarks) · [NIST SP 800-123](https://csrc.nist.gov/pubs/sp/800/123/final) · [Microsoft — Security baselines](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines)

---

### 5.6 Directivas de grupo

Las Directivas de grupo (GPO) permiten aplicar configuraciones a usuarios y equipos de un dominio de Active Directory: contraseñas, escritorio, software, firewall y auditoría.

**Claves:**
- Se vinculan a sitios, dominios u OU y se aplican por precedencia.
- Incluyen políticas de seguridad y plantillas administrativas.
- `gpresult` y `RSOP` muestran qué se aplicó y por qué.
- Una GPO mal configurada puede debilitar contraseñas o abrir accesos.

**En el curso:** administración de Windows en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft — Group Policy](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831791(v=ws.11)) · [Microsoft — Security baselines](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/windows-security-baselines) · [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final)

---

### 5.7 Registros de eventos

Los registros de eventos recogen lo que ocurre en el sistema: inicios de sesión, cambios de configuración, errores y actividad de aplicaciones. Son la materia prima de la detección y del análisis forense.

**Claves:**
- Windows: Visor de eventos, canales Security, System, Application y Sysmon.
- Linux: `syslog`, `journald` y logs de aplicación.
- Los eventos tienen identificadores que conviene conocer (4624, 4625, 4688).
- La ausencia de un evento también es información.
- Centralizarlos evita que un atacante los borre localmente.

**En el curso:** [CyberSOC](../../cybersoc/05-soc-siem-y-wazuh/README.md) y [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [Microsoft — Event logging](https://learn.microsoft.com/en-us/windows/win32/eventlog/event-logging) · [Microsoft — Audit events](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/audit-policy-recommendations) · [systemd — journal](https://www.freedesktop.org/software/systemd/man/latest/journalctl.html)

---

### 5.8 Listas de control de acceso

Una ACL (*Access Control List*) es una lista de reglas que indica quién puede hacer qué sobre un objeto. Cada entrada asocia un sujeto (usuario, grupo, proceso) con permisos permitidos o denegados.

**Claves:**
- DACL controla el acceso; SACL registra los intentos.
- Las reglas se evalúan por orden y con herencia.
- Un permiso excesivo en un objeto compartido es una escalada habitual.
- Las ACL también existen en red (enrutadores, firewalls) con otra semántica.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md) y administración de Windows/Linux.

**Fuentes:** [Microsoft — Access control lists](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-control-lists) · [POSIX ACL — man7](https://man7.org/linux/man-pages/man5/acl.5.html) · [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final)

---

### 5.9 ACL en la práctica

En el día a día, trabajar con ACL significa leerlas, auditarlas y corregirlas. En Windows se usan `icacls` y `Get-Acl`; en Linux, `getfacl` y `setfacl`.

**Claves:**
- `icacls archivo` muestra permisos efectivos en Windows.
- `getfacl -p archivo` muestra ACL POSIX en Linux.
- Los permisos heredados explican accesos que no aparecen en la lista directa.
- Revisar ACL es parte de la auditoría de rutas escribibles y secretos.

**En el curso:** [Privilege Escalation](../../privilege-escalation/06-tareas-programadas-y-rutas-escribibles/README.md).

**Fuentes:** [Microsoft — icacls](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls) · [man7 — acl(5)](https://man7.org/linux/man-pages/man5/acl.5.html) · [CIS — Benchmarks](https://www.cisecurity.org/cis-benchmarks)

---

### 5.10 Autenticación local

La autenticación local valida credenciales contra la base de cuentas del propio equipo (SAM en Windows, `/etc/shadow` en Linux), sin depender de un directorio central.

**Claves:**
- Windows: cuentas locales en SAM; `net user` y `lusrmgr.msc`.
- Linux: `/etc/passwd` y `/etc/shadow`; `passwd`, `su`, `sudo`.
- Los hashes locales son objetivo de volcado y *cracking*.
- En equipos no unidos a dominio, la seguridad depende de estas cuentas.

**En el curso:** [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [Microsoft — Local accounts](https://learn.microsoft.com/en-us/windows/security/identity-protection/access-control/local-accounts) · [man7 — shadow(5)](https://man7.org/linux/man-pages/man5/shadow.5.html) · [NIST SP 800-63B](https://csrc.nist.gov/pubs/sp/800/63/b/upd2/final)

---

### 5.11 Permisos

Los permisos definen qué operaciones puede realizar un sujeto sobre un recurso. En Unix se combinan lectura, escritura y ejecución para propietario, grupo y otros; en Windows se usan permisos NTFS y derechos.

**Claves:**
- `rwx` en Unix; `chmod` con notación octal o simbólica.
- En Windows, permisos NTFS (lectura, escritura, ejecución, control total).
- Los permisos efectivos resultan de la combinación de grupos y herencia.
- Un bit SUID/SGID o un permiso de escritura mal puesto permiten escalar.

**En el curso:** [Privilege Escalation](../../privilege-escalation/04-binarios-suid-y-sgid/README.md).

**Fuentes:** [man7 — chmod(1)](https://man7.org/linux/man-pages/man1/chmod.1.html) · [Microsoft — NTFS permissions](https://learn.microsoft.com/en-us/windows-server/storage/file-server/ntfs-overview) · [NIST SP 800-53](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final)

---

### 5.12 Sistema operativo invitado

El sistema invitado (*guest*) se ejecuta dentro de una máquina virtual o contenedor. Comparte el hardware físico a través del hipervisor y no debería poder afectar al anfitrión.

**Claves:**
- Sus fallos quedan contenidos si el aislamiento es correcto.
- Las *guest additions* mejoran integración, pero amplían la superficie.
- Un *escape* de la virtualización rompe el aislamiento.
- Es la pieza básica de los laboratorios de seguridad.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [Microsoft — Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/) · [VMware — Virtualization](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/)

---

### 5.13 Sistema operativo anfitrión

El sistema anfitrión (*host*) ejecuta el hipervisor y cede recursos a los invitados. Es la base de confianza del laboratorio: si se compromete, todos los invitados quedan expuestos.

**Claves:**
- Debe mantenerse parcheado y con el mínimo software.
- Conviene separar el trabajo diario del laboratorio.
- Compartir carpetas o portapapeles reduce el aislamiento.
- Las instantáneas permiten volver a un estado limpio.

**En el curso:** [setup](../../setup/README.md) y [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [Microsoft — Hyper-V security](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/overview?pivots=windows) · [CIS — Benchmarks](https://www.cisecurity.org/cis-benchmarks)

---

### 5.14 Hipervisor

El hipervisor crea y ejecuta máquinas virtuales, repartiendo CPU, memoria y dispositivos. Puede ser de tipo 1 (bare-metal) o de tipo 2 (sobre un sistema operativo).

**Claves:**
- Tipo 1: ESXi, Hyper-V, Proxmox/KVM. Tipo 2: VirtualBox, VMware Workstation.
- Aísla invitados, pero comparte hardware y controladores.
- Las vulnerabilidades del hipervisor son críticas.
- La red virtual (host-only, NAT, bridge) define el aislamiento.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [Linux kernel — KVM](https://www.kernel.org/doc/html/latest/virt/kvm/index.html) · [Microsoft — Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/)

---

### 5.15 Máquina virtual

Una máquina virtual es un equipo emulado por software, con CPU, memoria, disco y red propios. Permite ejecutar sistemas distintos, aislar pruebas y reproducir entornos.

**Claves:**
- Discos virtuales en archivos (VMDK, VDI, QCOW2).
- Las instantáneas congelan el estado para volver atrás.
- El rendimiento depende de la virtualización asistida por hardware.
- Es la base de los laboratorios y del análisis de malware.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [VirtualBox — Manual](https://www.virtualbox.org/manual/) · [VMware — Documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere.html)

---

### 5.16 VMware

VMware es una familia de productos de virtualización: Workstation y Fusion en escritorio; ESXi y vSphere en servidores. Es habitual en empresas y laboratorios.

**Claves:**
- Workstation/Fusion: hipervisor de tipo 2.
- ESXi: hipervisor de tipo 1, administrado por vCenter.
- Redes virtuales: host-only, NAT, bridge y redes personalizadas.
- Sus instantáneas y clones facilitan el análisis.

**En el curso:** alternativa a VirtualBox en [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [VMware — Documentation](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere.html) · [VMware — Workstation](https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro.html) · [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final)

---

### 5.17 VirtualBox

VirtualBox es un hipervisor de tipo 2 gratuito y multiplataforma. Es la opción habitual para laboratorios personales por su facilidad de uso y sus redes virtuales.

**Claves:**
- Redes: NAT, adaptador puente, red interna y solo-anfitrión.
- Extension Pack añade USB 2/3, RDP y cifrado de disco.
- Las carpetas compartidas y el portapapeles deben desactivarse en análisis.
- Las instantáneas permiten volver a un estado limpio.

**En el curso:** [Preparación del entorno](../../malware-analysis/01-preparacion-del-entorno/README.md).

**Fuentes:** [VirtualBox — Manual](https://www.virtualbox.org/manual/) · [Oracle — VirtualBox docs](https://docs.oracle.com/en/virtualization/virtualbox/) · [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final)

---

### 5.18 Proxmox

Proxmox VE es una plataforma de virtualización de código abierto basada en Debian, KVM y LXC. Combina gestión web, clúster, almacenamiento y copias de seguridad.

**Claves:**
- KVM para máquinas virtuales completas; LXC para contenedores.
- Gestión por interfaz web y API.
- Clúster y migración en vivo para alta disponibilidad.
- Es habitual en laboratorios y pequeñas infraestructuras.

**En el curso:** alternativa para montar un laboratorio de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Proxmox — Documentation](https://pve.proxmox.com/pve-docs/) · [Proxmox — Wiki](https://pve.proxmox.com/wiki/Main_Page) · [Linux kernel — KVM](https://www.kernel.org/doc/html/latest/virt/kvm/index.html)

---

### 5.19 ESXi

VMware ESXi es un hipervisor de tipo 1 que se instala directamente sobre el hardware. Se administra por vSphere Client o por API y es común en centros de datos.

**Claves:**
- Sin sistema operativo anfitrión convencional.
- Máquinas virtuales con discos VMDK y redes virtuales.
- Endurecimiento mediante líneas base y control de acceso.
- Su compromiso afecta a todas las máquinas alojadas.

**En el curso:** contexto de infraestructura y virtualización.

**Fuentes:** [VMware — ESXi docs](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere/8-0.html) · [VMware — Security](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/overview?pivots=windows) · [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final)

---

### 5.20 Sandboxing

Una sandbox ejecuta código no confiable en un entorno restringido, con acceso limitado a archivos, red y sistema. Se usa para analizar malware y para aislar aplicaciones.

**Claves:**
- Puede ser una VM, un contenedor o un mecanismo del sistema (seccomp, AppContainer).
- El código debe detectar que está aislado (anti-VM, anti-sandbox).
- Un *escape* de la sandbox invalida el análisis.
- Los servicios en línea automatizan el triaje, pero ocultan detalles.

**En el curso:** [Análisis de malware](../../malware-analysis/05-enfoques-de-analisis/README.md).

**Fuentes:** [NIST — Sandboxing](https://csrc.nist.gov/glossary/term/sandbox) · [Cuckoo — Docs](https://cuckoo.readthedocs.io/) · [Microsoft — Windows Sandbox](https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/)

---

[Requisitos previos](../README.md) · [Siguiente: Fundamentos de seguridad](../06-fundamentos-seguridad/README.md)
