#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Preparación del laboratorio 01 de Privilege Escalation.
#
# Este script deja el entorno base listo para el capítulo "De acceso inicial a
# post-explotación". NO introduce ninguna configuración vulnerable: solo crea
# una cuenta sin privilegios y un marcador de laboratorio.
#
# Uso (dentro de una VM Ubuntu aislada):
#   sudo bash setup.sh
# ---------------------------------------------------------------------------

LAB_USER="student"
LAB_DIR="/opt/privesc-lab"
MARKER_FILE="${LAB_DIR}/entorno-base.txt"

# Comprobar privilegios administrativos.
if [[ "${EUID}" -ne 0 ]]; then
    echo "Este script debe ejecutarse con sudo." >&2
    exit 1
fi

# Crear el usuario sin privilegios de forma idempotente.
if id -u "${LAB_USER}" >/dev/null 2>&1; then
    echo "El usuario '${LAB_USER}' ya existe; no se modifica."
else
    useradd -m -s /bin/bash "${LAB_USER}"
    echo "${LAB_USER}:${LAB_USER}" | chpasswd
    echo "Usuario '${LAB_USER}' creado con contraseña de laboratorio."
fi

# Garantizar que la cuenta no pertenece a grupos administrativos.
for group in sudo adm; do
    if getent group "${group}" >/dev/null 2>&1 && id -nG "${LAB_USER}" | grep -qw "${group}"; then
        gpasswd -d "${LAB_USER}" "${group}"
        echo "Se retiró a '${LAB_USER}' del grupo '${group}'."
    fi
done

# Crear el directorio del laboratorio con propietario root.
install -d -m 0755 -o root -g root "${LAB_DIR}"

# Dejar un marcador identificativo del escenario base.
cat > "${MARKER_FILE}" <<'EOF'
Laboratorio 01 - Privilege Escalation
Escenario: acceso inicial y reconocimiento del contexto.
Cuenta sin privilegios: student
Este escenario no contiene configuraciones vulnerables.
EOF
chmod 0644 "${MARKER_FILE}"

echo "Preparación completada."
echo "Marcador creado en ${MARKER_FILE}."
echo "Inicia sesión como '${LAB_USER}' para continuar con el laboratorio."
