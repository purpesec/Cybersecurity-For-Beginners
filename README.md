# Rutas de ciberseguridad

Repositorio de formación en ciberseguridad con cinco cursos organizados por sesiones, contenido práctico, guías paso a paso y laboratorios diseñados para ejecutarse en entornos controlados.

> [!CAUTION]
> Los laboratorios incluyen máquinas y aplicaciones vulnerables de forma intencional. Utiliza solo entornos aislados y sistemas propios o para los que tengas autorización expresa.

## Catálogo

| # | Ruta | Enfoque | Contenido disponible | Estado |
|---|---|---|---:|---|
| 1 | [CyberSOC](./cybersoc/) | Fundamentos de riesgo, SIEM, IDS y Threat Intelligence con CDB | 2 sesiones | Disponible |
| 2 | [Ethical Hacking](./ethical-hacking/) | Reconocimiento y enumeración de infraestructura | 1 módulo | En desarrollo |
| 3 | [Malware Analysis](./malware-analysis/) | Triage, análisis estático, formato PE y telemetría dinámica | 5 capítulos | Disponible |
| 4 | [Pentesting Web](./pentesting-web/) | Fundamentos web, HTTP, SQL Injection, Burp Suite y mitigaciones | 5 capítulos | Disponible |
| 5 | [Privilege Escalation](./privilege-escalation/) | Escalada de privilegios en Linux y Windows | Planificado | En preparación |

`Disponible` indica que el módulo cuenta con guía y laboratorio completo. `En desarrollo` indica contenido en redacción progresiva.

## Cómo estudiar

1. Prepara el entorno con la [guía de configuración](./setup/).
2. Elige una ruta y revisa sus prerrequisitos.
3. Estudia los fundamentos del tema y realiza el laboratorio guiado paso a paso.
4. Conserva las evidencias: comandos, salidas de terminal, capturas y notas de análisis.
5. Valida los criterios de finalización de la práctica.

## Estructura de cada módulo

```text
ruta/
|-- README.md                 # Índice y visión general de la ruta
`-- NN-tema/
    |-- README.md             # Fundamentos técnicos y objetivos
    `-- lab/
        |-- README.md         # Guía de laboratorio paso a paso
        `-- archivos-de-apoyo
```

## Estructura del repositorio

```text
.
|-- setup/                    # Preparación y aislamiento del laboratorio
|-- cybersoc/                 # Ruta CyberSOC
|-- ethical-hacking/          # Ruta Ethical Hacking
|-- malware-analysis/         # Ruta Malware Analysis
|-- pentesting-web/           # Ruta Pentesting Web
|-- privilege-escalation/     # Ruta Privilege Escalation
|-- images/                   # Diagramas compartidos
`-- resources/                # Material complementario
```

## Uso responsable

- No pruebes técnicas contra sistemas de terceros sin autorización.
- No conectes máquinas vulnerables directamente a Internet.
- No subas credenciales, capturas con datos personales, malware real ni archivos generados por las VMs.
- La presencia de código vulnerable en un laboratorio es intencional y se documenta como tal.

## Contribuir

Consulta [CONTRIBUTING.md](./CONTRIBUTING.md) para proponer mejoras o nuevos laboratorios. Para reportes de seguridad del repositorio, consulta [SECURITY.md](./SECURITY.md).
