# Laboratorio: reconocer el contexto inicial

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 01](../README.md)

> [!CAUTION]
> Este laboratorio se ejecuta únicamente en una máquina virtual Ubuntu aislada, con red host-only o sin red, y sobre la que tengas autorización expresa. El script crea una cuenta local sin privilegios; no lo ejecutes en un sistema de producción ni en un equipo compartido.

## Alcance

El objetivo es reconocer el punto de partida de una escalada de privilegios, no escalar. Al terminar, se habrá caracterizado la identidad de la cuenta `student`, el entorno de ejecución, la virtualización, la base de usuarios y las capacidades del proceso actual. Todas las comprobaciones son de solo lectura o de efecto nulo sobre la configuración del sistema.

## Requisitos

- Máquina virtual Ubuntu Server 22.04 LTS o superior, aislada.
- Instantánea (*snapshot*) limpia creada antes de la práctica.
- Acceso a `sudo` desde una cuenta administradora para ejecutar la preparación.
- El usuario `student` será creado por `setup.sh` sin privilegios administrativos.
- Contraseña local del laboratorio: `student` (solo dentro de la VM aislada).

## Preparación

Copia la carpeta del laboratorio a la VM y ejecuta el script de preparación con `sudo`:

```bash
sudo bash setup.sh
```

El script es idempotente, crea el usuario `student` si no existe, garantiza que no pertenece a grupos administrativos y deja un marcador en `/opt/privesc-lab/`. No introduce ninguna configuración vulnerable.

Inicia sesión como la cuenta sin privilegios:

```bash
su - student
```

## 1. Confirmar la identidad actual

Comprueba con qué cuenta se está ejecutando la sesión y qué identificadores arrastra:

```bash
whoami
id
```

Resultado esperado:

```text
student
uid=1000(student) gid=1000(student) groups=1000(student)
```

El UID `1000` corresponde a una cuenta ordinaria. No aparecen grupos administrativos como `sudo` o `adm`.

## 2. Comparar UID real y UID efectivo

El UID real identifica quién lanzó el proceso; el UID efectivo decide los permisos. En una shell sin SUID ambos coinciden:

```bash
id -ru
id -u
```

Resultado esperado:

```text
1000
1000
```

Ahora observa un binario con el bit SUID activado. El propietario es `root` y la `s` en los permisos indica que su UID efectivo será 0 durante la ejecución:

```bash
ls -l /usr/bin/passwd
```

Resultado esperado:

```text
-rwsr-xr-x 1 root root 68208 ... /usr/bin/passwd
```

La demostración directa: `passwd` puede leer `/etc/shadow` porque se ejecuta con UID efectivo 0, mientras que la shell de `student` no puede:

```bash
passwd -S
head -n 1 /etc/shadow
```

Resultado esperado:

```text
student P ... 0 99999 7 -1
head: cannot open '/etc/shadow' for reading: Permission denied
```

La misma cuenta ejecuta ambos comandos, pero solo el binario SUID accede a un archivo reservado a `root`. Esa diferencia entre ejecutar comandos y disponer de una identidad privilegiada es el objeto de este capítulo.

## 3. Caracterizar el entorno de la shell

Registra el intérprete, la máscara de permisos y los grupos de la cuenta:

```bash
echo $SHELL
umask
groups
```

Resultado esperado:

```text
/bin/bash
0022
student
```

Una `umask` de `0022` implica que los archivos nuevos nacen como `644` y los directorios como `755`, sin escritura para otros usuarios.

## 4. Comprobar privilegios delegados

Verifica que la cuenta no dispone de reglas de `sudo`:

```bash
sudo -n -l
echo "código de salida: $?"
```

Resultado esperado (puede variar el texto exacto):

```text
sudo: a password is required
código de salida: 1
```

En la mayoría de las ejecuciones no se pedirá contraseña porque `-n` desactiva la petición interactiva; si se ejecuta `sudo -l` sin `-n`, el sistema responderá que `student` no está en el archivo `sudoers`. En cualquier caso, la salida confirma que no hay privilegios delegados.

