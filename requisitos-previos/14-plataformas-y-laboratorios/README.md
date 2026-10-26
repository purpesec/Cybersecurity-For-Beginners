# Plataformas y laboratorios

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Herramientas de análisis](../13-herramientas-de-analisis/README.md) · [Siguiente: Programación](../15-programacion-y-automatizacion/README.md)

Practicar en un entorno legal es la única forma segura de aprender técnicas ofensivas y defensivas. Este módulo presenta las distribuciones y plataformas donde se hacen los ejercicios, con criterios para elegir y para no salir del alcance.

## Contenido

| # | Concepto |
|---|---|
| 14.1 | [Kali Linux](#141-kali-linux) |
| 14.2 | [Parrot OS](#142-parrot-os) |
| 14.3 | [Hack The Box](#143-hack-the-box) |
| 14.4 | [TryHackMe](#144-tryhackme) |
| 14.5 | [VulnHub](#145-vulnhub) |
| 14.6 | [picoCTF](#146-picoctf) |
| 14.7 | [pwn.college](#147-pwncollege) |
| 14.8 | [SANS Holiday Hack Challenge](#148-sans-holiday-hack-challenge) |

---

### 14.1 Kali Linux

Kali Linux es una distribución basada en Debian orientada a pruebas de seguridad. Incluye cientos de herramientas clasificadas por fase y un entorno de escritorio preparado.

**Claves:**
- Trae Nmap, Metasploit, Burp Suite, Wireshark y utilidades forenses.
- No está pensada como sistema de uso diario.
- Debe ejecutarse en una VM aislada o con autorización.
- Sus herramientas también se instalan por separado en otras distribuciones.
- La imagen oficial se verifica por hash antes de usar.

**En el curso:** [Ethical Hacking](../../ethical-hacking/01-fundamentos-etica-y-laboratorio/README.md).

**Fuentes:** [Kali — Documentation](https://www.kali.org/docs/) · [Kali — Tools](https://www.kali.org/tools/) · [Debian — Documentation](https://www.debian.org/doc/)

---

### 14.2 Parrot OS

Parrot OS (Parrot Security) es una distribución Debian orientada a seguridad y privacidad, con herramientas ofensivas y forenses y un enfoque de uso más ligero.

**Claves:**
- Alternativa a Kali con conjunto de herramientas similar.
- Incluye ediciones de seguridad, hogar y arquitecturas ARM.
- Comparte la mayoría de herramientas y flujos.
- También debe usarse en laboratorio aislado.
- La elección entre Kali y Parrot es de preferencia.

**En el curso:** alternativa en [Ethical Hacking](../../ethical-hacking/01-fundamentos-etica-y-laboratorio/README.md).

**Fuentes:** [Parrot — Documentation](https://parrotsec.org/docs/) · [Parrot — Download](https://parrotsec.org/download/) · [Debian — Documentation](https://www.debian.org/doc/)

---

### 14.3 Hack The Box

Hack The Box es una plataforma de laboratorios con máquinas vulnerables, retos y rutas de aprendizaje. Se accede por VPN o mediante instancias dedicadas.

**Claves:**
- Máquinas retiradas con writeups públicos y activas sin soluciones.
- Rutas guiadas por rol (pentester, SOC, etc.).
- El acceso VPN conecta el equipo a una red de laboratorio.
- Las reglas prohíben atacar infraestructura de la plataforma.
- Es un entorno legal para practicar.

**En el curso:** práctica de [Ethical Hacking](../../ethical-hacking/05-explotacion-controlada-y-reportes/README.md).

**Fuentes:** [Hack The Box](https://www.hackthebox.com/) · [HTB — Academy](https://academy.hackthebox.com/) · [HTB — Support](https://help.hackthebox.com/)

---

### 14.4 TryHackMe

TryHackMe ofrece habitaciones guiadas con teoría y tareas prácticas en el navegador o por VPN. Está orientada a principiantes y a rutas estructuradas.

**Claves:**
- Mezcla contenido teórico y ejercicios.
- Rutas por objetivo (fundamentos, SOC, pentesting).
- Las salas gratuitas cubren lo esencial.
- El progreso y las respuestas se validan en la plataforma.
- Ideal para empezar antes de entornos menos guiados.

**En el curso:** práctica inicial en [Ethical Hacking](../../ethical-hacking/01-fundamentos-etica-y-laboratorio/README.md).

**Fuentes:** [TryHackMe](https://tryhackme.com/) · [TryHackMe — Docs](https://tryhackme.com/resources) · [NIST NICE](https://www.nist.gov/itl/applied-cybersecurity/nice)

---

### 14.5 VulnHub

VulnHub distribuye imágenes de máquinas virtuales vulnerables para descargar y ejecutar localmente. Cada imagen incluye un objetivo y una dificultad.

**Claves:**
- Se ejecuta en tu propio hipervisor, sin depender de Internet.
- Requiere aislar la red de la VM.
- Algunas imágenes son antiguas y usan software obsoleto.
- El reto termina al obtener la flag o el acceso indicado.
- Las soluciones de la comunidad sirven para contrastar.

**En el curso:** laboratorio local de [Ethical Hacking](../../ethical-hacking/01-fundamentos-etica-y-laboratorio/README.md).

**Fuentes:** [VulnHub](https://www.vulnhub.com/) · [NIST SP 800-115](https://csrc.nist.gov/pubs/sp/800/115/final) · [CISA — Best practices](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 14.6 picoCTF

picoCTF es una competición educativa de seguridad con retos de criptografía, forense, web, reversing y explotación, pensada para estudiantes.

**Claves:**
- Retos con dificultad progresiva y pistas.
- Se puede practicar todo el año con el archivo de retos.
- No requiere infraestructura propia.
- Enseña metodología más que herramientas concretas.
- Es un buen primer contacto con CTFs.

**En el curso:** práctica complementaria de [Ethical Hacking](../../ethical-hacking/README.md).

**Fuentes:** [picoCTF](https://picoctf.org/) · [Carnegie Mellon — picoCTF](https://www.cylab.cmu.edu/) · [NIST NICE](https://www.nist.gov/itl/applied-cybersecurity/nice)

---

### 14.7 pwn.college

pwn.college es un programa de aprendizaje práctico centrado en sistemas, binarios y explotación, con módulos y retos progresivos.

**Claves:**
- Enfoque en fundamentos de bajo nivel: memoria, ensamblador y kernel.
- Retos con validación automática.
- Requiere constancia y base de C.
- Complementa el estudio de arquitectura x86.
- Material abierto y gratuito.

**En el curso:** refuerzo de [Análisis de malware](../../malware-analysis/04-arquitectura-x86-y-memoria/README.md) y [Privilege Escalation](../../privilege-escalation/README.md).

**Fuentes:** [pwn.college](https://pwn.college/) · [Arizona State University](https://www.asu.edu/) · [NIST NICE](https://www.nist.gov/itl/applied-cybersecurity/nice)

---

### 14.8 SANS Holiday Hack Challenge

El SANS Holiday Hack Challenge es un evento anual gratuito con retos narrativos de seguridad, accesible para distintos niveles.

**Claves:**
- Combina historia, retos técnicos y comunidad.
- Se publica una vez al año y queda disponible después.
- Cubre cloud, web, forense y explotación.
- Incluye pistas y soluciones de la comunidad.
- Buena oportunidad para practicar en equipo.

**En el curso:** práctica estacional de [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [SANS — Holiday Hack](https://www.sans.org/mlp/holiday-hack-challenge/) · [SANS — Resources](https://www.sans.org/cyber-security-courses/) · [NIST NICE](https://www.nist.gov/itl/applied-cybersecurity/nice)

---

[Requisitos previos](../README.md) · [Siguiente: Programación](../15-programacion-y-automatizacion/README.md)
