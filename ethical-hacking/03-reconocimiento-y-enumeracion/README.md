# Sesión 03: Reconocimiento y enumeración

[Inicio](../../README.md) | [Ethical Hacking](../README.md) | [Laboratorio](./lab/)

## Objetivo

Descubrir y enumerar una máquina Metasploitable 2 dentro de una red aislada, pasando de una red desconocida a un inventario verificable de servicios expuestos.

## Resultados de aprendizaje

Al finalizar podrás:

- Identificar la red local y descubrir hosts activos.
- Diferenciar escaneo de puertos, detección de versiones y enumeración.
- Enumerar FTP, SMB, HTTP, RPC y NFS con herramientas específicas.
- Elaborar un inventario de superficie de ataque basado en evidencias.

## Fundamentos

El reconocimiento reduce un espacio amplio de búsqueda a objetivos concretos. El escaneo identifica puertos accesibles; la detección de versiones aporta contexto sobre el software; la enumeración consulta cada servicio para obtener usuarios, recursos compartidos, rutas o configuraciones visibles.

```text
Red -> Hosts activos -> Puertos -> Servicios y versiones -> Enumeración específica
```

Un puerto abierto no demuestra por sí mismo una vulnerabilidad. Cada resultado debe registrarse como observación y validarse antes de convertirlo en un hallazgo.

## Herramientas

| Propósito | Herramientas |
|---|---|
| Descubrimiento y escaneo | Nmap |
| FTP | cliente `ftp`, scripts NSE |
| SMB | `smbclient`, scripts NSE |
| HTTP | `curl`, WhatWeb, Gobuster |
| RPC y NFS | `rpcinfo`, `showmount` |

## Laboratorio

Sigue el [laboratorio de reconocimiento y enumeración con Metasploitable 2](./lab/). Trabajarás desde la identificación de red hasta la enumeración específica de los servicios encontrados.

## Evidencias

- Dirección IP del objetivo y método utilizado para identificarlo.
- Tabla de puertos, servicios y versiones.
- Resultados relevantes de FTP, SMB, HTTP, RPC y NFS.
- Resumen de la superficie de ataque sin realizar explotación.

## Criterio de finalización

La sesión está completa cuando puedes reconstruir el proceso desde una red desconocida y justificar qué herramienta usaste para cada servicio.

[Volver a Ethical Hacking](../README.md) | [Abrir laboratorio](./lab/) | [Inicio](../../README.md)