## 5. Identificar kernel y distribución

Reconoce la plataforma sobre la que se trabaja:

```bash
uname -a
cat /etc/os-release
```

Resultado esperado (versiones orientativas):

```text
Linux ubuntu-lab 5.15.0-... #... SMP ... x86_64 GNU/Linux
PRETTY_NAME="Ubuntu 22.04.x LTS"
...
```

La versión del kernel es relevante porque determina qué vulnerabilidades del propio núcleo podrían aplicar en fases posteriores. En este capítulo solo se registra, sin explotarla.

## 6. Distinguir máquina virtual y contenedor

Determina el tipo de virtualización y si se ejecuta dentro de un contenedor:

```bash
systemd-detect-virt
test -e /.dockerenv && echo "marcador de Docker presente" || echo "sin marcador de Docker"
cat /proc/1/cgroup
```

Resultado esperado:

```text
kvm
sin marcador de Docker
0::/init.scope
```

`systemd-detect-virt` puede devolver `kvm`, `oracle`, `vmware` u otro hipervisor según la plataforma anfitriona. La ausencia de `/.dockerenv` y un `cgroup` de sistema completo indican que se está ante una máquina virtual y no ante un contenedor.

## 7. Revisar las capacidades del proceso

Inspecciona los conjuntos de capacidades del proceso que ejecuta la shell:

```bash
grep -i cap /proc/self/status
```

Resultado esperado:

```text
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 000001ffffffffff
CapAmb: 0000000000000000
```

Un `CapEff` a cero confirma que el proceso no tiene capacidades elevadas. `CapBnd` muestra el límite máximo que el kernel permitiría; un proceso ordinario no debería poder superarlo.

## 8. Inventariar usuarios y grupos locales

Registra la base de identidades del sistema, que se usará como referencia en el capítulo 02:

```bash
cat /etc/passwd
cat /etc/group
```

Observa en `/etc/passwd` las cuentas con UID bajo (por debajo de 1000 suelen ser cuentas de sistema) y el UID `1000` de `student`. En `/etc/group`, localiza el grupo `sudo` y confirma que `student` no figura en él.

```bash
grep -E '^(sudo|adm):' /etc/group
id -nG student
```

Resultado esperado:

```text
sudo:x:27:
adm:x:4:...
student
```

## Resultados esperados

Al finalizar la práctica debe existir evidencia de que:

- La sesión se ejecuta como `student`, con UID real y efectivo iguales a `1000`.
- Un binario SUID como `/usr/bin/passwd` accede a `/etc/shadow` con UID efectivo 0, mientras la shell no puede.
- La `umask` y el intérprete corresponden a una cuenta estándar de Ubuntu.
- `sudo -n -l` no concede ninguna regla a `student`.
- La plataforma se identifica como máquina virtual y no como contenedor.
- El proceso actual no posee capacidades efectivas.
- `student` no pertenece a grupos administrativos.

## Validación

Señales técnicas de éxito:

```text
[ ] whoami devuelve student
[ ] id -ru y id -u devuelven 1000
[ ] /usr/bin/passwd muestra el bit SUID y passwd -S funciona
[ ] head /etc/shadow devuelve Permission denied
[ ] sudo -n -l falla o no concede reglas
[ ] systemd-detect-virt devuelve un hipervisor
[ ] /.dockerenv no existe
[ ] CapEff es 0000000000000000
[ ] id -nG student no incluye sudo ni adm
```

La validación no busca aprobar un ejercicio, sino confirmar que el punto de partida ha quedado caracterizado con evidencia reproducible.

## Limpieza

La preparación no altera configuraciones del sistema, por lo que la limpieza consiste en revertir la instantánea creada antes de la práctica. Si se desea eliminar la cuenta del laboratorio sin restaurar la instantánea:

```bash
sudo userdel -r student
```

Si además se quiere retirar el marcador del laboratorio:

```bash
sudo rm -rf /opt/privesc-lab
```

---

[Volver al capítulo](../README.md) | [Volver a Privilege Escalation](../../README.md) | [Inicio](../../../README.md)
