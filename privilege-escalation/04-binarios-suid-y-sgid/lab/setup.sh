#!/usr/bin/env bash
#
# setup.sh - Laboratorio del capitulo 04: binarios SUID y SGID.
#
# Provisiona de forma idempotente un escenario vulnerable e intencional en una
# VM Ubuntu aislada. Crea la cuenta sin privilegios, instala un binario SUID de
# root a partir de /usr/bin/find y deposita un flag legible solo por root.
#
# Uso: sudo bash setup.sh
#
set -euo pipefail

STUDENT_USER="student"
SOURCE_BIN="/usr/bin/find"
TARGET_BIN="/usr/local/bin/sysfind"
TARGET_DIR="/usr/local/bin"
FLAG_FILE="/root/flag.txt"
FLAG_VALUE="PURPESEC{suid_root_escalation_lab_2026}"

# Verifica privilegios: el script debe ejecutarse como root.
if [[ "${EUID}" -ne 0 ]]; then
    echo "ERROR: ejecuta este script con sudo." >&2
    exit 1
fi

# Verifica que el binario de origen existe antes de continuar.
if [[ ! -f "${SOURCE_BIN}" ]]; then
    echo "ERROR: no se encuentra ${SOURCE_BIN}." >&2
    exit 1
fi

# Crea el usuario sin privilegios solo si no existe (idempotente).
if id "${STUDENT_USER}" >/dev/null 2>&1; then
    echo "[=] El usuario ${STUDENT_USER} ya existe; sin cambios."
else
    useradd --create-home --shell /bin/bash "${STUDENT_USER}"
    echo "${STUDENT_USER}:${STUDENT_USER}" | chpasswd
    echo "[+] Usuario ${STUDENT_USER} creado con contraseña de laboratorio."
fi

# Asegura el directorio destino y copia el binario con permisos SUID.
mkdir -p "${TARGET_DIR}"
cp -f "${SOURCE_BIN}" "${TARGET_BIN}"
chown root:root "${TARGET_BIN}"
chmod 4755 "${TARGET_BIN}"
echo "[+] ${TARGET_BIN} preparado con SUID root (4755)."

# Escribe el flag del laboratorio con lectura exclusiva para root.
umask 077
printf '%s\n' "${FLAG_VALUE}" > "${FLAG_FILE}"
chown root:root "${FLAG_FILE}"
chmod 0600 "${FLAG_FILE}"
echo "[+] Flag de laboratorio escrito en ${FLAG_FILE} (0600)."

# Resumen final del estado provisionado.
echo
echo "Resumen del laboratorio"
echo "  Usuario sin privilegios : ${STUDENT_USER}"
echo "  Binario SUID            : ${TARGET_BIN} ($(stat -c '%A %U:%G' "${TARGET_BIN}"))"
echo "  Flag protegido          : ${FLAG_FILE} (permisos 0600)"
echo
echo "Siguiente paso: revisa el README del laboratorio y enumerá los SUID como ${STUDENT_USER}."
