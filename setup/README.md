# Configuración del laboratorio

[Inicio](../README.md)

Esta guía define el entorno mínimo para ejecutar los materiales publicados. Los requisitos pueden crecer a medida que se incorporen nuevas sesiones.

## Requisitos del equipo anfitrion

- VirtualBox, VMware o Hyper-V con virtualización habilitada.
- 16 GB de RAM recomendados para CyberSOC; 8 GB para los demas labs actuales.
- 80 GB de disco libre para trabajar con varias VMs y snapshots.
- Una red virtual interna o host-only.
- Acceso a Internet solo durante la instalación de herramientas y nunca desde máquinas vulnerables sin control.

## Entornos actuales

| Ruta | Entorno probado | Recursos orientativos | Red |
|---|---|---|---|
| CyberSOC | 2 VMs Ubuntu Server 22.04 LTS | SOC: 4 vCPU, 8 GB RAM; cyberrange: 2 vCPU, 4 GB RAM | Host-only |
| Ethical Hacking | Kali Linux + Metasploitable 2 | Kali: 2 vCPU, 4 GB RAM; objetivo: 1 vCPU, 1 GB RAM | Host-only |
| Malware Analysis | VM Linux con GCC y binutils | 2 vCPU, 2 GB RAM | Sin red durante el analisis |
| Pentesting Web | Debian, Ubuntu o Kali con Apache, MariaDB y PHP | 2 vCPU, 4 GB RAM | Host-only |
| Privilege Escalation | 1 VM Ubuntu Server 22.04 LTS | 2 vCPU, 4 GB RAM | Host-only |

## Configurar una red aislada

1. Crea una red host-only, por ejemplo `192.168.56.0/24`.
2. Conecta solo las VMs que participen en el laboratorio.
3. Desactiva el modo bridge en las máquinas vulnerables.
4. Comprueba que una VM objetivo no sea accesible desde otros equipos de tu red local.
5. Crea un snapshot limpio antes de iniciar la práctica.

## Comprobaciones

En Linux, revisa las interfaces y rutas:

```bash
ip -br address
ip route
```

Desde la máquina atacante, comprueba solo la conectividad con el objetivo del laboratorio:

```bash
ping -c 2 192.168.56.20
```

## Reglas de trabajo

1. Usa unicamente sistemas propios o expresamente autorizados.
2. Mantén las máquinas vulnerables en una red interna o host-only.
3. Toma snapshots antes de cambios importantes.
4. No reutilices contrasenas reales dentro del laboratorio.
5. Elimina capturas, logs o bases de datos que contengan información sensible.

## Siguiente paso

Vuelve al [catalogo de rutas](../README.md) y abre el curso que quieras comenzar.
