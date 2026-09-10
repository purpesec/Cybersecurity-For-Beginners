#!/usr/bin/env bash
#
# setup.sh - Aprovisiona el laboratorio "regla de sudo insegura".
#
# Crea de forma intencional una configuración vulnerable:
#   - la cuenta sin privilegios "student" (si no existe);
#   - /etc/sudoers.d/privesc-lab con una regla NOPASSWD sobre awk;
#   - /root/flag.txt con un valor de laboratorio y permisos 0600.
#
# Uso:
#   sudo bash setup.sh
#
# Ejecútalo únicamente en una VM Ubuntu aislada.

set -euo pipefail

# --- Comprobaciones previas -------------------------------------------------

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root (usa: sudo bash setup.sh)." >&2
    exit 1
fi

# La ruta real de awk puede variar según la distribución; nunca asumir /usr/bin/awk.
awk_path="$(command -v awk || true)"
if [ -z "${awk_path}" ]; then
    echo "No se encontró el binario awk en el sistema." >&2
    exit 1
fi

# Valor de laboratorio, no es un secreto real.
flag_value="purpesec{sudo_awk_otorga_root}"

# --- Cuenta sin privilegios -------------------------------------------------

# Crear la cuenta student si todavía no existe. No se invoca sudo: el script
# ya se ejecuta como root. La cuenta queda sin contraseña; se accede con
# "sudo su - student" desde una sesión con privilegios.
if ! id -u student >/dev/null 2>&1; then
    useradd --create-home --shell /bin/bash student
    echo "student:student" | chpasswd
    echo "Cuenta 'student' creada con contraseña de laboratorio."
else
    echo "La cuenta 'student' ya existe; no se modifica."
fi

# --- Regla de sudoers -------------------------------------------------------

# Asegurar que el directorio de fragmentos existe con los permisos correctos.
install -d -m 0755 -o root -g root /etc/sudoers.d

# Escribir la regla en un archivo temporal y validarla antes de instalarla.
tmp_sudoers="$(mktemp)"
trap 'rm -f "${tmp_sudoers}"' EXIT

printf '%s\n' \
    "student ALL=(root) NOPASSWD: ${awk_path}" \
    > "${tmp_sudoers}"

if ! visudo -cf "${tmp_sudoers}" >/dev/null; then
    echo "La regla de sudoers no superó la validación de visudo." >&2
    exit 1
fi

# Instalar el fragmento con la propiedad y los permisos exigidos (0440).
install -m 0440 -o root -g root "${tmp_sudoers}" /etc/sudoers.d/privesc-lab

# Validar de nuevo el archivo ya instalado en disco.
visudo -cf /etc/sudoers.d/privesc-lab >/dev/null

# --- Archivo reservado a root ----------------------------------------------

# /root suele existir en Ubuntu con modo 0700; solo se crea si faltara.
if [ ! -d /root ]; then
    install -d -m 0700 -o root -g root /root
fi

# Crear el objetivo con propiedad de root y permisos 0600.
printf '%s\n' "${flag_value}" | tee /root/flag.txt >/dev/null
chown root:root /root/flag.txt
chmod 0600 /root/flag.txt

# --- Resumen ----------------------------------------------------------------

echo
echo "Laboratorio aprovisionado correctamente:"
echo "  - Cuenta sin privilegios : student"
echo "  - Binario autorizado     : ${awk_path}"
echo "  - Fragmento sudoers      : /etc/sudoers.d/privesc-lab"
echo "  - Regla aplicada         : student ALL=(root) NOPASSWD: ${awk_path}"
echo "  - Archivo de objetivo    : /root/flag.txt (0600, root:root)"
echo
echo "Inicia sesión como student con: sudo su - student"
