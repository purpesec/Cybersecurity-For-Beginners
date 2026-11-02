<p align="center">
  <img src="./images/portada-ciberseguridad.svg" alt="Ciberseguridad" width="100%">
</p>

# Rutas de ciberseguridad

Repositorio de formación en ciberseguridad con índices de temas, teoría, guías prácticas y laboratorios para entornos controlados. La sección de análisis de malware enlaza a los artículos publicados en el [blog de Purpe](https://purpesec.github.io/blog/).

[Catálogo](#catálogo) · [Cómo estudiar](#cómo-estudiar) · [Requisitos previos](./requisitos-previos/README.md) · [Laboratorio](./setup/README.md) · [Recursos](./resources/README.md)

## Qué incluye

- **Teoría:** las rutas existentes conservan sus sesiones; los artículos de análisis de malware publicados están enlazados desde el índice de su carpeta.
- **Laboratorios guiados:** prácticas paso a paso sobre máquinas virtuales aisladas, con el código vulnerable incluido cuando corresponde.
- **Guías de entorno:** configuración de red host-only, recursos por ruta y recomendaciones de hardware.
- **Material reutilizable:** referencias rápidas, diccionarios y scripts compartidos entre cursos.

## Requisitos previos

Antes de empezar una ruta conviene dominar el vocabulario base: sistemas, redes, protocolos, seguridad y amenazas. El bloque [Requisitos previos](./requisitos-previos/README.md) reúne los 289 conceptos del roadmap de ciberseguridad en 16 módulos, con definición, ideas clave y fuentes oficiales.

## Catálogo

| # | Ruta | Enfoque | Contenido | Estado |
|---|---|---|---|---|
| 1 | [CyberSOC](./cybersoc/) | Datos, defensa, SOC, Wazuh, Threat Intelligence y Threat Hunting | 12 sesiones + laboratorio integrador | `Disponible` |
| 2 | [Ethical Hacking](./ethical-hacking/) | Ética, OSINT, reconocimiento, enumeración y explotación controlada | 5 sesiones | `Disponible` |
| 3 | [Análisis de malware](./malware-analysis/) | Fundamentos, FLARE-VM, Windows Internals y análisis de ejecutables | Índice de artículos y laboratorios | `En desarrollo` |
| 4 | [Pentesting Web](./pentesting-web/) | HTTP, SQL Injection, Burp Suite y mitigaciones | 2 módulos | `Disponible` |
| 5 | [Privilege Escalation](./privilege-escalation/) | Enumeración y escalada de privilegios en Linux | 7 capítulos | `Disponible` |

## Ruta de aprendizaje sugerida

Las rutas pueden estudiarse de forma independiente. Este orden aprovecha los conceptos de la anterior:

```text
CyberSOC → Ethical Hacking → Pentesting Web → Privilege Escalation → Análisis de malware
```

1. **CyberSOC:** fundamentos de riesgo, defensa, SOC y tratamiento de datos.
2. **Ethical Hacking:** ética, OSINT, reconocimiento y explotación controlada.
3. **Pentesting Web:** HTTP, SQL Injection y pruebas sobre aplicaciones web.
4. **Privilege Escalation:** post-explotación y escalada de privilegios en Linux.
5. **Análisis de malware:** triaje, análisis dinámico y bases de reversing.

## Cómo estudiar

1. **Prepara el entorno.** Configura una red aislada y revisa los recursos de cada ruta en la [guía de laboratorio](./setup/README.md).
2. **Repasa los prerrequisitos.** Si un concepto no te resulta familiar, consúltalo en [Requisitos previos](./requisitos-previos/README.md) antes de continuar.
3. **Elige una ruta.** Revisa el `README.md` de la carpeta: ahí están el índice, los objetivos y los prerrequisitos.
4. **Estudia la teoría.** Sigue el enlace del índice: puede conducir a una sesión del repositorio o a un artículo del blog.
5. **Ejecuta el laboratorio.** Sigue la guía, registra comandos, salidas, capturas y conclusiones.
6. **Valida el cierre.** Comprueba los criterios de finalización antes de avanzar a la siguiente sesión.

## Estructura del repositorio

```text
.
├── cybersoc/                 Ruta de operaciones y defensa
├── ethical-hacking/          Ruta ofensiva introductoria
├── malware-analysis/         Análisis de malware e ingeniería inversa
├── pentesting-web/           Seguridad de aplicaciones web
├── privilege-escalation/     Escalada de privilegios en Linux
├── requisitos-previos/       Prerrequisitos del roadmap de ciberseguridad
├── images/                   Portadas y diagramas del repositorio
├── resources/                Material compartido entre rutas
├── setup/                    Configuración del laboratorio
└── README.md
```

Las rutas anteriores siguen normalmente esta convención; análisis de malware está migrando hacia un índice de artículos y una carpeta `labs/`:

```text
<ruta>/
├── README.md                 Índice, objetivos y orden de estudio
├── NN-nombre-del-tema/
│   ├── README.md             Teoría de la sesión
│   └── lab/                  Guía y recursos del laboratorio
└── ...
```

## Requisitos

Los materiales se ejecutan en máquinas virtuales. El modo de red depende de la práctica: consulta la guía correspondiente y usa una red interna aislada para el análisis de malware. Como referencia: 8 GB de RAM para la mayoría de laboratorios y 16 GB para CyberSOC, con 80 GB de disco libre para VMs e instantáneas. Los detalles por ruta están en [setup](./setup/README.md).

## Uso responsable

- No pruebes técnicas contra sistemas de terceros sin autorización.
- No conectes máquinas vulnerables directamente a Internet.
- No subas credenciales, datos personales, malware real ni archivos generados por las VMs.
- El código vulnerable de los laboratorios es intencional y educativo.

