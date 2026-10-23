<p align="center">
  <img src="./images/portada-ciberseguridad.svg" alt="Ciberseguridad" width="100%">
</p>

# Rutas de ciberseguridad

Repositorio de formaciÃ³n en ciberseguridad con cursos organizados por sesiones, teorÃ­a, guÃ­as prÃ¡cticas y laboratorios para entornos controlados.

[CatÃ¡logo](#catÃ¡logo) Â· [CÃ³mo estudiar](#cÃ³mo-estudiar) Â· [Laboratorio](./setup/README.md) Â· [Recursos](./resources/README.md)

## QuÃ© incluye

- **TeorÃ­a por sesiones:** cada tema se desarrolla en su propio `README.md`, con conceptos, comandos y criterios de finalizaciÃ³n.
- **Laboratorios guiados:** prÃ¡cticas paso a paso sobre mÃ¡quinas virtuales aisladas, con el cÃ³digo vulnerable incluido cuando corresponde.
- **GuÃ­as de entorno:** configuraciÃ³n de red host-only, recursos por ruta y recomendaciones de hardware.
- **Material reutilizable:** referencias rÃ¡pidas, diccionarios y scripts compartidos entre cursos.

## CatÃ¡logo

| # | Ruta | Enfoque | Contenido | Estado |
|---|---|---|---|---|
| 1 | [CyberSOC](./cybersoc/) | Datos, defensa, SOC, Wazuh, Threat Intelligence y Threat Hunting | 12 sesiones + laboratorio integrador | `Disponible` |
| 2 | [Ethical Hacking](./ethical-hacking/) | Ã‰tica, OSINT, reconocimiento, enumeraciÃ³n y explotaciÃ³n controlada | 5 sesiones | `Disponible` |
| 3 | [C-MA: AnÃ¡lisis de malware](./malware-analysis/) | FLARE-VM y REMnux, Windows internals, arquitectura x86, anÃ¡lisis estÃ¡tico y bases de ensamblador | 7 bloques de teorÃ­a | `En desarrollo` |
| 4 | [Pentesting Web](./pentesting-web/) | HTTP, SQL Injection, Burp Suite y mitigaciones | 2 mÃ³dulos | `Disponible` |
| 5 | [Privilege Escalation](./privilege-escalation/) | EnumeraciÃ³n y escalada de privilegios en Linux | 7 capÃ­tulos | `Disponible` |

## Ruta de aprendizaje sugerida

Las rutas pueden estudiarse de forma independiente, pero este orden aprovecha los conceptos de la anterior:

```text
CyberSOC  â†’  Ethical Hacking  â†’  Pentesting Web  â†’  Privilege Escalation  â†’  AnÃ¡lisis de malware
defensa       reconocimiento      aplicaciÃ³n web     post-explotaciÃ³n Linux    artefactos y reversing
```

## CÃ³mo estudiar

1. **Prepara el entorno.** Configura una red aislada y revisa los recursos de cada ruta en la [guÃ­a de laboratorio](./setup/README.md).
2. **Elige una ruta.** Revisa el `README.md` de la carpeta: ahÃ­ estÃ¡n el Ã­ndice, los objetivos y los prerrequisitos.
3. **Estudia la teorÃ­a.** Lee la sesiÃ³n completa antes de ejecutar comandos.
4. **Ejecuta el laboratorio.** Sigue la guÃ­a, registra comandos, salidas, capturas y conclusiones.
5. **Valida el cierre.** Comprueba los criterios de finalizaciÃ³n antes de avanzar a la siguiente sesiÃ³n.

## Estructura del repositorio

```text
.
â”œâ”€â”€ cybersoc/                 Ruta de operaciones y defensa
â”œâ”€â”€ ethical-hacking/          Ruta ofensiva introductoria
â”œâ”€â”€ malware-analysis/         AnÃ¡lisis de malware e ingenierÃ­a inversa
â”œâ”€â”€ pentesting-web/           Seguridad de aplicaciones web
â”œâ”€â”€ privilege-escalation/     Escalada de privilegios en Linux
â”œâ”€â”€ images/                   Portadas y diagramas del repositorio
â”œâ”€â”€ resources/                Material compartido entre rutas
â”œâ”€â”€ setup/                    ConfiguraciÃ³n del laboratorio
â””â”€â”€ README.md
```

Cada ruta sigue la misma convenciÃ³n:

```text
<ruta>/
â”œâ”€â”€ README.md                 Ãndice, objetivos y orden de estudio
â”œâ”€â”€ NN-nombre-del-tema/
â”‚   â”œâ”€â”€ README.md             TeorÃ­a de la sesiÃ³n
â”‚   â””â”€â”€ lab/                  GuÃ­a y recursos del laboratorio
â””â”€â”€ ...
```

## Requisitos

Los materiales se ejecutan en mÃ¡quinas virtuales con red host-only. Como referencia: 8 GB de RAM para la mayorÃ­a de laboratorios y 16 GB para CyberSOC, con 80 GB de disco libre para VMs e instantÃ¡neas. Los detalles por ruta estÃ¡n en [setup](./setup/README.md).

## Uso responsable

- No pruebes tÃ©cnicas contra sistemas de terceros sin autorizaciÃ³n.
- No conectes mÃ¡quinas vulnerables directamente a Internet.
- No subas credenciales, datos personales, malware real ni archivos generados por las VMs.
- El cÃ³digo vulnerable de los laboratorios es intencional y educativo.

