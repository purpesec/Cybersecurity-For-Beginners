# Laboratorio: enumeración local guiada

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 02: Enumeración local del sistema](../README.md)

> [!CAUTION]
> Ejecuta este laboratorio únicamente en la máquina virtual Ubuntu aislada y con autorización expresa. El escenario creado por `setup.sh` no contiene rutas de escalada explotables; el objetivo es enumerar y registrar evidencia, no elevar privilegios.

## Alcance

El laboratorio reproduce un sistema Ubuntu con una cuenta sin privilegios, una cuenta de servicio no interactiva, un directorio compartido escribible y una entrada de `cron` que apunta a un script inexistente. El alumnado recorre las fuentes de datos del capítulo, identifica los objetos plantados y registra cada hallazgo con su evidencia y su hipótesis. No se ejecuta ningún exploit y no se modifica el sistema más allá de la preparación y la limpieza.

## Requisitos

- VM Ubuntu Server 22.04 LTS o superior en red host-only, con instantánea limpia.
- Una cuenta con privilegios administrativos para ejecutar `setup.sh`.
- Herramientas base: `sudo`, `cron`, `find`, `getcap`, `ss`, `systemctl`.
- Acceso a la cuenta `student`, creada por el script de preparación.

## Preparación

Desde la cuenta administrativa y dentro de esta carpeta, ejecuta el script de preparación:

```bash
sudo bash setup.sh
```

El script es idempotente: crear usuarios y archivos ya existentes no genera errores ni duplicados. Al terminar, cambia a la cuenta sin privilegios:

```bash
su - student
```

Todos los pasos siguientes se ejecutan como `student`. Los comandos que requieran leer archivos protegidos se marcan de forma explícita y se ejecutan desde la cuenta administrativa.

## 1. Identificar cuentas y grupos

Reconoce la identidad efectiva y localiza las cuentas relevantes:

```bash
whoami
id
id -a
grep -vE '/(nologin|false)$' /etc/passwd
getent passwd svc-backup student
getent group
ls -l /etc/shadow /etc/passwd /etc/group
```

Registra el UID, el GID y los grupos suplementarios de `student`, la shell de `svc-backup` y los permisos de `/etc/shadow`.

## 2. Listar procesos y servicios

Observa qué corre y con qué usuario:

```bash
ps aux
ps -eo user,pid,ppid,cmd --sort=user
systemctl list-units --type=service --state=running
ss -tulpn
ss -tulpn 2>/dev/null | grep 127.0.0.1
```

Anota los servicios que se ejecutan como `root` y cualquier puerto asociado a `127.0.0.1`.

## 3. Revisar montajes

Identifica sistemas de archivos y opciones de seguridad:

```bash
mount
findmnt -l
cat /etc/fstab
df -h
```

Comprueba si `/tmp` o `/home` están montados con `nosuid`, `nodev` o `noexec`, y si existe algún montaje de red.

## 4. Buscar binarios SUID y SGID

Enumera los binarios con bits especiales:

```bash
find / -perm -4000 -type f 2>/dev/null
find / -perm -2000 -type f 2>/dev/null
find / \( -perm -4000 -o -perm -2000 \) -type f -exec ls -l {} \; 2>/dev/null
```

Compara la lista con los binarios SUID habituales de Ubuntu. Un binario fuera de lo común o con propietario `root` es candidato a revisión.

## 5. Buscar archivos y directorios escribibles

Localiza puntos de influencia:

```bash
find / -type f -perm -0002 2>/dev/null
find / -type d -perm -0002 2>/dev/null
ls -ld /opt/shared
ls -l /opt/shared
```

Presta atención a `/opt/shared`: aparece como directorio con permisos `0777` y contiene un archivo de datos de ejemplo.

## 6. Revisar tareas programadas

Inspecciona las automatizaciones del sistema:

```bash
ls -la /etc/cron* /var/spool/cron/crontabs 2>/dev/null
cat /etc/crontab
cat /etc/cron.d/privesc-enum
systemctl list-timers --all
```

La entrada `privesc-enum` invoca un script que no existe; se trata de un señuelo destinado a ser descubierto, no de una vía de escalada.

## 7. Comprobar capabilities

Enumera binarios con capacidades asignadas:

```bash
getcap -r / 2>/dev/null
```

Registra cualquier capability sensible, como `cap_setuid` o `cap_dac_read_search`.

## 8. Registrar la evidencia

Vuelca las observaciones en una tabla con las columnas indicadas. Cada fila es una conclusión trazable.

| categoría | hallazgo | evidencia | hipótesis |
|---|---|---|---|
| Cuentas | `svc-backup` con shell `/usr/sbin/nologin` | `getent passwd svc-backup` | Cuenta de servicio no interactiva; verificar si algún proceso la usa. |
| Permisos | Directorio `/opt/shared` con modo `0777` | `ls -ld /opt/shared` | Si `root` lee o ejecuta contenido de ese directorio, existiría influencia sin privilegios. |
| Tareas programadas | Entrada `privesc-enum` en `/etc/cron.d` | `cat /etc/cron.d/privesc-enum` | La entrada apunta a un script inexistente; comprobar si la ruta es sustituible. |
| SUID | Conjunto de binarios SUID legítimos | Salida de `find / -perm -4000` | Comparar con la línea base de Ubuntu para detectar binarios añadidos. |

Conserva el comando exacto junto a cada salida. Una tabla sin la evidencia reproducible pierde su valor probatorio.

## Resultados esperados

- El usuario `svc-backup` existe y su shell es `/usr/sbin/nologin`.
- El directorio `/opt/shared` es escribible por cualquier usuario y contiene un archivo de datos de ejemplo.
- La entrada `/etc/cron.d/privesc-enum` referencia un script que no existe.
- La enumeración de SUID devuelve los binarios legítimos del sistema (`/usr/bin/passwd`, `/usr/bin/sudo`, entre otros) y el listado de capabilities aparece vacío o sin entradas sensibles.

## Validación

```text
[ ] La cuenta student no pertenece a sudo ni a otros grupos privilegiados
[ ] svc-backup aparece con shell /usr/sbin/nologin
[ ] /opt/shared tiene permisos 0777 y un archivo de datos
[ ] La entrada privesc-enum existe en /etc/cron.d
[ ] El script referenciado por la entrada no existe
[ ] La lista de binarios SUID se comparó con la línea base del sistema
[ ] Cada hallazgo quedó registrado con categoría, evidencia e hipótesis
```

## Limpieza

Ejecuta la limpieza desde la cuenta administrativa, no desde `student`. Elimina los objetos creados por la preparación:

```bash
sudo rm -f /etc/cron.d/privesc-enum
sudo rm -rf /opt/shared
sudo userdel -r svc-backup
sudo userdel -r student
```

Para restablecer por completo el entorno, restaura la instantánea limpia de la VM.

---

[Volver al capítulo](../README.md) | [Volver a Privilege Escalation](../../README.md) | [Inicio](../../../README.md)
